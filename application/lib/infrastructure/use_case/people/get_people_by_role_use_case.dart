import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/exception/person_not_found_exception.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_id.dart';
import 'package:mobile_app/domain/model/tale_crew/tale_crew_role.dart';
import 'package:mobile_app/domain/repository/people_repository.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/infrastructure/data_source/storage_local/tale/entity/crew/crew_entity.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_storage.dart';
import 'package:mobile_app/infrastructure/helper/analytic/crash_analytic.dart';

@Injectable(as: UseCase)
class GetPeopleByRoleUseCase extends UseCase<Dry, GetPeopleByRoleOutput> {
  final PeopleRepository _peopleRepository;
  final CrashAnalytic _crashAnalytic;
  final TaleStorage _taleStorage;

  GetPeopleByRoleUseCase(
    this._peopleRepository,
    this._taleStorage,
    this._crashAnalytic,
  );

  @override
  Stream<GetPeopleByRoleOutput> transaction(Dry input) async* {
    final personIdSetByRole = await getPersonIdSetByRole();

    final personSetByRole = mapPersonIdMapToPeopleByRoleMap(personIdSetByRole);

    yield GetPeopleByRoleOutput(personSetByRole);
  }

  Future<Map<TaleCrewRole, Set<int>>> getPersonIdSetByRole() async {
    final map = <TaleCrewRole, Set<int>>{};
    Set<int> getSet(TaleCrewRole role) => map.putIfAbsent(role, () => {});

    final tales = await _taleStorage.getAll();
    for (final taleEntity in tales) {
      final crew = taleEntity.crew;
      if (crew != null) {
        fillSetWithIds(getSet, crew);
      }
    }
    return map;
  }

  @visibleForTesting
  void fillSetWithIds(
    Set<int> Function(TaleCrewRole) getSet,
    TaleCrewEntity crew,
  ) {
    final authors = crew.authors;
    if (authors != null) {
      getSet(TaleCrewRole.author).addAll(authors);
    }
    final readers = crew.readers;
    if (readers != null) {
      getSet(TaleCrewRole.reader).addAll(readers);
    }
    final translators = crew.translators;
    if (translators != null) {
      getSet(TaleCrewRole.translator).addAll(translators);
    }
    final musicians = crew.musicians;
    if (musicians != null) {
      getSet(TaleCrewRole.musician).addAll(musicians);
    }
    final graphics = crew.graphics;
    if (graphics != null) {
      getSet(TaleCrewRole.graphic).addAll(graphics);
    }
  }

  @visibleForTesting
  Map<TaleCrewRole, Set<Person>> mapPersonIdMapToPeopleByRoleMap(
    Map<TaleCrewRole, Set<int>> personIdSetByRole,
  ) {
    final map = <TaleCrewRole, Set<Person>>{};

    personIdSetByRole.forEach((role, Set<int> personIdSet) {
      final set = map.putIfAbsent(role, () => {});
      for (final personId in personIdSet) {
        final id = PersonId(personId);
        final personOption = _peopleRepository.find(id);
        personOption.fold(() {
          final exception = PersonNotFoundException(id);
          _crashAnalytic.exception(exception, StackTrace.current);
        }, (Person person) {
          set.add(person);
        });
      }
    });
    return map;
  }
}

@immutable
class GetPeopleByRoleOutput {
  final Map<TaleCrewRole, Set<Person>> peopleByRole;

  const GetPeopleByRoleOutput(this.peopleByRole);
}
