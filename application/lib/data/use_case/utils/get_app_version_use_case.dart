import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/app_version/app_version.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/data/data_source/package_data/package_data.dart';
import 'package:mobile_app/data/env_config/env_config.dart';

@Injectable(as: UseCase)
class GetAppVersionUseCase extends UseCase<Dry, AppVersion> {
  final PackageData _packageData;

  GetAppVersionUseCase(
    this._packageData,
  );

  @override
  Stream<AppVersion> transaction(Dry input) async* {
    final version = AppVersion(
      name: _packageData.appVersion,
      code: _packageData.buildNumber,
      staging: StringSingleLine(EnvConfig.staging),
    );

    yield version;
  }
}
