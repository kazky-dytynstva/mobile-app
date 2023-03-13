import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/helper/countdown_service.dart';
import 'package:mobile_app/domain/model/play_audio_action/play_audio_action.dart';
import 'package:mobile_app/domain/model/play_audio_status/play_audio_status.dart';
import 'package:mobile_app/domain/model/player/countdown_time.dart';
import 'package:mobile_app/domain/model/player/loop_mode.dart';
import 'package:mobile_app/domain/model/rating/rating_type.dart';
import 'package:mobile_app/domain/model/tale/tale.dart';
import 'package:mobile_app/domain/model/tale/tale_audio.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/model/tale_sort_and_filter/tale_filter_item_data.dart';
import 'package:mobile_app/domain/model/tale_sort_and_filter/tale_sort_item_data.dart';
import 'package:mobile_app/domain/navigation/snackbar_controller.dart';
import 'package:mobile_app/domain/tracking/tracker.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/data/helper/player/audio_player.dart';
import 'package:mobile_app/data/use_case/loop_mode/save_loop_mode_use_case.dart';
import 'package:mobile_app/data/use_case/loop_mode/set_initial_loop_mode_use_case.dart';
import 'package:mobile_app/data/use_case/tale/rate_tale_use_case.dart';
import 'package:mobile_app/presentation/navigation/dialog/dialog_controller.dart';
import 'package:mobile_app/presentation/view/screen/tale/manager/tale_screen_manager.dart';

part 'listen_page_manager.freezed.dart';

part 'listen_page_state.dart';

@injectable
class ListenPageManager extends Cubit<ListenPageState>
    implements UpdateTaleCallback {
  final DialogController _dialogController;
  final SnackbarController _snackbarController;
  final AudioPlayer _audioPlayer;
  final CountdownService _countdownService;
  final UseCase<RateTaleInput, bool> _rateTaleUseCase;
  final UseCase<Dry, SetInitialLoopModeOutput> _setInitialLoopModeUseCase;
  final UseCase<PlayerLoopMode, SaveLoopModeOutput> _saveLoopModeUseCase;
  final Tracker _tracker;

  ListenPageManager(
    this._audioPlayer,
    this._countdownService,
    this._dialogController,
    this._snackbarController,
    this._setInitialLoopModeUseCase,
    this._rateTaleUseCase,
    this._saveLoopModeUseCase,
    this._tracker,
  ) : super(const ListenPageState.initial());

  final _subscriptions = <StreamSubscription>[];
  late TaleId _taleId;
  late TaleAudio _taleAudio;
  Duration _position = Duration.zero;
  PlayAudioStatus _playStatus = PlayAudioStatus.idle;
  PlayerLoopMode _loopMode = PlayerLoopMode.off;
  bool _showTaleRating = false;

  @override
  Future<void> close() async {
    for (var subscription in _subscriptions) {
      await subscription.cancel();
    }
    if (state is ListenPageStateReady &&
        (state as ListenPageStateReady).playStatus.isPlaying == false) {
      await _audioPlayer.reset();
    }
    return super.close();
  }

  @override
  void onTaleChanged(Tale tale, IntPositive chapterIndex) {
    _taleId = tale.id;
    tale.chapters[chapterIndex.get()].audioOption.fold(() => {}, (audio) {
      _listenPlayer();
      _taleAudio = audio;
      _updateState(
        audio: audio,
        showRateTale: !tale.isRated,
      );
    });
  }

  void onAudioActionPressed(PlayAudioAction action) {
    if (action.isCountdown) {
      _showCountdownDialog();
    } else {
      _audioPlayer.action(action);
    }

    if (action.isLoopMode) {
      _tracker.event(TrackingEvents.taleListenLoopModePressed);
    }
  }

  void onRatePressed(RatingType type) {
    _tracker.event(TrackingEvents.taleListenRatePressed);
    void onConfirmPressed() async {
      _tracker.event(TrackingEvents.taleListenRateConfirmPressed);
      _updateState(showRateTale: false);
      final id = TaleId(_taleId.get());
      final input = RateTaleInput(id, type);
      final rated = await _rateTaleUseCase.call(input);
      if (rated) {
        _snackbarController.showThanksForRating();
      } else {
        if (id == _taleId) {
          _updateState(showRateTale: true);
        }
        _snackbarController.showNetworkError();
      }
    }

    _dialogController.showConfirmRateTale(
      type,
      onConfirmPressed: onConfirmPressed,
    );
  }

  void _listenPlayer() {
    if (_subscriptions.isNotEmpty) return;
    _setInitialLoopModeUseCase.call(dry);

    final positionSubscription = _audioPlayer
        .watchPosition()
        .listen((Duration position) => _updateState(position: position));

    final statusSubscription = _audioPlayer
        .watchStatus()
        .listen((PlayAudioStatus status) => _updateState(playStatus: status));

    final loopModeSubscription =
        _audioPlayer.watchLoopMode().listen((PlayerLoopMode loopMode) {
      _updateState(loopMode: loopMode);
      _saveLoopModeUseCase.call(loopMode);
    });

    _subscriptions.addAll([
      positionSubscription,
      statusSubscription,
      loopModeSubscription,
    ]);
  }

  void _updateState({
    TaleAudio? audio,
    Duration? position,
    PlayAudioStatus? playStatus,
    PlayerLoopMode? loopMode,
    bool? showRateTale,
  }) async {
    if (isClosed) return;

    _position = position ?? _position;
    _taleAudio = audio ?? _taleAudio;
    _playStatus = playStatus ?? _playStatus;
    _loopMode = loopMode ?? _loopMode;
    _showTaleRating = showRateTale ?? _showTaleRating;

    // this is shame, I know
    // will fix it soon (added 20.07.2022 😜)
    while (_audioPlayer.playlistData == null) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

    final playlist = _audioPlayer.playlistData!;
    final stateReady = ListenPageState.ready(
      audio: _taleAudio,
      position: _position,
      playStatus: _playStatus,
      loopMode: _loopMode,
      isCountdownActive: _countdownService.isRunning,
      showRateTale: _showTaleRating,
      filterData: playlist.filterData,
      sortData: playlist.sortItemData,
    );

    emit(stateReady);
  }

  void _showCountdownDialog() {
    void onPressed(CountdownTime time) {
      late final TrackingEvent event;
      _countdownService.set(time);
      if (time.isOff) {
        event = TrackingEvents.taleListenCountdownOffPressed;
      } else if (!time.isOff) {
        event = TrackingEvents.taleListenCountdownOnPressed;
        _countdownService.pingWhenDone(() {
          _tracker.event(TrackingEvents.taleListenCountdownCompleted);
          _updateState();
        });
        _showCountdownDialog();
      }
      _updateState();
      _tracker.event(event);
    }

    _dialogController.showAudioCountdown(
      _countdownService.remainingTime,
      onPressed,
    );
  }
}
