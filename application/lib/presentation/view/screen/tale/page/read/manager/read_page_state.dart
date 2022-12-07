part of 'read_page_manager.dart';

@freezed
abstract class ReadPageState with _$ReadPageState {
  const factory ReadPageState.initial() = _Initial;

  const factory ReadPageState.ready({
    required List<TaleTextItem> textItems,
    required int initialIndex,
    required bool showRateTale,
    required TextScaleFactor textScaleFactor,
  }) = ReadPageStateReady;
}
