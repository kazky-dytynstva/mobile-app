import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/settings/text_scale_factor.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/settings/widget/settings_section.dart';
import 'package:mobile_app/presentation/view/screen/settings/widget/text_scale_factor_switching_item.dart';

typedef OnTextScaleFactorPressed = Function(TextScaleFactor factor);

class SettingsSectionTextScaleFactor extends StatelessWidget {
  final TextScaleFactor currentFactor;
  final OnTextScaleFactorPressed onPressed;

  const SettingsSectionTextScaleFactor({
    required this.currentFactor,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SettingsSection(
        label: R.strings.settings.sectionLabelTextScaleFactor,
        children: _getListOfScaleFactors(),
      );

  List<Widget> _getListOfScaleFactors() => TextScaleFactor.values
      .map(
        (e) => TextScaleFactorSwitchingItem(
          scaleFactor: e,
          onPressed: () => onPressed(e),
          selected: currentFactor,
        ),
      )
      .toList();
}
