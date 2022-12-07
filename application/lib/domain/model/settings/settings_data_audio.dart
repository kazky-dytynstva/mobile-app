import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';

part 'settings_data_audio.freezed.dart';

@freezed
class SettingsDataAudio with _$SettingsDataAudio {
  const factory SettingsDataAudio({
    required StringSingleLine needToCacheAudioInfo,
    required StringSingleLine cachedAudioInfo,
    @Default(false) bool hasMoreAudioToCache,
    @Default(false) bool hasCachedAudio,
    @Default(false) bool isCachingNow,
  }) = _SettingsDataAudio;
}
