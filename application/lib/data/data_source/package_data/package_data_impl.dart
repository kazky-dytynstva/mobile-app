import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package_data.dart';

@LazySingleton(as: PackageData)
class PackageDataImpl implements PackageData {
  final PackageInfo _packageInfo;

  PackageDataImpl(this._packageInfo);

  @override
  StringSingleLine get appVersion => StringSingleLine(_packageInfo.version);

  @override
  IntPositive get buildNumber =>
      IntPositive(int.parse(_packageInfo.buildNumber));
}
