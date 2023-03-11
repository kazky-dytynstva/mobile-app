import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/people/people_page_tab_data.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_id.dart';
import 'package:mobile_app/domain/model/tale_crew/tale_crew_role.dart';
import 'package:mobile_app/domain/tracking/tracker.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/infrastructure/use_case/people/get_people_by_role_use_case.dart';
import 'package:mobile_app/infrastructure/use_case/people/get_people_page_tab_data_list_use_case.dart';
import 'package:mobile_app/infrastructure/use_case/people/listen_people_changes_use_case.dart';
import 'package:mobile_app/infrastructure/use_case/person/change_person_fav_use_case.dart';
import 'package:mobile_app/presentation/navigation/screen/screen_controller.dart';

part 'people_page_manager.freezed.dart';

part 'people_page_state.dart';

@injectable
class PeoplePageManager extends Cubit<PeoplePageState> {
  final UseCase<GetPeoplePageTabDataListInput, GetPeoplePageTabDataListOutput>
      _getPageTabDataListUseCase;
  final UseCase<Dry, GetPeopleByRoleOutput> _getPeopleByRoleUseCase;
  final ScreenController _screenController;
  final UseCase<Dry, ListenPeopleChangesOutput> _listenPeopleChangesUseCase;
  final UseCase<ChangePersonFavInput, Dry> _changePersonFavUseCase;
  final Tracker _tracker;
  TaleCrewRole? _currentRole;

  final _subscriptionGroup = UseCaseSubscriptionGroup();
  final List<PeoplePageTabData> _tabListData = [];

  PeoplePageManager(
    this._screenController,
    this._getPeopleByRoleUseCase,
    this._getPageTabDataListUseCase,
    this._listenPeopleChangesUseCase,
    this._changePersonFavUseCase,
    this._tracker,
  ) : super(const PeoplePageState.initial()) {
    init();
  }

  @override
  Future<void> close() async {
    await _subscriptionGroup.cancel();
    return super.close();
  }

  @visibleForTesting
  void init() async {
    final peopleByRole = await getPeopleByRole();
    final input = GetPeoplePageTabDataListInput(peopleByRole);
    final output = await _getPageTabDataListUseCase.call(input);
    _tabListData.addAll(output.tabDataList);
    _updateState();
    _initListeners();
  }

  @visibleForTesting
  Future<Map<TaleCrewRole, Set<Person>>> getPeopleByRole() async {
    final output = await _getPeopleByRoleUseCase.call(dry);
    return output.peopleByRole;
  }

  void onPersonFavPressed(Person person) {
    _tracker.event(TrackingEvents.peoplePageFavPressed);
    final input = ChangePersonFavInput(person.id, !person.isFavorite);
    _changePersonFavUseCase.call(input);
  }

  void onPersonPressed(Person person) {
    _tracker.event(TrackingEvents.peoplePagePersonPressed);
    final role = _currentRole;
    if (role != null) {
      final event = TrackingEvents.getPeoplePagePersonPressedByRole(role);
      _tracker.event(event);
    }
    _screenController.openPerson(person: person);
  }

  void onScrollPositionChanged(PeoplePageTabData data, double position) {
    _currentRole = data.roleOption.fold(() => null, (a) => a);
    final state = (this.state as PeoplePageStateReady);
    final index = state.tabDataList.indexWhere((e) => e.label == data.label);
    final tabData = state.tabDataList[index];
    final newTabData = tabData.copyWith(scrollPosition: position);
    final newList = List<PeoplePageTabData>.from(state.tabDataList);
    newList.removeAt(index);
    newList.insert(index, newTabData);
    emit(state.copyWith(tabDataList: newList));
  }

  void _initListeners() {
    if (_subscriptionGroup.hasSubscriptions) return;

    void updated(Person person) {
      for (final tabData in _tabListData) {
        final index =
            tabData.peopleList.indexWhere((element) => element.id == person.id);
        if (index >= 0) {
          tabData.peopleList[index] = person;
        }
      }
      _updateState();
    }

    void deleted(PersonId id) {
      for (final tabData in _tabListData) {
        tabData.peopleList.removeWhere((element) => element.id == id);
      }
      _updateState();
    }

    final subscription = _listenPeopleChangesUseCase.listen(
      dry,
      (output) => output.data.map(
        deleted: deleted,
        updated: updated,
      ),
    );
    _subscriptionGroup.add(subscription);
  }

  void _updateState() => emit(PeoplePageState.ready(
        tabDataList: _tabListData,
        timestamp: DateTime.now(),
      ));
}
