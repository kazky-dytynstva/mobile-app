import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/feature_flag/feature.dart';
import 'package:mobile_app/domain/feature_flag/feature_flag_provider.dart';
import 'package:mobile_app/infrastructure/data_source/storage_local/box_names.dart';
import 'package:mobile_app/infrastructure/env_config/env_config.dart';

@LazySingleton(
  as: FeatureFlagProvider,
  env: [
    Stagings.dev,
    Stagings.internal,
  ],
)
class DevFeatureFlagProvider implements FeatureFlagProvider {
  final Box<bool> _box;

  DevFeatureFlagProvider(
    HiveInterface hive,
  ) : _box = hive.box<bool>(BoxNames.devFeatureFlags);

  @override
  bool isEnabled(Feature feature) =>
      _box.get(feature.key, defaultValue: feature.defaultValue) as bool;

  void setEnabled(
    Feature feature, {
    required bool enabled,
  }) =>
      _box.put(feature.key, enabled);
}
