import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/changed_data/changed_data.dart';
import 'package:mobile_app/domain/model/home_list_item_data/home_list_item_data.dart';
import 'package:mobile_app/domain/model/rating/rating_data.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_name.dart';
import 'package:mobile_app/domain/model/user_action/user_action_request.dart';
import 'package:mobile_app/domain/tracking/tracker.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/data/use_case/tale/change_tale_fav.dart';
import 'package:mobile_app/data/use_case/tale/get_home_page_tales_use_case.dart';
import 'package:mobile_app/data/use_case/tale/get_tale_use_case.dart';
import 'package:mobile_app/presentation/navigation/dialog/dialog_controller.dart';
import 'package:mobile_app/presentation/navigation/screen/screen_controller.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:stream_transform/stream_transform.dart';

part 'home_page_manager.freezed.dart';

part 'home_page_state.dart';

@injectable
class HomePageManager extends Cubit<HomePageState> {
  final ScreenController _screenController;
  final DialogController _dialogController;
  final UseCase<ChangeTaleFavInput, Dry> _changeTaleFavUseCase;
  final UseCase<Dry, ChangedData<TalesPageItemData, TaleId>>
      _listenAllTalesUseCase;
  final UseCase<TaleId, GetTaleOutput> _getTaleUseCase;
  final UseCase<GetHomePageTalesInput, GetHomePageTalesOutput>
      _getHomePageTales;
  final UseCase<Dry, UserActionRequest?> _getUserActionRequestUseCase;
  final Tracker _tracker;
  final _allListsTogether = <List<TalesPageItemData>>[];
  final _talesRandom = <TalesPageItemData>[];
  final _talesLatest = <TalesPageItemData>[];
  final _talesRating = <TalesPageItemData>[];
  DateTime _stateUpdateTimestamp = DateTime.now();

  HomePageManager(
    this._screenController,
    this._dialogController,
    this._listenAllTalesUseCase,
    this._getTaleUseCase,
    this._changeTaleFavUseCase,
    this._getUserActionRequestUseCase,
    this._getHomePageTales,
    this._tracker,
  ) : super(const HomePageState.initial()) {
    _init();
  }

  final _updateStateController = StreamController<Dry>();
  final _subscriptionGroup = UseCaseSubscriptionGroup();
  UserActionRequest? _userActionRequest;

  @override
  Future<void> close() async {
    await _subscriptionGroup.cancel();
    await _updateStateController.close();
    return super.close();
  }

  void _init() async {
    _updateState(dry);
    _addListeners();
    _prepareTales();
    _prepareUserActionRequest();
  }

  void onTalePressed(TalesPageItemData item) async {
    _tracker.event(TrackingEvents.homePageTalePressed);
    final taleOutput = await _getTaleUseCase.call(item.id);
    _screenController.openTale(tale: taleOutput.tale);
  }

  void onRatingPressed(TaleName name, RatingData data) {
    _tracker.event(TrackingEvents.homePageTaleRatingPressed);
    _dialogController.showTaleRating(
      name: name,
      data: data,
    );
  }

  void onTaleFavPressed(TalesPageItemData item) {
    _tracker.event(TrackingEvents.homePageFavTalePressed);
    final input = ChangeTaleFavInput(item.id, !item.isFav);
    _changeTaleFavUseCase.call(input);
  }

  void _updateState(Dry dry) {
    final state = this.state;
    if (state is! HomePageStateReady) return;
    if (_stateUpdateTimestamp == state.updateTimestamp) return;
    emit(HomePageState.ready(
      dataItems: _createDataItems(),
      updateTimestamp: _stateUpdateTimestamp,
    ));
  }

  void _addListeners() {
    void taleDeleted(TaleId deletedTaleId) {
      for (final list in _allListsTogether) {
        final index = list.indexWhere((tale) => tale.id == deletedTaleId);
        if (index == -1) continue;
        list.removeAt(index);
        _resetUpdateTimestamp();
      }
      _updateStateController.add(dry);
    }

    void taleUpdated(TalesPageItemData updated) {
      for (final list in _allListsTogether) {
        final index = list.indexWhere((tale) => tale.id == updated.id);
        if (index == -1) {
          _addTaleIfItIsNewest(updated);
          continue;
        }
        list.removeAt(index);
        list.insert(index, updated);
        _resetUpdateTimestamp();
      }
      _updateStateController.add(dry);
    }

    final taleSubscription = _listenAllTalesUseCase.listen(
      dry,
      (ChangedData<TalesPageItemData, TaleId> data) {
        data.map(
          deleted: taleDeleted,
          updated: taleUpdated,
        );
      },
    );
    _subscriptionGroup.add(taleSubscription);

    _updateStateController.stream
        .debounce(R.durations.updateTaleListDebounce)
        .listen(_updateState);
  }

  void _prepareTales() async {
    const amount = 10;
    _talesRandom.addAll(
      await _getHomePageTales
          .call(const GetHomePageTalesInput.random(requestedAmount: amount)),
    );

    _talesLatest.addAll(
      await _getHomePageTales
          .call(const GetHomePageTalesInput.latest(requestedAmount: amount)),
    );

    _talesRating.addAll(
      await _getHomePageTales.call(
          const GetHomePageTalesInput.bestRating(requestedAmount: amount)),
    );

    _allListsTogether.addAll([
      _talesRandom,
      _talesRating,
      _talesLatest,
    ]);

    emit(HomePageState.ready(
      dataItems: _createDataItems(),
      updateTimestamp: _stateUpdateTimestamp,
    ));
  }

  void _prepareUserActionRequest() async {
    final actionRequest = await _getUserActionRequestUseCase.call(dry);
    if (actionRequest == null) return;
    _userActionRequest = actionRequest;
    _stateUpdateTimestamp = DateTime.now();
    _updateStateController.add(dry);
  }

  List<HomeListItemData> _createDataItems() {
    final actionRequest = _userActionRequest;
    return [
      HomeListItemData.random(tales: _talesRandom),
      if (actionRequest != null)
        HomeListItemData.userActionRequest(actionRequest: actionRequest),
      HomeListItemData.bestRating(tales: _talesRating),
      HomeListItemData.latest(tales: _talesLatest),
    ];
  }

  void _addTaleIfItIsNewest(TalesPageItemData taleToAdd) {
    final listToCheck = _talesLatest;

    if (listToCheck.indexWhere((tale) => tale.id == taleToAdd.id) >= 0) return;

    final latestCreateMin = listToCheck
        .map((tale) => tale.createDate)
        .reduce((value, element) => value.isBefore(element) ? value : element);

    if (taleToAdd.createDate.isBefore(latestCreateMin)) return;

    final indexToInsert = listToCheck
        .indexWhere((tale) => taleToAdd.createDate.isAfter(tale.createDate));

    listToCheck.insert(indexToInsert, taleToAdd);
    _resetUpdateTimestamp();
  }

  void _resetUpdateTimestamp() => _stateUpdateTimestamp = DateTime.now();
}
