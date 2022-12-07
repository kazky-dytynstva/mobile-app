import 'package:flip_board/flip_clock.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/presentation/resource/r.dart';

class FlipDownTimer extends StatefulWidget {
  final Duration duration;
  final double? digitSize;
  final Function? onDone;
  final Color? digitColor;
  final Color? cardColor;

  const FlipDownTimer({
    required this.duration,
    this.digitSize,
    this.onDone,
    this.digitColor,
    this.cardColor,
    Key? key,
  }) : super(key: key);

  @override
  State<FlipDownTimer> createState() => _FlipDownTimerState();
}

class _FlipDownTimerState extends State<FlipDownTimer> {
  double get digitSize => widget.digitSize ?? R.styles.textHeadline.fontSize!;

  @override
  Widget build(BuildContext context) => FlipCountdownClock(
        flipDirection: AxisDirection.down,
        duration: widget.duration,
        digitSize: digitSize,
        width: digitSize * 1.2,
        height: digitSize * 1.5,
        digitColor: widget.digitColor ?? R.palette.textWhite,
        backgroundColor: widget.cardColor ?? R.palette.accent,
        separatorColor: R.palette.textPrimary,
        borderColor: R.palette.divider,
        hingeColor: R.palette.divider,
        borderRadius: R.styles.imageBorderRadiusSmall,
        onDone: () => (mounted) ? widget.onDone?.call() : {},
      );
}
