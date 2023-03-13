import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/rating/rating_type.dart';
import 'package:mobile_app/domain/model/settings/text_scale_factor.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/navigation/snackbar_controller.dart';
import 'package:mobile_app/domain/tracking/tracker.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/data/use_case/settings/listen_text_scale_factor_changes_use_case.dart';
import 'package:mobile_app/data/use_case/tale/rate_tale_use_case.dart';
import 'package:mobile_app/presentation/navigation/dialog/dialog_controller.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:mobile_app/domain/model/tale/tale.dart';
import 'package:mobile_app/domain/model/tale/tale_text_item.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/data/use_case/tale/save_last_read_position.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/tale/manager/tale_screen_manager.dart';

part 'read_page_manager.freezed.dart';

part 'read_page_state.dart';

@injectable
class ReadTalePageManager extends Cubit<ReadPageState>
    implements UpdateTaleCallback {
  final DialogController _dialogController;
  final SnackbarController _snackbarController;
  final UseCase<RateTaleInput, bool> _rateTaleUseCase;
  final UseCase<SaveLastReadPositionUseCaseInput, Dry> _saveLastPositionUseCase;
  final UseCase<ListenTextScaleFactorChangesInput, TextScaleFactor>
      _listenTextScaleFactorUseCase;
  final Tracker _tracker;

  final _updateLastPositionController = StreamController<int>();
  final _visibleItemIndexes = <int>{};

  late TaleId _taleId;
  late TaleChapter _chapter;

  ReadTalePageManager(
    this._dialogController,
    this._snackbarController,
    this._saveLastPositionUseCase,
    this._rateTaleUseCase,
    this._listenTextScaleFactorUseCase,
    this._tracker,
  ) : super(const ReadPageState.initial()) {
    _initListeners();
  }

  late final UseCaseSubscription _scaleFactorSubscription;

  ReadPageStateReady get _stateReady => state as ReadPageStateReady;

  @override
  Future<void> close() async {
    await _updateLastPositionController.close();
    await _scaleFactorSubscription.cancel();
    return super.close();
  }

  @override
  void onTaleChanged(Tale tale, IntPositive chapterIndex) {
    _chapter = tale.chapters[chapterIndex.get()];
    _taleId = tale.id;
    _chapter.textOption.fold(
      () => {},
      (List<TaleTextItem> items) {
        final state = ReadPageState.ready(
          textItems: items,
          initialIndex: tale.lastReadPosition,
          showRateTale: !tale.isRated,
          textScaleFactor: (this.state is ReadPageStateReady)
              ? _stateReady.textScaleFactor
              : TextScaleFactor.m,
        );
        emit(state);
      },
    );
  }

  void onItemVisible(int index) {
    _visibleItemIndexes.add(index);
    _updateFirstVisibleIndex();
  }

  void onRatingPressed(RatingType type) {
    _tracker.event(TrackingEvents.taleReadRatePressed);
    void onConfirmPressed() async {
      _tracker.event(TrackingEvents.taleReadRateConfirmPressed);
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

  void onItemInvisible(int index) {
    _visibleItemIndexes.remove(index);
    _updateFirstVisibleIndex();
  }

  void _updateFirstVisibleIndex() {
    if (_updateLastPositionController.isClosed) return;
    var positionIndex =
        _visibleItemIndexes.isEmpty ? 0 : _visibleItemIndexes.reduce(min);
    _updateLastPositionController.add(positionIndex);
  }

  void _save(int positionIndex) {
    if (_updateLastPositionController.isClosed) {
      return;
    }
    final input = SaveLastReadPositionUseCaseInput(
      taleId: _taleId,
      chapterIndex: _chapter.index,
      itemIndex: positionIndex,
    );
    _saveLastPositionUseCase.call(input);
  }

  void _updateState({
    bool? showRateTale,
    TextScaleFactor? scaleFactor,
  }) {
    if (state is! ReadPageStateReady) return;
    final updated = _stateReady.copyWith(
      showRateTale: showRateTale ?? _stateReady.showRateTale,
      textScaleFactor: scaleFactor ?? _stateReady.textScaleFactor,
    );
    emit(updated);
  }

  void _initListeners() {
    _updateLastPositionController.stream
        .debounce(R.durations.updateTaleLastPositionDebounce)
        .listen(_save);
    _scaleFactorSubscription = _listenTextScaleFactorUseCase.listen(
      listenTextScaleFactorChangesInput,
      (output) => _updateState(scaleFactor: output),
    );
  }
}
