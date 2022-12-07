import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_app/domain/model/app_theme/app_theme.dart';

part 'settings_data_general.freezed.dart';

@freezed
class SettingsDataGeneral with _$SettingsDataGeneral {
  const factory SettingsDataGeneral({
    @Default(AppTheme.system) AppTheme appTheme,
    @Default(false) bool isCrashLoggingEnabled,
    @Default(false) bool isTrackingEnabled,
  }) = _SettingsDataGeneral;
}
