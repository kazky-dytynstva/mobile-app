import 'package:flutter/material.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/custom_theme.dart';

class MadeWithLove extends StatelessWidget with CustomThemeStatelessMixin {
  final double scaleFactor;

  const MadeWithLove({
    this.scaleFactor = 2,
  }) : super(key: null);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Text(
      R.strings.general.madeWithLove,
      textAlign: TextAlign.center,
      style: R.styles.textCaption.withNiceFont,
      textScaleFactor: scaleFactor,
    );
  }
}
