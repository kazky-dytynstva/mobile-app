part of 'tales_page_manager.dart';

@freezed
abstract class TalesPageState with _$TalesPageState {
  const factory TalesPageState.initial() = _Initial;

  const factory TalesPageState.ready({
    required TaleFilterItemData filterData,
    required TaleSortItemData sortData,
    required List<TalesPageItemData> tales,
    required bool showRandom,
  }) = TalesPageStateReady;
}
