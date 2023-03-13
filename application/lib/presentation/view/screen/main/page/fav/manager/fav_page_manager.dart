import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/changed_data/changed_data.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_id.dart';
import 'package:mobile_app/domain/model/rating/rating_data.dart';
import 'package:mobile_app/domain/model/sort_and_filter/filter_type.dart';
import 'package:mobile_app/domain/model/sort_and_filter/sort_type.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_name.dart';
import 'package:mobile_app/domain/navigation/snackbar_controller.dart';
import 'package:mobile_app/domain/tracking/tracker.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/data/use_case/people/get_all_fav_people_use_case.dart';
import 'package:mobile_app/data/use_case/people/listen_people_changes_use_case.dart';
import 'package:mobile_app/data/use_case/person/change_person_fav_use_case.dart';
import 'package:mobile_app/data/use_case/tale/change_tale_fav.dart';
import 'package:mobile_app/data/use_case/tale/get_tale_use_case.dart';
import 'package:mobile_app/data/use_case/tale_list/get_all_tales.dart';
import 'package:mobile_app/data/use_case/tale_sort_and_filter/filter_and_sort_tales_use_case.dart';
import 'package:mobile_app/presentation/navigation/dialog/dialog_controller.dart';
import 'package:mobile_app/presentation/navigation/screen/screen_controller.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:stream_transform/stream_transform.dart';

part 'fav_page_manager.freezed.dart';

part 'fav_page_state.dart';

@injectable
class FavPageManager extends Cubit<FavPageState> {
  final ScreenController _screenController;
  final DialogController _dialogController;
  final SnackbarController _snackbarController;
  final UseCase<ChangeTaleFavInput, Dry> _changeTaleFavUseCase;
  final UseCase<ChangePersonFavInput, Dry> _changePersonFavUseCase;
  final UseCase<Dry, GetAllTalesOutput> _getAllTalesUseCase;
  final UseCase<Dry, GetAllFavPeopleOutput> _getAllFavPeopleUseCase;
  final UseCase<FilterAndSortTalesInput, FilterAndSortTalesOutput>
      _filterAndSortTalesUseCase;
  final UseCase<List<Person>, Dry> _sortPeopleUseCase;
  final UseCase<Dry, ChangedData<TalesPageItemData, TaleId>>
      _listenAllTalesUseCase;
  final UseCase<Dry, ListenPeopleChangesOutput> _listenPeopleChangesUseCase;
  final UseCase<TaleId, GetTaleOutput> _getTaleUseCase;
  final Tracker _tracker;

  FavPageManager(
    this._screenController,
    this._dialogController,
    this._snackbarController,
    this._getAllTalesUseCase,
    this._getAllFavPeopleUseCase,
    this._filterAndSortTalesUseCase,
    this._sortPeopleUseCase,
    this._listenAllTalesUseCase,
    this._listenPeopleChangesUseCase,
    this._getTaleUseCase,
    this._changeTaleFavUseCase,
    this._changePersonFavUseCase,
    this._tracker,
  ) : super(const FavPageState.initial()) {
    _init();
  }

  final _updateStateController = StreamController<Dry>();
  final _allTales = <TalesPageItemData>[];
  final _favPeople = <Person>[];
  final _subscriptionGroup = UseCaseSubscriptionGroup();

  @override
  Future<void> close() async {
    await _subscriptionGroup.cancel();
    await _updateStateController.close();
    return super.close();
  }

  void _init() async {
    final tales = await _getAllTalesUseCase.call(dry);
    _allTales.addAll(tales);

    final peopleOutput = await _getAllFavPeopleUseCase.call(dry);
    _favPeople.addAll(peopleOutput.people);

    _updateState(dry);
    _addListeners();
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

  void onPersonFavPressed(Person person) async {
    _tracker.event(TrackingEvents.favPagePersonFavPressed);
    void doAction(bool newFavStatus) {
      final input = ChangePersonFavInput(person.id, newFavStatus);
      _changePersonFavUseCase.call(input);
    }

    doAction(!person.isFavorite);

    if (person.isFavorite) {
      _snackbarController.showBringBackFavPerson(
        name: person.name,
        onBringBackPressed: () {
          _tracker.event(TrackingEvents.favPagePersonFavUndoPressed);
          doAction(true);
        },
      );
    }
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

  void _updateState(Dry dry) async {
    final input = FilterAndSortTalesInput(
      TaleFilterType.favorite,
      TaleSortType.byName,
      _allTales,
    );
    final filteredAndSortedTales = await _filterAndSortTalesUseCase.call(input);
    await _sortPeopleUseCase.call(_favPeople);
    final newState = FavPageState.ready(
      tales: filteredAndSortedTales,
      people: _favPeople,
      timestamp: DateTime.now(),
    );
    emit(newState);
  }

  void _addListeners() {
    void taleDeleted(TaleId id) {
      final tale = _allTales.firstWhereOrNull((tale) => tale.id == id);
      if (tale != null) {
        _allTales.remove(tale);
        _updateStateController.add(dry);
      }
    }

    void taleUpdated(TalesPageItemData item) {
      final tale = _allTales.firstWhereOrNull((tale) => tale.id == item.id);
      if (tale == null || tale != item) {
        _allTales.remove(tale);
        _allTales.add(item);
        _updateStateController.add(dry);
      }
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

    void personDeleted(PersonId id) {
      final index = _favPeople.indexWhere((element) => element.id == id);
      if (index < 0) return;
      _favPeople.removeAt(index);
      _updateStateController.add(dry);
    }

    void personUpdated(Person person) {
      final index = _favPeople.indexWhere((element) => element.id == person.id);
      if (index < 0 && !person.isFavorite) return;
      if (index >= 0) {
        _favPeople.removeAt(index);
      } else {
        _favPeople.add(person);
      }
      _updateStateController.add(dry);
    }

    final peopleSubscription = _listenPeopleChangesUseCase.listen(
      dry,
      (output) => output.data.map(
        deleted: personDeleted,
        updated: personUpdated,
      ),
    );
    _subscriptionGroup.add(peopleSubscription);

    _updateStateController.stream
        .debounce(R.durations.updateTaleListDebounce)
        .listen(_updateState);
  }
}
