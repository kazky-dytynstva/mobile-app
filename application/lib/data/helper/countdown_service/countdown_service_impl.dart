import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/helper/countdown_service.dart';
import 'package:mobile_app/domain/model/play_audio_action/play_audio_action.dart';
import 'package:mobile_app/domain/model/player/countdown_time.dart';
import 'package:mobile_app/data/helper/player/audio_player.dart';
import 'package:mobile_app/data/util/countdown_timer.dart';

const _tick = Duration(seconds: 1);

@LazySingleton(as: CountdownService)
class CountdownServiceImpl implements CountdownService {
  final AudioPlayer _player;
  CountdownTimer? _timer;

  final _pingWhenDoneListeners = <Function>[];
  StreamSubscription? _subscription;

  CountdownServiceImpl(
    this._player,
  );

  @override
  void set(CountdownTime time) {
    _subscription?.cancel();
    _pingWhenDoneListeners.clear();
    if (time.isOff) {
      _timer?.cancel();
      _player.action(const PlayAudioAction.pause());
    } else {
      _timer = CountdownTimer(time.duration, _tick);
      _subscription = _timer!.listen(
        (_) {},
        onDone: () async {
          await _player.action(const PlayAudioAction.stop());
          for (final callback in _pingWhenDoneListeners) {
            callback.call();
          }
          _pingWhenDoneListeners.clear();
        },
      );
      _player.action(const PlayAudioAction.play());
    }
  }

  @override
  bool get isRunning => _timer?.isRunning ?? false;

  @override
  Duration get remainingTime =>
      isRunning ? _timer?.remaining ?? Duration.zero : Duration.zero;

  @override
  void pingWhenDone(Function callback) {
    _pingWhenDoneListeners.add(callback);
  }
}
