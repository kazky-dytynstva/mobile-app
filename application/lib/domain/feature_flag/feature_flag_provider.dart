import 'feature.dart';

abstract class FeatureFlagProvider {
  bool isEnabled(Feature feature);
}
