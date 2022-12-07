import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile_app/presentation/resource/r.dart';

class BlinkingDot extends StatefulWidget {
  final double? size;
  final Color? dotColor;
  final Color? borderColor;

  const BlinkingDot({
    this.size,
    this.dotColor,
    this.borderColor,
    Key? key,
  }) : super(key: key);

  @override
  State<BlinkingDot> createState() => _BlinkingDotState();
}

class _BlinkingDotState extends State<BlinkingDot>
    with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    duration: R.durations.animLong * 2,
  )
    ..repeat(reverse: true)
    ..drive(CurveTween(curve: Curves.easeOut));

  double get size => widget.size ?? R.dimen.unit1_5;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: _animationController,
        child: _buildDot(),
      );

  Widget _buildDot() => Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: widget.dotColor ?? R.palette.accent,
          borderRadius: R.styles.imageBorderRadius,
          border: Border.all(
            color: widget.borderColor ?? R.palette.background,
            width: max(2, size * 0.1),
          ),
        ),
      );
}
