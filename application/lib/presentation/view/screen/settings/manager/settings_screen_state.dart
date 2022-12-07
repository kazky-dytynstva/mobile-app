part of 'settings_screen_manager.dart';

@freezed
class SettingsScreenState with _$SettingsScreenState {
  const factory SettingsScreenState.initial() = _Initial;

  factory SettingsScreenState.ready({
    required List<SettingsPageType> pages,
    required int initialPageIndex,
    required SettingsDataGeneral dataGeneral,
    required SettingsDataText dataText,
    required SettingsDataAudio dataAudio,
  }) = SettingsScreenStateReady;
}
