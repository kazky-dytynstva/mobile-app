import 'dart:async';

import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';

class AudioSessionHandler {
  final Future<AudioSession> _sessionsFuture;
  final AudioPlayer _player;

  AudioSessionHandler(
    this._sessionsFuture,
    this._player,
  );

  bool _wasPlaying = false;

  bool get _isPlayingNow => _player.playing;
  bool _initDone = false;

  void init() async {
    if (_initDone) return;
    _initDone = true;
    final session = await _sessionsFuture;
    session.configure(const AudioSessionConfiguration.speech());
    session.interruptionEventStream.listen(_interruptionHandler);
    session.becomingNoisyEventStream.listen(_unpluggedHeadphonesHandler);
  }

  void _unpluggedHeadphonesHandler(_) {
    if (!_isPlayingNow) return;
    _player.pause();
  }

  void _interruptionHandler(AudioInterruptionEvent event) {
    if (event.begin) {
      if (!_isPlayingNow) return;
      _wasPlaying = true;
      switch (event.type) {
        case AudioInterruptionType.duck:
          break;
        case AudioInterruptionType.pause:
        case AudioInterruptionType.unknown:
          _player.pause();
          break;
      }
    } else if (_wasPlaying) {
      switch (event.type) {
        case AudioInterruptionType.duck:
          break;
        case AudioInterruptionType.pause:
          _player.play();
          break;
        case AudioInterruptionType.unknown:
          // The interruption ended but we should not resume.
          break;
      }
    }
  }
}
