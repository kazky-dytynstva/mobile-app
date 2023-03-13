import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/tale_crew/tale_crew_role.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/data/di/named_annotations.dart';
import 'package:mobile_app/presentation/resource/r.dart';

@singular
@LazySingleton(as: Mapper)
class CrewRoleToSingularLabelMapper
    implements Mapper<TaleCrewRole, StringSingleLine> {
  @override
  StringSingleLine map(TaleCrewRole input) {
    late final String label;
    switch (input) {
      case TaleCrewRole.author:
        label = R.strings.crewRoles.author;
        break;
      case TaleCrewRole.reader:
        label = R.strings.crewRoles.reader;
        break;
      case TaleCrewRole.translator:
        label = R.strings.crewRoles.translator;
        break;
      case TaleCrewRole.musician:
        label = R.strings.crewRoles.musician;
        break;
      case TaleCrewRole.graphic:
        label = R.strings.crewRoles.graphic;
        break;
    }
    return StringSingleLine(label);
  }
}
