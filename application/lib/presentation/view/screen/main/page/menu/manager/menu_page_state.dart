part of 'menu_page_manager.dart';

@freezed
abstract class MenuPageState with _$MenuPageState {
  const factory MenuPageState.initial() = _Initial;

  const factory MenuPageState.ready({
    required AppVersion appVersion,
    required bool showDotWhatsNew,
    required bool showDotDonation,
    required Option<MenuDynamicItemData> dynamicItemDataOption,
  }) = MenuPageStateReady;
}
