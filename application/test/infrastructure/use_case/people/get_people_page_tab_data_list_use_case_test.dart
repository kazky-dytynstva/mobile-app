import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/domain/model/tale_crew/tale_crew_role.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/infrastructure/use_case/people/get_people_page_tab_data_list_use_case.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/utils.dart';

part 'get_people_page_tab_data_list_use_case_test.util.dart';

void main() {
  final defaultLabel = StringSingleLine('role');
  final allLabel = StringSingleLine(R.strings.general.allPeople);
  late MockSortPeopleUseCase sortPeopleUseCase;
  late MockCrewRoleToLabelPluralMapper crewRoleToLabelPluralMapper;
  late GetPeoplePageTabDataListUseCase useCase;
  setUp(() {
    sortPeopleUseCase = MockSortPeopleUseCase();
    crewRoleToLabelPluralMapper = MockCrewRoleToLabelPluralMapper();
    useCase = GetPeoplePageTabDataListUseCase(
      crewRoleToLabelPluralMapper,
      sortPeopleUseCase,
    );
    registerFallbackValue(<Person>[]);
    registerFallbackValue(TaleCrewRole.values.first);
    when(() => sortPeopleUseCase.call(any())).thenAnswer((_) async => dry);
    when(() => crewRoleToLabelPluralMapper.map(any())).thenReturn(defaultLabel);
  });

  test(
    'GIVEN empty input THEN return output with empty ALL item',
    () async {
      // ARRANGE
      final input = GetPeoplePageTabDataListInput({});

      // ACT
      final output = await useCase.call(input);

      // ASSERT
      expect(output.tabDataList.length, equals(1));
      expect(
        output.tabDataList.first.label,
        equals(allLabel),
      );
      expect(output.tabDataList.first.peopleList, isEmpty);
      expect(output.tabDataList.first.scrollPosition, 0);
      verify(() => sortPeopleUseCase.call([]));
      verifyNoMoreInteractions(sortPeopleUseCase);
      verifyZeroInteractions(crewRoleToLabelPluralMapper);
    },
  );

  test(
    'GIVEN input with full map THEN return list with proper tabData',
    () async {
      // ARRANGE
      final inputMap = getIncrementalPersonByRoleForAllRoles();
      final input = GetPeoplePageTabDataListInput(inputMap);
      final expectedLabels = [
        allLabel,
        defaultLabel,
        defaultLabel,
        defaultLabel,
        defaultLabel,
        defaultLabel,
      ];
      final expectedPeopleList = getExpectedPersonList();
      final size = expectedLabels.length;

      // ACT
      final output = await useCase.call(input);

      // ASSERT
      expect(output.tabDataList.length, equals(size));
      expect(
        output.tabDataList.map((e) => e.label),
        equals(expectedLabels),
      );
      expect(
        output.tabDataList.map((e) => e.peopleList),
        equals(expectedPeopleList),
      );
      for (final data in output.tabDataList) {
        expect(data.scrollPosition, equals(0));
      }

      expect(
        verify(() => sortPeopleUseCase.call(any())).callCount,
        equals(size),
      );
      expect(
        verify(() => crewRoleToLabelPluralMapper.map(any())).callCount,
        equals(size - 1),
      );
      verifyNoMoreInteractions(sortPeopleUseCase);
      verifyNoMoreInteractions(crewRoleToLabelPluralMapper);
    },
  );
}
