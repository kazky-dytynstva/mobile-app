import 'package:flutter/cupertino.dart';

enum AppTheme {
  system,
  light,
  dark,
}

extension AppThemeX on AppTheme {
  bool get isDark => this == AppTheme.dark;

  bool get isLight => this == AppTheme.light;

  T map<T>({
    required T Function() system,
    required T Function() light,
    required T Function() dark,
  }) {
    switch (this) {
      case AppTheme.dark:
        return dark();
      case AppTheme.light:
        return light();
      case AppTheme.system:
        return system();
    }
  }

  Brightness get brightness {
    switch (this) {
      case AppTheme.light:
        return Brightness.light;
      case AppTheme.dark:
        return Brightness.dark;
      case AppTheme.system:
      default:
        //ignore: deprecated_member_use
        return WidgetsBinding.instance.window.platformBrightness;
    }
  }
}

extension BrightnessX on Brightness {
  bool get isDark => this == Brightness.dark;
}
