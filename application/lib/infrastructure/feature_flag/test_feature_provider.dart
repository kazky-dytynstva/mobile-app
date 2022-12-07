import 'package:mobile_app/domain/feature_flag/feature.dart';
import 'package:mobile_app/domain/feature_flag/feature_flag_provider.dart';

/// Should be used for the test purposes
class StoreFeatureFlagProvider implements FeatureFlagProvider {
  final _flags = <Feature, bool>{};

  StoreFeatureFlagProvider();

  @override
  bool isEnabled(Feature feature) => _flags[feature] ?? false;

  void setEnabled(
    Feature feature, {
    required bool enabled,
  }) =>
      _flags[feature] = enabled;

  void clear() => _flags.clear();
}
