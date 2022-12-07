import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/tale_crew/tale_crew_role.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/infrastructure/di/named_annotations.dart';
import 'package:mobile_app/presentation/resource/r.dart';

@plural
@LazySingleton(as: Mapper)
class CrewRoleToPluralLabelMapper
    implements Mapper<TaleCrewRole, StringSingleLine> {
  @override
  StringSingleLine map(TaleCrewRole input) {
    late final String label;
    switch (input) {
      case TaleCrewRole.author:
        label = R.strings.crewRoles.authors;
        break;
      case TaleCrewRole.reader:
        label = R.strings.crewRoles.readers;
        break;
      case TaleCrewRole.translator:
        label = R.strings.crewRoles.translators;
        break;
      case TaleCrewRole.musician:
        label = R.strings.crewRoles.musicians;
        break;
      case TaleCrewRole.graphic:
        label = R.strings.crewRoles.graphics;
        break;
    }
    return StringSingleLine(label);
  }
}
