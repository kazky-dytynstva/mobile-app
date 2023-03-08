import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/changed_data/changed_data.dart';
import 'package:mobile_app/domain/model/home_list_item_data/home_list_item_data.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/domain/model/rating/rating_data.dart';
import 'package:mobile_app/domain/model/sort_and_filter/filter_type.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_name.dart';
import 'package:mobile_app/domain/navigation/snackbar_controller.dart';
import 'package:mobile_app/domain/tracking/tracker.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/infrastructure/use_case/tale/change_tale_fav.dart';
import 'package:mobile_app/infrastructure/use_case/tale/get_home_page_tales_use_case.dart';
import 'package:mobile_app/infrastructure/use_case/tale/get_tale_use_case.dart';
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
  final SnackbarController _snackbarController;
  final UseCase<ChangeTaleFavInput, Dry> _changeTaleFavUseCase;
  final UseCase<Dry, ChangedData<TalesPageItemData, TaleId>>
      _listenAllTalesUseCase;
  final UseCase<TaleId, GetTaleOutput> _getTaleUseCase;
  final UseCase<GetHomePageTalesInput, GetHomePageTalesOutput>
      _getHomePageTales;
  final Tracker _tracker;
  final _talesRandom = <TalesPageItemData>[];
  final _talesLatest = <TalesPageItemData>[];
  final _talesRating = <TalesPageItemData>[];

  HomePageManager(
    this._screenController,
    this._dialogController,
    this._snackbarController,
    this._listenAllTalesUseCase,
    this._getTaleUseCase,
    this._changeTaleFavUseCase,
    this._getHomePageTales,
    this._tracker,
  ) : super(const HomePageState.initial()) {
    _init();
  }

  final _updateStateController = StreamController<Dry>();
  final _subscriptionGroup = UseCaseSubscriptionGroup();

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
  }

  void onTalePressed(TalesPageItemData item) async {
    _tracker.event(TrackingEvents.favPageTalePressed);
    final taleOutput = await _getTaleUseCase.call(item.id);
    _screenController.openTale(
      tale: taleOutput.tale,
      filterType: TaleFilterType.favorite,
    );
  }

  void onPersonPressed(Person person) {
    _tracker.event(TrackingEvents.favPagePersonPressed);
    _screenController.openPerson(person: person);
  }

  void onRatingPressed(TaleName name, RatingData data) {
    _tracker.event(TrackingEvents.favPageTaleRatingPressed);
    _dialogController.showTaleRating(
      name: name,
      data: data,
    );
  }

  void onTaleFavPressed(TalesPageItemData item) {
    _tracker.event(TrackingEvents.favPageFavTalePressed);
    void doAction(bool newFavStatus) {
      final input = ChangeTaleFavInput(item.id, newFavStatus);
      _changeTaleFavUseCase.call(input);
    }

    doAction(!item.isFav);

    if (item.isFav) {
      _snackbarController.showBringBackFavTale(
        name: item.name,
        onBringBackPressed: () {
          _tracker.event(TrackingEvents.favPageFavTaleUndoPressed);
          doAction(true);
        },
      );
    }
  }

  void _updateState(Dry dry) {
    final state = this.state;
    if (state is! HomePageStateReady) return;
  }

  void _addListeners() {
    void taleDeleted(TaleId id) {
      _updateStateController.add(dry);
    }

    void taleUpdated(TalesPageItemData item) {
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

    emit(HomePageState.ready(dataItems: _createDataItems()));
  }

  List<HomeListItemData> _createDataItems() => [
        HomeListItemData.random(tales: _talesRandom),
        HomeListItemData.bestRating(tales: _talesRating),
        HomeListItemData.latest(tales: _talesLatest),
      ];
}
