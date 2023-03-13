import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/data_source/storage_local/app_state_storage.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';

@Injectable(as: UseCase)
class SetCrashLoggingEnabledUseCase
    extends UseCase<bool, SetCrashLoggingEnabledOutput> {
  final FirebaseCrashlytics _crashlytics;
  final AppStateStorage _storage;

  SetCrashLoggingEnabledUseCase(
    this._crashlytics,
    this._storage,
  );

  @override
  Stream<SetCrashLoggingEnabledOutput> transaction(bool input) async* {
    await _storage.setCrashLoggingEnabled(input);
    await _crashlytics.setCrashlyticsCollectionEnabled(input);
    final enabled = await _storage.getCrashLoggingEnabled();
    yield SetCrashLoggingEnabledOutput(enabled);
  }
}

@immutable
class SetCrashLoggingEnabledOutput {
  final bool isEnabled;

  const SetCrashLoggingEnabledOutput(this.isEnabled);
}
