import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/helper/app_update_helper.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/forced_update_info/forced_update_info.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/data_source/remote_configs.dart';
import 'package:mobile_app/infrastructure/data_source/package_data/package_data.dart';
import 'package:mobile_app/infrastructure/data_source/remote_configs/dto/forced_update_info/forced_update_info_dto.dart';
import 'package:mobile_app/infrastructure/helper/logger/logger.dart';

@Injectable(as: UseCase)
class GetForcedUpdateInfoUseCase extends UseCase<Dry, ForcedUpdateInfo?> {
  final RemoteConfigs _configs;
  final Mapper<ForcedUpdateInfoDto, ForcedUpdateInfo> _mapper;
  final PackageData _packageData;
  final Logger _logger;
  final AppUpdateHelper _appUpdateHelper;

  GetForcedUpdateInfoUseCase(
    this._configs,
    this._logger,
    this._mapper,
    this._packageData,
    this._appUpdateHelper,
  );

  @override
  Stream<ForcedUpdateInfo?> transaction(Dry input) async* {
    _logger.log(() => 'check GetForcedUpdate', tag: logTag);
    final dto = _configs.getForcedUpdateInfo();
    if (dto == null) {
      _logger.log(() => 'it\'s empty, can continue normal flow', tag: logTag);
      yield null;
      return;
    }
    final forcedToUpdate = _packageData.buildNumber <= dto.buildNumber;

    if (!forcedToUpdate) {
      _logger.log(
        () => 'build number is fine, can continue normal flow',
        tag: logTag,
      );
      yield null;
      return;
    }

    final hasUpdates = await _appUpdateHelper.hasUpdates();
    if (!hasUpdates) {
      _logger.log(
        () => 'there is no updates on the marker, can continue normal flow',
        tag: logTag,
      );
      yield null;
      return;
    }

    _logger.log(() => 'need to show forcedUpdate info', tag: logTag);

    yield _mapper.map(dto);
  }
}
