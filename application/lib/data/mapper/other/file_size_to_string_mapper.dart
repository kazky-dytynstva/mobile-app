import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/extensions/double_extensions.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/presentation/resource/r.dart';

@LazySingleton(as: Mapper)
class FileSizeToStringMapper implements Mapper<IntPositive, String> {
  @override
  String map(IntPositive input) {
    final size = input.get();
    final mb = (size / 1024 / 1024).rounded();
    if (mb < 1024) {
      return "$mb ${R.strings.settings.fileSizeMb}";
    }
    final gb = (size / 1024).rounded();
    return "$gb ${R.strings.settings.fileSizeGb}";
  }
}
