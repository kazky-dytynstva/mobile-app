part of 'home_page_manager.dart';

@freezed
abstract class HomePageState with _$HomePageState {
  const factory HomePageState.initial() = _Initial;

  @Assert('dataItems.length > 0')
  const factory HomePageState.ready({
    required List<HomeListItemData> dataItems,
  }) = HomePageStateReady;
}
