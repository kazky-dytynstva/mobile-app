import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/data_source/storage_local/app_state_storage.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';

@Injectable(as: UseCase)
class SetTrackingEnabledUseCase
    extends UseCase<bool, SetTrackingEnabledOutput> {
  final FirebaseAnalytics _analytics;
  final AppStateStorage _storage;

  SetTrackingEnabledUseCase(
    this._analytics,
    this._storage,
  );

  @override
  Stream<SetTrackingEnabledOutput> transaction(bool input) async* {
    await _storage.setTrackingEnabled(input);
    await _analytics.setAnalyticsCollectionEnabled(input);
    final enabled = await _storage.getTrackingEnabled();
    yield SetTrackingEnabledOutput(enabled);
  }
}

@immutable
class SetTrackingEnabledOutput {
  final bool isEnabled;

  const SetTrackingEnabledOutput(this.isEnabled);
}
