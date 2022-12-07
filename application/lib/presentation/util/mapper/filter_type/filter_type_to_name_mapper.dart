import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/sort_and_filter/filter_type.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/presentation/resource/r.dart';

@LazySingleton(as: Mapper)
class FilterTypeToStringMapper
    implements Mapper<TaleFilterType, StringSingleLine> {
  @override
  StringSingleLine map(TaleFilterType input) {
    switch (input) {
      case TaleFilterType.all:
        return StringSingleLine(R.strings.taleFilterType.all);
      case TaleFilterType.unwatched:
        return StringSingleLine(R.strings.taleFilterType.unwatched);
      case TaleFilterType.national:
        return StringSingleLine(R.strings.taleFilterType.national);
      case TaleFilterType.author:
        return StringSingleLine(R.strings.taleFilterType.author);
      case TaleFilterType.audio:
        return StringSingleLine(R.strings.taleFilterType.audio);
      case TaleFilterType.lullaby:
        return StringSingleLine(R.strings.taleFilterType.lullaby);
      case TaleFilterType.poem:
        return StringSingleLine(R.strings.taleFilterType.poem);
      case TaleFilterType.lastAdded:
        return StringSingleLine(R.strings.taleFilterType.lastAdded);
      case TaleFilterType.hidden:
        return StringSingleLine(R.strings.taleFilterType.hidden);
      case TaleFilterType.favorite:
        return StringSingleLine(R.strings.taleFilterType.favorite);
    }
  }
}
