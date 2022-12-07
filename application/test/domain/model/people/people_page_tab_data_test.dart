import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/domain/model/people/people_page_tab_data.dart';
import 'package:mobile_app/domain/model/tale_crew/tale_crew_role.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';

import '../../../utils/utils.dart';

void main() {
  const roleOption = Some(TaleCrewRole.graphic);
  final label = StringSingleLine('label');
  final person = getPerson();
  final tabData = PeoplePageTabData(roleOption, label, [person]);

  test(
    'GIVEN tabData WHEN  THEN verify it is equatable',
    () async {
      // ASSERT
      expect(tabData, isA<Equatable>());
      expect(tabData.props, [
        roleOption,
        label,
        [person],
        0, //default value
      ]);
    },
  );

  test(
    'GIVEN nullable position WHEN copyWith called THEN copy same tabData',
    () async {
      // ACT
      final copy = tabData.copyWith(scrollPosition: null);

      // ASSERT
      expect(copy, equals(tabData));
    },
  );

  test(
    'GIVEN non-nullable position WHEN copyWith called THEN copy tabData with that position',
    () async {
      // ARRANGE
      const position = 123.0;

      // ACT
      final copy = tabData.copyWith(scrollPosition: position);

      // ASSERT
      expect(copy.roleOption, equals(tabData.roleOption));
      expect(copy.label, equals(tabData.label));
      expect(copy.peopleList, equals(tabData.peopleList));
      expect(copy.scrollPosition, equals(position));
    },
  );
}
