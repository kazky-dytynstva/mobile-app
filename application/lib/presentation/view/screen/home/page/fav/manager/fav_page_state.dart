part of 'fav_page_manager.dart';

@freezed
abstract class FavPageState with _$FavPageState {
  const factory FavPageState.initial() = _Initial;

  const factory FavPageState.ready({
    required List<TalesPageItemData> tales,
    required List<Person> people,
    required DateTime timestamp,
  }) = FavPageStateReady;
}
