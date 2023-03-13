import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/changed_data/changed_data.dart';
import 'package:mobile_app/domain/model/people/person_bottom_bar_action.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:collection/collection.dart';
import 'package:mobile_app/domain/model/person/person_tales_tab_data.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_id.dart';
import 'package:mobile_app/domain/model/rating/rating_data.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_name.dart';
import 'package:mobile_app/domain/tracking/tracker.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/url_string.dart';
import 'package:mobile_app/data/use_case/helper/open_url_use_case.dart';
import 'package:mobile_app/data/use_case/person/change_person_fav_use_case.dart';
import 'package:mobile_app/data/use_case/people/get_person_tab_data_use_case.dart';
import 'package:mobile_app/data/use_case/people/get_person_tales_use_case.dart';
import 'package:mobile_app/data/use_case/person/get_person_use_case.dart';
import 'package:mobile_app/data/use_case/person/listen_person_changes_use_case.dart';
import 'package:mobile_app/data/use_case/tale/change_tale_fav.dart';
import 'package:mobile_app/data/use_case/tale/get_tale_use_case.dart';
import 'package:mobile_app/presentation/navigation/dialog/dialog_controller.dart';
import 'package:mobile_app/presentation/navigation/screen/screen_controller.dart';

part 'person_screen_state.dart';

part 'person_screen_manager.freezed.dart';

@injectable
class PersonScreenManager extends Cubit<PersonScreenState> {
  final UseCase<PersonId, GetPersonOutput> _getPersonUseCase;
  final UseCase<PersonId, GetPersonTalesOutput> _getPersonTalesUseCase;
  final UseCase<GetPersonTabDataInput, GetPersonTabDataOutput>
      _getPersonTabDataUseCase;
  final UseCase<ChangeTaleFavInput, Dry> _changeTaleFavUseCase;
  final UseCase<TaleId, GetTaleOutput> _getTaleUseCase;
  final UseCase<Dry, ChangedData<TalesPageItemData, TaleId>>
      _listenAllTalesUseCase;
  final UseCase<ListenPersonChangesInput, ChangedData<Person, PersonId>>
      _listenPersonChanges;
  final UseCase<UrlString, OpenUrlOutput> _openUrlUseCase;
  final UseCase<ChangePersonFavInput, Dry> _changeFavUseCase;
  final ScreenController _screenController;
  final DialogController _dialogController;
  final Tracker _tracker;

  PersonScreenManager(
    this._screenController,
    this._getPersonUseCase,
    this._getPersonTalesUseCase,
    this._getPersonTabDataUseCase,
    this._changeTaleFavUseCase,
    this._getTaleUseCase,
    this._listenAllTalesUseCase,
    this._listenPersonChanges,
    this._openUrlUseCase,
    this._changeFavUseCase,
    this._dialogController,
    this._tracker,
  ) : super(const PersonScreenState.initial());

  final _subscriptionGroup = UseCaseSubscriptionGroup();
  final List<PersonTalesTabData> _tabDataList = [];

  PersonScreenStateReady get _stateReady => state as PersonScreenStateReady;

  @override
  Future<void> close() async {
    await _subscriptionGroup.cancel();
    return super.close();
  }

  void init(PersonId personId) async {
    final person = (await _getPersonUseCase.call(personId)).person;
    emit(PersonScreenState.ready(person: person, tabDataList: []));
    await _getPersonTales(personId);
    _addListeners(personId);
  }

  void onTaleFavPressed(TalesPageItemData tale) {
    _tracker.event(TrackingEvents.personTaleFavPressed);
    final input = ChangeTaleFavInput(tale.id, !tale.isFav);
    _changeTaleFavUseCase.call(input);
  }

  void onUrlPressed(UrlString urlString) {
    _tracker.event(TrackingEvents.personInfoUrlPressed);
    _openUrlUseCase.call(urlString);
  }

  void onBottomActionPressed(PersonBottomBarAction action) {
    TrackingEvent? event;
    switch (action) {
      case PersonBottomBarAction.back:
        _screenController.pop();
        break;
      case PersonBottomBarAction.fav:
        _changeFav();
        event = TrackingEvents.personFavPressed;
        break;
    }
    if (event != null) {
      _tracker.event(event);
    }
  }

  void onRatingPressed(
    TaleName name,
    RatingData data,
  ) {
    _tracker.event(TrackingEvents.personTaleRatingPressed);
    _dialogController.showTaleRating(name: name, data: data);
  }

  void onTalePressed(TalesPageItemData item) async {
    _tracker.event(TrackingEvents.personTalePressed);
    final taleOutput = await _getTaleUseCase.call(item.id);
    _screenController.openTale(tale: taleOutput.tale);
  }

  Future<Unit> _getPersonTales(PersonId id) async {
    final personTales = (await _getPersonTalesUseCase.call(id)).tales;

    final input = GetPersonTabDataInput(personTales, id);
    final output = await _getPersonTabDataUseCase.call(input);
    _tabDataList.addAll(output.tabDataList);
    _updateState();
    return unit;
  }

  void _addListeners(PersonId personId) {
    void taleDeleted(TaleId id) {
      for (final tabData in _tabDataList) {
        final tale = tabData.tales.firstWhereOrNull((tale) => tale.id == id);
        if (tale != null) {
          tabData.tales.remove(tale);
        }
      }
      _updateState();
    }

    void taleUpdated(TalesPageItemData item) {
      for (final tabData in _tabDataList) {
        final taleIndex =
            tabData.tales.indexWhere((tale) => tale.id == item.id);
        if (taleIndex < 0) {
          tabData.tales.add(item);
        } else if (tabData.tales[taleIndex] != item) {
          tabData.tales.removeAt(taleIndex);
          tabData.tales.insert(taleIndex, item);
        }
      }
      _updateState();
    }

    final allTalesSubscription = _listenAllTalesUseCase.listen(
      dry,
      (ChangedData<TalesPageItemData, TaleId> data) {
        data.map(
          deleted: taleDeleted,
          updated: taleUpdated,
        );
      },
    );
    _subscriptionGroup.add(allTalesSubscription);

    final personSubscription = _listenPersonChanges.listen(
      ListenPersonChangesInput(personId),
      (ChangedData<Person, PersonId> data) => data.map(
        deleted: (_) => _screenController.pop(),
        updated: (Person person) => _updateState(person: person),
      ),
    );
    _subscriptionGroup.add(personSubscription);
  }

  void _updateState({Person? person}) {
    final newState = _stateReady.copyWith(
      person: person ?? _stateReady.person,
      tabDataList: _tabDataList,
      timestamp: DateTime.now(),
    );
    emit(newState);
  }

  void _changeFav() {
    final person = _stateReady.person;
    final input = ChangePersonFavInput(person.id, !person.isFavorite);
    _changeFavUseCase.call(input);
  }
}
