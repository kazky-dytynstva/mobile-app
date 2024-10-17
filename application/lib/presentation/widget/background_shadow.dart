import 'package:flutter/material.dart';
import 'package:mobile_app/presentation/resource/r.dart';

class BackgroundShadow extends StatelessWidget {
  final Widget child;
  final double? height;

  const BackgroundShadow({
    required this.child,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final color = R.palette.background;
    final decor = BoxDecoration(
      gradient: LinearGradient(colors: [
        color,
        color.withAlpha(0),
      ], begin: const Alignment(0.0, 0.6), end: Alignment.topCenter),
    );
    return Container(
      height: height,
      decoration: decor,
      child: child,
    );
  }
}
