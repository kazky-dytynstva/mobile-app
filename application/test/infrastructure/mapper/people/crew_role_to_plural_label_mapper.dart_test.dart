import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/domain/model/tale_crew/tale_crew_role.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/infrastructure/mapper/people/crew_role_to_plural_label_mapper.dart';
import 'package:mobile_app/presentation/resource/r.dart';

void main() {
  final mapper = CrewRoleToPluralLabelMapper();

  final expected = [
    R.strings.crewRoles.authors,
    R.strings.crewRoles.readers,
    R.strings.crewRoles.translators,
    R.strings.crewRoles.musicians,
    R.strings.crewRoles.graphics,
  ].map((e) => StringSingleLine(e));

  test(
    'GIVEN TaleCreRole WHEN map THEN return correct value',
    () {
      final results = TaleCrewRole.values.map(mapper.map);

      expect(results, equals(expected));
    },
  );
}
