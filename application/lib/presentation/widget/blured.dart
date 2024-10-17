import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/presentation/resource/r.dart';

class Blurred extends StatelessWidget {
  final Widget child;
  final double blur;
  final Color? blurColor;
  final double? colorOpacity;

  const Blurred({
    required this.child,
    required this.blur,
    this.blurColor,
    this.colorOpacity,
    super.key,
  })  : assert(blur >= 0),
        assert(blur <= 10);

  @override
  Widget build(BuildContext context) => Blur(
        blur: blur,
        blurColor: blurColor ?? R.palette.white,
        colorOpacity: colorOpacity ?? 0.5,
        child: child,
      );
}
