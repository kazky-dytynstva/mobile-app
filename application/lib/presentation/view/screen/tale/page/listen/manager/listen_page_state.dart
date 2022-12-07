part of 'listen_page_manager.dart';

@freezed
abstract class ListenPageState with _$ListenPageState {
  const factory ListenPageState.initial() = _Initial;

  const factory ListenPageState.ready({
    required TaleAudio audio,
    required Duration position,
    required PlayAudioStatus playStatus,
    required PlayerLoopMode loopMode,
    required bool isCountdownActive,
    required bool showRateTale,
    required TaleFilterItemData filterData,
    required TaleSortItemData sortData,
  }) = ListenPageStateReady;
}
