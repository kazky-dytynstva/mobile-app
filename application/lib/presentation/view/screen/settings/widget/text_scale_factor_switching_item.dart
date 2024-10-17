import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/settings/text_scale_factor.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/list_item.dart';

class TextScaleFactorSwitchingItem extends StatelessWidget {
  final TextScaleFactor scaleFactor;
  final VoidCallback onPressed;
  final TextScaleFactor selected;

  const TextScaleFactorSwitchingItem({
    super.key,
    required this.scaleFactor,
    required this.onPressed,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) => ListItem(
        withScreenSidePadding: true,
        title: _getName(),
        trailingChild: Radio(
          activeColor: R.palette.accent,
          value: scaleFactor,
          groupValue: selected,
          onChanged: (TextScaleFactor? newValue) => onPressed(),
        ),
        onPressed: onPressed,
      );

  String _getName() {
    switch (scaleFactor) {
      case TextScaleFactor.s:
        return R.strings.settings.textScaleFactorTitleS;
      case TextScaleFactor.m:
        return R.strings.settings.textScaleFactorTitleM;
      case TextScaleFactor.l:
        return R.strings.settings.textScaleFactorTitleL;
      case TextScaleFactor.xl:
        return R.strings.settings.textScaleFactorTitleXL;
    }
  }
}
