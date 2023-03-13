import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/feature_flag/feature.dart';
import 'package:mobile_app/domain/feature_flag/feature_flag_provider.dart';
import 'package:mobile_app/data/feature_flag/dev_feature_provider.dart';

part 'feature_flags_screen_state.dart';

part 'feature_flags_screen_manager.freezed.dart';

@injectable
class FeatureFlagsScreenManager extends Cubit<FeatureFlagsScreenState> {
  final FeatureFlagProvider _featureFlagProvider;

  FeatureFlagsScreenManager(
    this._featureFlagProvider,
  ) : super(const FeatureFlagsScreenState.initial());

  FeatureFlagsScreenStateReady get _stateReady =>
      state as FeatureFlagsScreenStateReady;
  var _flagsChanged = false;

  void getFeatureFlags() {
    final map = <Feature, bool>{};
    for (final feature in Feature.values) {
      final isEnabled = _featureFlagProvider.isEnabled(feature);
      map[feature] = isEnabled;
    }
    final ready = FeatureFlagsScreenState.ready(
      featuresMap: map,
      flagsChanged: _flagsChanged,
    );
    emit(ready);
  }

  void changeFlag(Feature feature) {
    _flagsChanged = true;
    final isEnabled = _stateReady.featuresMap[feature]!;
    (_featureFlagProvider as DevFeatureFlagProvider)
        .setEnabled(feature, enabled: !isEnabled);
    getFeatureFlags();
  }
}
