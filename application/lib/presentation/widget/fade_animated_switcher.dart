import 'package:flutter/material.dart';
import 'package:mobile_app/presentation/resource/r.dart';

class FadeAnimatedSwitcher extends AnimatedSwitcher {
  factory FadeAnimatedSwitcher.screen({
    required Widget child,
  }) =>
      FadeAnimatedSwitcher.middle(child: child);

  FadeAnimatedSwitcher.short({
    super.key,
    required Widget super.child,
  }) : super(
          duration: R.durations.animShort,
        );

  FadeAnimatedSwitcher.middle({
    super.key,
    required Widget super.child,
  }) : super(
          duration: R.durations.animMiddle,
        );

  FadeAnimatedSwitcher.long({
    super.key,
    required Widget super.child,
  }) : super(
          duration: R.durations.animLong,
        );
}
