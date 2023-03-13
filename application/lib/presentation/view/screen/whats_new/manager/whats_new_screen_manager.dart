import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/feature_flag/feature.dart';
import 'package:mobile_app/domain/feature_flag/feature_flag_provider.dart';
import 'package:mobile_app/domain/model/app_version/app_version.dart';
import 'package:mobile_app/domain/model/show_dot/show_dot_type.dart';
import 'package:mobile_app/domain/model/version_changes/version_changes.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/domain/value_objects/string_not_empty.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/data/env_config/env_config.dart';
import 'package:mobile_app/presentation/navigation/screen/screen_controller.dart';
import 'package:mobile_app/presentation/resource/r.dart';

part 'whats_new_screen_state.dart';

part 'whats_new_data.dart';

part 'whats_new_screen_manager.freezed.dart';

@injectable
class WhatsNewScreenManager extends Cubit<WhatsNewScreenState> {
  final ScreenController _screenController;
  final UseCase<ShowDotType, Dry> _setShowDotTypeWatchedUseCase;
  final FeatureFlagProvider _featureFlagProvider;

  WhatsNewScreenManager(
    this._screenController,
    this._setShowDotTypeWatchedUseCase,
    this._featureFlagProvider,
  ) : super(const WhatsNewScreenState.init());

  void init() {
    final isHomePageEnabled = _featureFlagProvider.isEnabled(Feature.homePage);
    final changes = [
      _get5_6_1(),
      _get5_6_0(isHomePageEnabled: isHomePageEnabled),
      _get5_5_4(),
      _get5_5_0(),
      _get5_4_2(),
      _get5_4_0(),
      _get5_3_0(),
      _get5_2_1(),
      _get5_2_0(),
      _get5_1_0(),
    ];
    emit(WhatsNewScreenState.ready(changes: changes));
    _setShowDotTypeWatchedUseCase.call(ShowDotType.whatsNew);
  }

  void onBackPressed() => _screenController.pop();
}
