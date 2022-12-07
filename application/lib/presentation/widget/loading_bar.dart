import 'package:flutter/material.dart';
import 'package:mobile_app/presentation/resource/r.dart';

class LoadingBar extends StatelessWidget {
  final double size;

  const LoadingBar({
    Key? key,
    this.size = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progress = CircularProgressIndicator(
      color: R.palette.accent,
    );

    return SizedBox(width: size, height: size, child: progress);
  }
}
