import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/settings/text_scale_factor.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/custom_theme.dart';

class MadeWithLove extends StatelessWidget with CustomThemeStatelessMixin {
  final TextScaleFactor scaleFactor;

  const MadeWithLove({
    this.scaleFactor = TextScaleFactor.xl,
  }) : super(key: null);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Text(
      R.strings.general.madeWithLove,
      textAlign: TextAlign.center,
      style: R.styles.textCaption.withNiceFont,
      textScaler: scaleFactor.value,
    );
  }
}
