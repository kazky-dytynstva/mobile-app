import 'package:injectable/injectable.dart';
import 'package:mobile_app/data/use_case/helper/open_url_use_case.dart';
import 'package:mobile_app/domain/data_source/remote_configs.dart';
import 'package:mobile_app/domain/data_source/storage_local/app_state_storage.dart';
import 'package:mobile_app/domain/model/show_dot/show_dot_type.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/url_string.dart';

@Injectable(as: UseCase)
class OnSupportAppClickedUseCase
    extends UseCase<Dry, OnSupportAppClickedOutput> {
  final AppStateStorage _stateStorage;
  final RemoteConfigs _remoteConfigs;
  final UseCase<UrlString, OpenUrlOutput> _openUrlUseCase;

  OnSupportAppClickedUseCase(
    this._stateStorage,
    this._remoteConfigs,
    this._openUrlUseCase,
  );

  @override
  Stream<OnSupportAppClickedOutput> transaction(Dry input) async* {
    await _stateStorage.setSupportAppClicked();
    await _stateStorage.setShowDotType(ShowDotType.donation, show: false);

    await _openUrlUseCase.call(_remoteConfigs.getDonateUrl());

    yield _output;
  }
}

class OnSupportAppClickedOutput {
  const OnSupportAppClickedOutput._();
}

const OnSupportAppClickedOutput _output = OnSupportAppClickedOutput._();
