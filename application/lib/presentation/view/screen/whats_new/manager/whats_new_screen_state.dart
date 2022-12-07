part of 'whats_new_screen_manager.dart';

@freezed
abstract class WhatsNewScreenState with _$WhatsNewScreenState {
  const factory WhatsNewScreenState.init() = _Init;

  const factory WhatsNewScreenState.ready({
    required List<VersionChanges> changes,
  }) = WhatsNewScreenStateReady;
}
