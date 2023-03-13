import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/domain/model/tale_crew/tale_crew_role.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/data/mapper/people/crew_role_to_singular_label_mapper.dart';
import 'package:mobile_app/presentation/resource/r.dart';

void main() {
  final mapper = CrewRoleToSingularLabelMapper();

  final expected = [
    R.strings.crewRoles.author,
    R.strings.crewRoles.reader,
    R.strings.crewRoles.translator,
    R.strings.crewRoles.musician,
    R.strings.crewRoles.graphic,
  ].map((e) => StringSingleLine(e));

  test(
    'GIVEN TaleCreRole WHEN map THEN return correct value',
    () {
      final results = TaleCrewRole.values.map(mapper.map);

      expect(results, equals(expected));
    },
  );
}
