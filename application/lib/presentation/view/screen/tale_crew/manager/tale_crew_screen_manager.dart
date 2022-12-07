import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/changed_data/changed_data.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_id.dart';
import 'package:mobile_app/domain/model/tale_crew/tale_crew.dart';
import 'package:mobile_app/domain/model/tale_crew/tale_crew_list_item.dart';
import 'package:mobile_app/domain/model/tale_crew/tale_crew_role.dart';
import 'package:mobile_app/domain/tracking/tracker.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/infrastructure/di/named_annotations.dart';
import 'package:mobile_app/infrastructure/use_case/person/change_person_fav_use_case.dart';
import 'package:mobile_app/infrastructure/use_case/person/listen_person_changes_use_case.dart';
import 'package:mobile_app/presentation/navigation/screen/screen_controller.dart';
import 'package:mobile_app/presentation/view/screen/tale_crew/manager/tale_crew_screen_state.dart';

@injectable
class TaleCrewScreenManager extends Cubit<TaleCrewScreenState> {
  final ScreenController _screenController;
  final Mapper<TaleCrewRole, StringSingleLine> _roleToLabelMapperSingular;
  final Mapper<TaleCrewRole, StringSingleLine> _roleToLabelMapperPlural;
  final UseCase<ListenPersonChangesInput, ChangedData<Person, PersonId>>
      _listenPersonChanges;
  final UseCase<ChangePersonFavInput, Dry> _changePersonFavUseCase;
  final Tracker _tracker;

  final _subscriptionsGroup = UseCaseSubscriptionGroup();

  TaleCrewScreenManager(
    this._screenController,
    this._tracker,
    this._changePersonFavUseCase,
    this._listenPersonChanges,
    @singular this._roleToLabelMapperSingular,
    @plural this._roleToLabelMapperPlural,
  ) : super(const TaleCrewScreenState([]));

  @override
  Future<void> close() async {
    await _subscriptionsGroup.cancel();
    return super.close();
  }

  void init(TaleCrew crew) {
    final results = <TaleCrewListItem>[];
    final peopleSet = <Person>{};
    for (final role in TaleCrewRole.values) {
      final people = crew.getPeopleForRole(role);
      peopleSet.addAll(people);
      if (people.isNotEmpty) {
        final label = people.length == 1
            ? _roleToLabelMapperSingular.map(role)
            : _roleToLabelMapperPlural.map(role);
        final item = TaleCrewListItem(label, people);
        results.add(item);
      }
    }
    emit(TaleCrewScreenState(results));
    _initListeners(peopleSet);
  }

  void onPersonFavPressed(Person person) {
    _tracker.event(TrackingEvents.taleCrewPersonFavPressed);
    final input = ChangePersonFavInput(person.id, !person.isFavorite);
    _changePersonFavUseCase.call(input);
  }

  void onPersonPressed(Person person) {
    _tracker.event(TrackingEvents.taleCrewPersonPressed);
    _screenController.openPerson(person: person);
  }

  void onBackPressed() => _screenController.pop();

  void _initListeners(Set<Person> peopleSet) {
    if (_subscriptionsGroup.hasSubscriptions) return;
    void updated(Person person) {
      for (final item in state.items) {
        final index =
            item.people.indexWhere((element) => element.id == person.id);
        if (index >= 0) {
          item.people[index] = person;
        }
      }
      _updateStates(state.items);
    }

    for (final person in peopleSet) {
      final input = ListenPersonChangesInput(person.id);

      final subscription = _listenPersonChanges.listen(
        input,
        (output) => output.map(
          deleted: (_) {},
          updated: updated,
        ),
      );
      _subscriptionsGroup.add(subscription);
    }
  }

  void _updateStates(List<TaleCrewListItem> items) {
    emit(TaleCrewScreenState(items));
  }
}
