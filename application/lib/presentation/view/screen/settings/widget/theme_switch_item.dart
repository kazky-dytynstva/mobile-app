import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/app_theme/app_theme.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/list_item.dart';

class ThemeSwitchItem extends StatelessWidget {
  final AppTheme item;
  final VoidCallback onPressed;
  final AppTheme selectedTheme;

  const ThemeSwitchItem({
    Key? key,
    required this.item,
    required this.onPressed,
    required this.selectedTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListItem(
        withScreenSidePadding: true,
        title: _getThemeName(),
        trailingChild: Radio(
          activeColor: R.palette.accent,
          value: item,
          groupValue: selectedTheme,
          onChanged: (AppTheme? newValue) => onPressed(),
        ),
        onPressed: onPressed,
      );

  String _getThemeName() => item.map(
        system: () => R.strings.settings.themeNameSystem,
        dark: () => R.strings.settings.themeNameDark,
        light: () => R.strings.settings.themeNameLight,
      );
}
