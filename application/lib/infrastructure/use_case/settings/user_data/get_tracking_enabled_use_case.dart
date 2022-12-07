import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/data_source/storage_local/app_state_storage.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';

@Injectable(as: UseCase)
class GetTrackingEnabledUseCase extends UseCase<Dry, GetTrackingEnabledOutput> {
  final AppStateStorage _storage;

  GetTrackingEnabledUseCase(this._storage);

  @override
  Stream<GetTrackingEnabledOutput> transaction(Dry input) async* {
    final enabled = await _storage.getTrackingEnabled();
    yield GetTrackingEnabledOutput(enabled);
  }
}

@immutable
class GetTrackingEnabledOutput {
  final bool isEnabled;

  const GetTrackingEnabledOutput(this.isEnabled);
}
