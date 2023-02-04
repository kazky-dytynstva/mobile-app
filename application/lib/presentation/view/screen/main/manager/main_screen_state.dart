part of 'main_screen_manager.dart';

@freezed
class MainScreenState with _$MainScreenState {
  const factory MainScreenState.initial() = _Initial;

  const factory MainScreenState.ready({
    required List<MainScreenPage> pages,
    required MainScreenPage currentPage,
    required Option<TalesPageItemData> activeAudioTaleOption,
    required bool showMenuDot,
  }) = MainScreenStateReady;
}
