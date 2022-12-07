part of 'home_screen_manager.dart';

@freezed
class HomeScreenState with _$HomeScreenState {
  const factory HomeScreenState.initial() = _Initial;

  const factory HomeScreenState.ready({
    required List<HomePageType> pages,
    required HomePageType currentPage,
    required Option<TalesPageItemData> activeAudioTaleOption,
    required bool showMenuDot,
  }) = HomeScreenStateReady;
}
