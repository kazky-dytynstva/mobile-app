import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/domain/exception/person_not_found_exception.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_id.dart';
import 'package:mobile_app/domain/model/tale_crew/tale_crew_role.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/infrastructure/use_case/people/get_people_by_role_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/utils.dart';

part 'get_people_by_role_use_case_test.util.dart';

void main() {
  late MockPeopleRepository repository;
  late MockTaleStorage storage;
  late MockCrashAnalytic crashAnalytic;
  late GetPeopleByRoleUseCase useCase;

  setUp(() {
    repository = MockPeopleRepository();
    storage = MockTaleStorage();
    crashAnalytic = MockCrashAnalytic();
    useCase = GetPeopleByRoleUseCase(repository, storage, crashAnalytic);
  });

  group(
    'test fillSetWithIds method',
    () {
      late Map<TaleCrewRole, Set<int>> map;
      Set<int> getSet(TaleCrewRole role) => map.putIfAbsent(role, () => {});
      setUp(() {
        map = <TaleCrewRole, Set<int>>{};
      });
      tearDown(() {
        verifyZeroInteractions(repository);
        verifyZeroInteractions(storage);
        verifyZeroInteractions(crashAnalytic);
      });
      test(
        'GIVEN crew with nullable team members THEN set nothing to Set',
        () async {
          // ARRANGE
          final crew = crewNullable;

          // ACT
          useCase.fillSetWithIds(getSet, crew);

          // ASSERT
          expect(map, isEmpty);
        },
      );
      test(
        'GIVEN crew with empty team members THEN set nothing to Set',
        () async {
          // ARRANGE
          final crew = crewEmpty;

          // ACT
          useCase.fillSetWithIds(getSet, crew);

          // ASSERT
          for (final role in TaleCrewRole.values) {
            expect(map[role], isEmpty);
          }
        },
      );
      test(
        'GIVEN crew with NON EMPTY team members THEN set proper id to proper Set',
        () async {
          // ARRANGE
          final crew = crewIncremental;

          // ACT
          useCase.fillSetWithIds(getSet, crew);

          // ASSERT
          expect(map[TaleCrewRole.author], equals({0, 1}));
          expect(map[TaleCrewRole.reader], equals({2, 3}));
          expect(map[TaleCrewRole.translator], equals({4, 5}));
          expect(map[TaleCrewRole.musician], equals({6, 7}));
          expect(map[TaleCrewRole.graphic], equals({8, 9}));
        },
      );
    },
  );
  group(
    'test getPersonIdSetByRole method',
    () {
      tearDown(() {
        verify(() => storage.getAll());
        verifyNoMoreInteractions(storage);
        verifyZeroInteractions(repository);
        verifyZeroInteractions(crashAnalytic);
      });

      test(
        'GIVEN tale with crew with null crew THEN set nothing to Set',
        () async {
          // ARRANGE
          when(() => storage.getAll()).thenAnswer(
            (_) async => [getTaleEntity(id: 0, crew: null)],
          );

          // ACT
          final map = await useCase.getPersonIdSetByRole();

          // ASSERT
          expect(map, isEmpty);
        },
      );

      test(
        'GIVEN tale with crew with nullable team members THEN set nothing to Set',
        () async {
          // ARRANGE
          when(() => storage.getAll()).thenAnswer(
            (_) async => [taleWithCrewNullable],
          );

          // ACT
          final map = await useCase.getPersonIdSetByRole();

          // ASSERT
          expect(map, isEmpty);
        },
      );
      test(
        'GIVEN tale with crew with empty team members THEN set nothing to Set',
        () async {
          // ARRANGE
          when(() => storage.getAll()).thenAnswer(
            (_) async => [taleWithCrewEmpty],
          );

          // ACT
          final map = await useCase.getPersonIdSetByRole();

          // ASSERT
          for (final role in TaleCrewRole.values) {
            expect(map[role], isEmpty);
          }
        },
      );
      test(
        'GIVEN tale with crew with NON EMPTY team members THEN set proper id to proper Set',
        () async {
          // ARRANGE
          when(() => storage.getAll()).thenAnswer(
            (_) async => [taleWithCrewIncremental],
          );

          // ACT
          final map = await useCase.getPersonIdSetByRole();

          // ASSERT
          expect(map[TaleCrewRole.author], equals({0, 1}));
          expect(map[TaleCrewRole.reader], equals({2, 3}));
          expect(map[TaleCrewRole.translator], equals({4, 5}));
          expect(map[TaleCrewRole.musician], equals({6, 7}));
          expect(map[TaleCrewRole.graphic], equals({8, 9}));
        },
      );
      test(
        'GIVEN 3 tales with crew with NON EMPTY team members THEN set proper id to proper Set only once',
        () async {
          // ARRANGE
          when(() => storage.getAll()).thenAnswer(
            (_) async => [
              taleWithCrewIncremental,
              taleWithCrewIncremental,
              taleWithCrewIncremental,
            ],
          );

          // ACT
          final map = await useCase.getPersonIdSetByRole();

          // ASSERT
          expect(map[TaleCrewRole.author], equals({0, 1}));
          expect(map[TaleCrewRole.reader], equals({2, 3}));
          expect(map[TaleCrewRole.musician], equals({6, 7}));
          expect(map[TaleCrewRole.translator], equals({4, 5}));
          expect(map[TaleCrewRole.graphic], equals({8, 9}));
        },
      );
    },
  );
  group(
    'test mapPersonIdMapToPeopleByRoleMap method',
    () {
      setUp(() {
        setupPeopleRepositoryWhenMocking(repository);
      });
      test(
        'GIVEN empty map THEN return empty map and nothing happens',
        () async {
          // ACT
          final resultMap = useCase.mapPersonIdMapToPeopleByRoleMap({});

          // ASSERT
          expect(resultMap, isEmpty);
          verifyZeroInteractions(repository);
          verifyZeroInteractions(storage);
          verifyZeroInteractions(crashAnalytic);
        },
      );
      test(
        'GIVEN map with all roles and incremental set of person id THEN get all person from repo and put them to map',
        () async {
          // ARRANGE
          final inputMap = getIncrementalPersonIdByRoleForAllRoles();
          final expectedMap = getIncrementalPersonByRoleForAllRoles();
          // ACT
          final resultMap = useCase.mapPersonIdMapToPeopleByRoleMap(inputMap);

          // ASSERT
          for (int i = 0; i < maxPersonIdCount; i++) {
            verify(() => repository.find(PersonId(i)));
          }
          verifyNoMoreInteractions(repository);
          verifyZeroInteractions(storage);
          verifyZeroInteractions(crashAnalytic);
          expect(resultMap, equals(expectedMap));
        },
      );
      test(
        'GIVEN map with all roles and incremental set of person id WHEN 2 of those are not presented in the repository THEN those 2 will be reported to the crashlytics',
        () async {
          // ARRANGE
          final inputMap = getIncrementalPersonIdByRoleForAllRoles();
          inputMap[TaleCrewRole.values.first]?.add(unknownPersonId0);
          inputMap[TaleCrewRole.values.first]?.add(unknownPersonId1);
          final expectedMap = getIncrementalPersonByRoleForAllRoles();
          registerFallbackValue(StackTrace.current);

          // ACT
          final resultMap = useCase.mapPersonIdMapToPeopleByRoleMap(inputMap);

          // ASSERT
          for (int i = 0; i < maxPersonIdCount; i++) {
            verify(() => repository.find(PersonId(i)));
          }
          verify(() => repository.find(PersonId(unknownPersonId0)));
          verify(() => repository.find(PersonId(unknownPersonId1)));
          verify(() => crashAnalytic.exception(
                PersonNotFoundException(PersonId(unknownPersonId0)),
                any(),
              ));
          verify(() => crashAnalytic.exception(
                PersonNotFoundException(PersonId(unknownPersonId1)),
                any(),
              ));
          verifyNoMoreInteractions(repository);
          verifyZeroInteractions(storage);
          verifyNoMoreInteractions(crashAnalytic);
          expect(resultMap, equals(expectedMap));
        },
      );
    },
  );

  test(
    'happy path test',
    () async {
      // ARRANGE
      setupPeopleRepositoryWhenMocking(repository);
      when(() => storage.getAll()).thenAnswer(
        (_) async => listOfIncrementalTales,
      );

      // ACT
      final result = await useCase.call(dry);

      // ASSERT
      expect(
        result.peopleByRole,
        equals(getIncrementalPersonByRoleForAllRoles()),
      );
    },
  );
}
