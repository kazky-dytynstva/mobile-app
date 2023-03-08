import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/app_theme/app_theme.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/settings/widget/theme_switch_item.dart';
import 'package:mobile_app/presentation/widget/labeled_child.dart';

typedef OnThemeChanged = Function(AppTheme appTheme);

class SettingsSectionAppTheme extends StatelessWidget {
  final AppTheme currentTheme;
  final OnThemeChanged onThemeChanged;

  const SettingsSectionAppTheme({
    required this.currentTheme,
    required this.onThemeChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeSwitchers = AppTheme.values.map(
      (theme) => ThemeSwitchItem(
        item: theme,
        onPressed: () => onThemeChanged(theme),
        selectedTheme: currentTheme,
      ),
    );
    return LabeledChildren(
      label: R.strings.settings.sectionLabelAppTheme,
      children: themeSwitchers.toList(),
    );
  }
}
