import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/changed_data/changed_data.dart';
import 'package:mobile_app/domain/model/player/playlist_data.dart';
import 'package:mobile_app/domain/model/sort_and_filter/filter_type.dart';
import 'package:mobile_app/domain/model/tale/data/tale_screen_data.dart';
import 'package:mobile_app/domain/model/tale/tale.dart';
import 'package:mobile_app/domain/model/tale/tale_audio.dart';
import 'package:mobile_app/domain/model/tale/tale_more_item.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/tracking/tracker.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/infrastructure/helper/analytic/crash_analytic.dart';
import 'package:mobile_app/infrastructure/use_case/email/report_tale_use_case.dart';
import 'package:mobile_app/infrastructure/use_case/tale/change_tale_fav.dart';
import 'package:mobile_app/infrastructure/use_case/tale/listen_playlist_tale_changed_use_case.dart';
import 'package:mobile_app/infrastructure/use_case/tale/listen_tale_changes_use_case.dart';
import 'package:mobile_app/infrastructure/use_case/tale/mark_tale_watched_use_case.dart';
import 'package:mobile_app/infrastructure/use_case/tale/set_audio_playlist_use_case.dart';
import 'package:mobile_app/presentation/navigation/dialog/dialog_controller.dart';
import 'package:mobile_app/presentation/navigation/screen/screen_controller.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/domain/model/settings/settings_page_type.dart';

part 'tale_screen_manager.freezed.dart';

part 'tale_screen_state.dart';

typedef OnTaleUpdated = Function(Tale tale);

abstract class UpdateTaleCallback {
  void onTaleChanged(Tale tale, IntPositive chapterIndex);

  Future<void> close();
}

@lazySingleton
class TaleScreenManager extends Cubit<TaleScreenState> {
  final ScreenController _screenController;
  final DialogController _dialogController;
  final UseCase<ChangeTaleFavInput, Dry> _changeFavUseCase;
  final UseCase<ListenTaleChangesInput, ChangedData<Tale, TaleId>>
      _listenTaleChangesUseCase;
  final UseCase<Dry, ListenPlaylistChangedOutput>
      _listenPlaylistTaleChangedUseCase;
  final _taleUpdatedCallbacks = <UpdateTaleCallback>{};
  final UseCase<SetAudioPlaylistInput, Dry> _setAudioPlaylistUseCase;
  final UseCase<PlaylistItemData, bool> _cacheAudioUseCase;
  final UseCase<Dry, Option<PlaylistItemData>> _getNextPlaylistItemUseCase;
  final UseCase<TaleId, MarkTaleWatchedOutput> _markTaleAsWatchedUseCase;
  final UseCase<Tale, ReportTaleOutput> _reportTaleUseCase;
  final CrashAnalytic _crashAnalytic;
  final Tracker _tracker;

  TaleScreenManager(
    this._screenController,
    this._dialogController,
    this._changeFavUseCase,
    this._listenTaleChangesUseCase,
    this._setAudioPlaylistUseCase,
    this._crashAnalytic,
    this._listenPlaylistTaleChangedUseCase,
    this._getNextPlaylistItemUseCase,
    this._cacheAudioUseCase,
    this._markTaleAsWatchedUseCase,
    this._reportTaleUseCase,
    this._tracker,
  ) : super(const TaleScreenState.initial()) {
    _listenPlaylistAndCache();
  }

  UseCaseSubscription? _taleSubscription;
  UseCaseSubscription? _playlistChangesSubscription;
  UseCaseSubscription? _playlistCacheSubscription;
  late TalePageType _pageType;

  var _isStopped = true;

  bool get isStopped => _isStopped;
  Timer? _markAsWatchedTimer;

  TaleScreenStateReady get _stateReady => state as TaleScreenStateReady;

  @override
  Future<void> close() async {
    await _playlistCacheSubscription?.cancel();
    super.close();
  }

  Future<void> stop() async {
    _isStopped = true;
    await _playlistChangesSubscription?.cancel();
    await _taleSubscription?.cancel();
    for (var element in _taleUpdatedCallbacks) {
      await element.close();
    }
    _taleUpdatedCallbacks.clear();
    _markAsWatchedTimer?.cancel();
  }

  void init(
    Tale tale,
    bool openAudio,
    TaleFilterType? filterType,
  ) async {
    _isStopped = false;
    _pageType = openAudio ? TalePageType.audio : TalePageType.text;
    await _setPlaylist(tale.id, filterType);
    _updateState(
      tale,
      chapterIndex: IntPositive.zero,
      refreshListener: true,
    );
    _listenPlaylistChanges();
    tale.chapters.first.audioOption.fold(
      () => null,
      (audio) => _cacheCurrentAndNextAudio(tale.id, audio),
    );
  }

  void addTaleUpdateListener(UpdateTaleCallback updateTaleCallback) {
    _taleUpdatedCallbacks.add(updateTaleCallback);
    final tale = _stateReady.tale;
    updateTaleCallback.onTaleChanged(
      tale,
      _stateReady.chapterIndex,
    );
  }

  void onBottomActionPressed(TaleBottomBarAction action) {
    TrackingEvent? event;
    switch (action) {
      case TaleBottomBarAction.back:
        _screenController.pop();
        break;
      case TaleBottomBarAction.fav:
        event = TrackingEvents.taleBottomFavPressed;
        _changeFav();
        break;
      case TaleBottomBarAction.change:
        event = TrackingEvents.taleBottomChangeTypePressed;
        _changePageType();
        break;
      case TaleBottomBarAction.more:
        event = TrackingEvents.taleBottomMorePressed;
        _showMoreDialog();
        break;
      case TaleBottomBarAction.crew:
        event = TrackingEvents.taleBottomCrewPressed;
        _onCrewPressed();
        break;
      case TaleBottomBarAction.rating:
        event = TrackingEvents.taleBottomRatingPressed;
        _onRatingPressed();
        break;
      case TaleBottomBarAction.tableOfContent:
        _dialogController.showWIP();
        break;
    }
    if (event != null) {
      _tracker.event(event);
    }
  }

  void _updateState(
    Tale tale, {
    required IntPositive chapterIndex,
    required bool refreshListener,
  }) {
    if (_pageType.isText && !tale.hasText) {
      _pageType = TalePageType.audio;
    } else if (_pageType.isAudio && !tale.hasAudio) {
      _pageType = TalePageType.text;
    }
    _crashAnalytic.setKey(
      key: 'currentTaleId',
      value: tale.id.get().toString(),
    );

    for (final callback in _taleUpdatedCallbacks) {
      callback.onTaleChanged(tale, chapterIndex);
    }

    final stateReady = TaleScreenState.ready(
      tale: tale,
      pageType: _pageType,
      switchType: _getSwitchType(tale, _pageType),
      chapterIndex: chapterIndex,
    ) as TaleScreenStateReady;

    emit(stateReady);

    if (refreshListener) {
      _setListeners(tale.id, chapterIndex);
    }
  }

  void _setListeners(TaleId taleId, IntPositive chapterIndex) async {
    await _taleSubscription?.cancel();
    _taleSubscription = _listenTaleChangesUseCase.listen(
      ListenTaleChangesInput(taleId),
      (ChangedData<Tale, TaleId> data) => data.map(deleted: (_) {
        _screenController.pop();
      }, updated: (Tale tale) {
        final isAnotherTale = taleId != tale.id;
        _updateState(
          tale,
          chapterIndex: chapterIndex,
          refreshListener: isAnotherTale,
        );
      }),
    );

    _markAsWatchedTimer?.cancel();
    _markAsWatchedTimer = Timer(
      R.durations.markTaleWatchedTimeOut,
      () => _markTaleAsWatchedUseCase.call(taleId),
    );
  }

  void _changeFav() {
    final tale = _stateReady.tale;
    final input = ChangeTaleFavInput(tale.id, !tale.isFavorite);
    _changeFavUseCase.call(input);
  }

  void _changePageType() {
    _pageType = _pageType.toggle();
    _updateState(
      _stateReady.tale,
      chapterIndex: _stateReady.chapterIndex,
      refreshListener: false,
    );
  }

  void _listenPlaylistChanges() {
    _playlistChangesSubscription = _listenPlaylistTaleChangedUseCase.listen(
      dry,
      (ListenPlaylistChangedOutput output) {
        if (!_pageType.isAudio) return;
        _updateState(
          output.tale,
          chapterIndex: output.audio.chapterIndex,
          refreshListener: true,
        );
      },
    );
  }

  TaleSwitchType _getSwitchType(Tale tale, TalePageType pageType) {
    switch (pageType) {
      case TalePageType.text:
        return tale.hasAudio ? TaleSwitchType.audio : TaleSwitchType.none;
      case TalePageType.audio:
        return tale.hasText ? TaleSwitchType.text : TaleSwitchType.none;
    }
  }

  void _listenPlaylistAndCache() {
    _playlistCacheSubscription = _listenPlaylistTaleChangedUseCase.listen(
      dry,
      (ListenPlaylistChangedOutput output) {
        _cacheCurrentAndNextAudio(output.tale.id, output.audio);
      },
    );
  }

  void _cacheCurrentAndNextAudio(TaleId id, TaleAudio audio) async {
    final input = PlaylistItemData(id, audio);
    await _cacheAudioUseCase.call(input);
    // return;
    final nextItemOption = await _getNextPlaylistItemUseCase.call(dry);
    nextItemOption.fold(
      () => null,
      _cacheAudioUseCase.call,
    );
  }

  void _showMoreDialog() {
    late final TrackingEvent event;
    void callback(TaleMoreType type) {
      switch (type) {
        case TaleMoreType.settings:
          event = TrackingEvents.taleMoreMenuSettingsPressed;
          final openType = _pageType.isAudio
              ? SettingsPageType.audio
              : SettingsPageType.text;
          _screenController.openSettings(openType: openType);
          break;
        case TaleMoreType.reportTale:
          event = TrackingEvents.taleMoreMenuReportPressed;
          _showReportTaleDialog();
          break;
      }
      _tracker.event(event);
    }

    _dialogController.showTaleMore(onTaleMoreItemPressed: callback);
  }

  void _showReportTaleDialog() =>
      _dialogController.showTaleReport(onReportPressed: () {
        _tracker.event(TrackingEvents.taleReportConfirmPressed);
        _reportTaleUseCase.call(_stateReady.tale);
      });

  void _onCrewPressed() {
    final tale = _stateReady.tale;
    _screenController.openTaleCrew(
      name: tale.name,
      crew: (tale.crewOption as Some).value,
    );
  }

  void _onRatingPressed() {
    final tale = _stateReady.tale;
    _dialogController.showTaleRating(
      name: tale.name,
      data: (tale.ratingOption as Some).value,
    );
  }

  Future<Unit> _setPlaylist(
    TaleId currentTaleId,
    TaleFilterType? filterType,
  ) async {
    final input = SetAudioPlaylistInput(currentTaleId, filterType);
    await _setAudioPlaylistUseCase.call(input);
    return unit;
  }
}
