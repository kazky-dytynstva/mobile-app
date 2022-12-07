import 'package:flutter/material.dart';
import 'package:mobile_app/presentation/resource/r.dart';

class FadeAnimatedSwitcher extends AnimatedSwitcher {
  factory FadeAnimatedSwitcher.screen({
    required Widget child,
  }) =>
      FadeAnimatedSwitcher.middle(child: child);

  FadeAnimatedSwitcher.short({
    Key? key,
    required Widget child,
  }) : super(
          key: key,
          duration: R.durations.animShort,
          child: child,
        );

  FadeAnimatedSwitcher.middle({
    Key? key,
    required Widget child,
  }) : super(
          key: key,
          duration: R.durations.animMiddle,
          child: child,
        );

  FadeAnimatedSwitcher.long({
    Key? key,
    required Widget child,
  }) : super(
          key: key,
          duration: R.durations.animLong,
          child: child,
        );
}
