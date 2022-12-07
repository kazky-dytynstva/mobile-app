import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/data_source/storage_local/app_state_storage.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';

@Injectable(as: UseCase)
class GetCrashLoggingEnabledUseCase
    extends UseCase<Dry, GetCrashLoggingEnabledOutput> {
  final AppStateStorage _storage;

  GetCrashLoggingEnabledUseCase(
    this._storage,
  );

  @override
  Stream<GetCrashLoggingEnabledOutput> transaction(Dry input) async* {
    final enabled = await _storage.getCrashLoggingEnabled();
    yield GetCrashLoggingEnabledOutput(enabled);
  }
}

@immutable
class GetCrashLoggingEnabledOutput {
  final bool isEnabled;

  const GetCrashLoggingEnabledOutput(this.isEnabled);
}
