import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';

abstract class PackageData {
  IntPositive get buildNumber;

  StringSingleLine get appVersion;
}
