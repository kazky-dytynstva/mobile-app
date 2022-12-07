import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/app_version/app_version.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/infrastructure/data_source/package_data/package_data.dart';
import 'package:mobile_app/infrastructure/env_config/env_config.dart';

const _keyName = 'name';
const _keyCode = 'code';
const _keyStaging = 'staging';

@LazySingleton(as: Mapper)
class AppVersionToStringMapper extends Mapper<AppVersion, String> {
  @override
  String map(AppVersion input) {
    final map = {
      _keyName: input.name.get(),
      _keyCode: input.code.get(),
      _keyStaging: input.staging.get(),
    };
    return json.encode(map);
  }
}

@LazySingleton(as: Mapper)
class StringToAppVersionToMapper extends Mapper<String, AppVersion> {
  final PackageData _packageData;

  StringToAppVersionToMapper(
    this._packageData,
  );

  @override
  AppVersion map(String input) {
    try {
      final map = json.decode(input);
      final name = map[_keyName] as String;
      final code = map[_keyCode] as int;
      final staging = map[_keyStaging] as String;
      return AppVersion(
        name: StringSingleLine(name),
        code: IntPositive(code),
        staging: StringSingleLine(staging),
      );
    } catch (_) {
      return AppVersion(
        name: _packageData.appVersion,
        code: _packageData.buildNumber,
        staging: StringSingleLine(EnvConfig.staging),
      );
    }
  }
}
