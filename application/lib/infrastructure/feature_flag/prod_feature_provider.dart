import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/feature_flag/feature.dart';
import 'package:mobile_app/domain/feature_flag/feature_flag_provider.dart';
import 'package:mobile_app/infrastructure/env_config/env_config.dart';

@LazySingleton(
  as: FeatureFlagProvider,
  env: [Stagings.prod],
)
class StoreFeatureFlagProvider implements FeatureFlagProvider {
  final FirebaseRemoteConfig _firebaseRemoteConfig;

  StoreFeatureFlagProvider(
    this._firebaseRemoteConfig,
  );

  @override
  bool isEnabled(Feature feature) => _firebaseRemoteConfig.getBool(feature.key);
}
