import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_app/domain/model/settings/text_scale_factor.dart';

part 'settings_data_text.freezed.dart';

@freezed
class SettingsDataText with _$SettingsDataText {
  const factory SettingsDataText({
    @Default(TextScaleFactor.m) TextScaleFactor textScaleFactor,
  }) = _SettingsDataText;
}
