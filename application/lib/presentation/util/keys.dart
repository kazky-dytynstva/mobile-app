import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/player/loop_mode.dart';

abstract class Keys {
  Keys._();

  static const audioControlPlay = Key('audioControlPlay');
  static const audioControlPause = Key('audioControlPause');
  static const audioControlNext = Key('audioControlNext');
  static const audioControlPrev = Key('audioControlPrev');

  static audioControlLoopMode(PlayerLoopMode mode) => Key('audioControl$mode');

  static audioControlCountdown(bool active) =>
      Key('audioControlCountdown$active');
}
