import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_app/domain/model/player/countdown_time.dart';

part 'play_audio_action.freezed.dart';

@freezed
abstract class PlayAudioAction with _$PlayAudioAction {
  const factory PlayAudioAction.play() = _Play;

  const factory PlayAudioAction.pause() = _Pause;

  const factory PlayAudioAction.stop() = _Stop;

  const factory PlayAudioAction.seekTo(Duration position) = _SeekTo;

  const factory PlayAudioAction.toggleLoopMode() = _Loop;

  const factory PlayAudioAction.next() = _Next;

  const factory PlayAudioAction.prev() = _Prev;

  const factory PlayAudioAction.countdownTime(CountdownTime time) =
      _CountdownTime;
}

extension PlayAudioActionX on PlayAudioAction {
  bool get isPlay => this is _Play;

  // bool get isLoop => this is _Loop;

  bool get isNext => this is _Next;

  bool get isPrev => this is _Prev;

  bool get isCountdown => this is _CountdownTime;

  bool get isLoopMode => this is _Loop;
}
