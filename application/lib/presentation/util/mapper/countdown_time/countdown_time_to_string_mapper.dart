import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/extensions/string.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/player/countdown_time.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/presentation/resource/r.dart';

@LazySingleton(as: Mapper)
class CountdownTimeToStringMapper
    implements Mapper<CountdownTime, StringSingleLine> {
  @override
  StringSingleLine map(CountdownTime input) {
    late final String string;

    final minutes = input.duration.inMinutes;
    final hours = input.duration.inHours;

    switch (input) {
      case CountdownTime.min5:
        string = R.strings.general.minutes.format(minutes);
        break;
      case CountdownTime.min10:
        string = R.strings.general.minutes.format(minutes);
        break;
      case CountdownTime.min20:
        string = R.strings.general.minutes.format(minutes);
        break;
      case CountdownTime.min30:
        string = R.strings.general.minutes.format(minutes);
        break;
      case CountdownTime.min60:
        string = R.strings.general.hour.format(hours);
        break;
      case CountdownTime.min120:
        string = R.strings.general.hours.format(hours);
        break;
      case CountdownTime.off:
        throw Exception('We do not expect map timeOff');
    }

    return StringSingleLine(string);
  }
}
