import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/play_audio_action/play_audio_action.dart';
import 'package:mobile_app/domain/model/play_audio_status/play_audio_status.dart';
import 'package:mobile_app/domain/model/player/countdown_time.dart';
import 'package:mobile_app/domain/model/player/loop_mode.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_icon.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/util/keys.dart';
import 'package:mobile_app/presentation/widget/button/button_icon.dart';
import 'package:mobile_app/presentation/widget/fade_animated_switcher.dart';

typedef OnActionPressed = Function(PlayAudioAction action);

class ListenAudioControls extends StatelessWidget {
  final PlayAudioStatus status;
  final OnActionPressed onActionPressed;
  final bool countdownActive;
  final PlayerLoopMode loopMode;

  const ListenAudioControls({
    required this.status,
    required this.onActionPressed,
    required this.countdownActive,
    required this.loopMode,
    Key? key,
  }) : super(key: key);

  double get _sizeL => R.dimen.unit4;

  double get _sizeM => _sizeL - R.dimen.unit;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      _buildCountdown(),
      _buildPrev(),
      _buildPlay(),
      _buildNext(),
      _buildLoopMode(),
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children,
    );
  }

  Widget _buildPrev() => _buildBtn(
        R.assets.icons.audioPrev,
        _sizeM,
        () => onActionPressed(const PlayAudioAction.prev()),
        Keys.audioControlPrev,
      );

  Widget _buildNext() => _buildBtn(
        R.assets.icons.audioNext,
        _sizeM,
        () => onActionPressed(const PlayAudioAction.next()),
        Keys.audioControlNext,
      );

  Widget _buildLoopMode() {
    final btn = _buildBtn(
      _getLoopModeIcon(),
      _sizeM,
      () => onActionPressed(const PlayAudioAction.toggleLoopMode()),
      Keys.audioControlLoopMode(loopMode),
    );
    return fadeAnimated(btn);
  }

  SvgAssetIcon _getLoopModeIcon() {
    switch (loopMode) {
      case PlayerLoopMode.off:
        return R.assets.icons.repeatOff;
      case PlayerLoopMode.all:
        return R.assets.icons.repeatAll;
      case PlayerLoopMode.one:
        return R.assets.icons.repeatOne;
    }
  }

  Widget _buildCountdown() {
    final btn = _buildBtn(
      R.assets.icons.stopwatch,
      _sizeM,
      () => onActionPressed(
          const PlayAudioAction.countdownTime(CountdownTime.off)),
      Keys.audioControlCountdown(countdownActive),
      color: countdownActive ? R.palette.accent : null,
    );
    return fadeAnimated(btn);
  }

  Widget _buildPlay() {
    final icon =
        status.isPlaying ? R.assets.icons.audioPause : R.assets.icons.audioPlay;
    final key =
        status.isPlaying ? Keys.audioControlPause : Keys.audioControlPlay;
    void action() {
      final action = status.isPlaying
          ? const PlayAudioAction.pause()
          : const PlayAudioAction.play();
      onActionPressed(action);
    }

    final btn = _buildBtn(
      icon,
      _sizeL,
      action,
      key,
    );
    return fadeAnimated(btn);
  }

  Widget _buildBtn(
    SvgAssetIcon icon,
    double size,
    VoidCallback onPressed,
    Key key, {
    Color? color,
  }) =>
      ButtonIcon(
        icon,
        onPressed: onPressed,
        size: size,
        key: key,
        color: color,
      );

  Widget fadeAnimated(Widget child) =>
      FadeAnimatedSwitcher.middle(child: child);
}
