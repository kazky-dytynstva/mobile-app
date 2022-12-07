part of 'feature_flags_screen_manager.dart';

@freezed
class FeatureFlagsScreenState with _$FeatureFlagsScreenState {
  const factory FeatureFlagsScreenState.initial() = _Initial;

  const factory FeatureFlagsScreenState.ready({
    required Map<Feature, bool> featuresMap,
    required bool flagsChanged,
  }) = FeatureFlagsScreenStateReady;
}
