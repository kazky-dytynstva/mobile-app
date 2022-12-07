part of '../r.dart';

class Palette {
  final AppTheme _appTheme;

  Palette._(this._appTheme);

  // Primary colors
  //ignore: unused_field
  static const _blue = Color(0xff233565);
  static const _black = Color(0xff131313);
  static const _trueBlack = Color(0xff000000);

  //ignore: unused_field
  static const _black29 = Color(0xff292929);

  //ignore: unused_field
  static const _black33 = Color(0xff333333);
  static const _redAccent = Color(0xFFFF5252);

  // Secondary Colors
  static const _lightGrey = Color(0xfff0f0f0);
  static const _mediumGrey = Color(0xffc4c4c4);
  static const _darkGrey = Color(0xff787878);
  static const _white = Color(0xffffffff);
  static const _yellow = Color(0xFFFBC02D);
  static const _green = Color(0xFF7CB342);
  static const _red = Color(0xFFA81010);
  static const _transparent = Color(0x00000000);

  Color get transparent => _transparent;

  Color get accent => _redAccent;

  Color get white => _white;

  Color get background => _themed(light: _white, dark: _trueBlack);

  Color get cardBackground => _themed(light: _lightGrey, dark: _black29);

  Color get iconColor => _themed(light: _darkGrey, dark: _white);

  Color get iconColorInverse => _themed(light: _white, dark: _white);

  Color get iconColorDisabled => _themed(light: _mediumGrey, dark: _darkGrey);

  Color get primary => _themed(light: _lightGrey, dark: _black);

  Color get textWhite => _white;

  Color get textPrimary => _themed(light: _black, dark: _lightGrey);

  Color get textPrimaryInverted => _themed(light: _white, dark: _black);

  Color get textSecondary => _themed(light: _darkGrey, dark: _darkGrey);

  Color get divider => _themed(light: _mediumGrey, dark: _darkGrey);

  Color get error => _red;

  Color get buttonPrimary => accent;

  Color get buttonFab => _themed(light: _lightGrey, dark: _black29);

  Color get doneColor => _themed(light: _green, dark: _green);

  Color get ratingColor => _themed(light: _yellow, dark: _yellow);

  Color get snackbarBackground => _themed(light: _black33, dark: _black33);

  Color get heartColor => _redAccent;

  Color get checkBoxCheck => _white;

  Color get splashColorWithoutOpacity => accent;

  Color get splashColor => _themed(
        light: splashColorWithoutOpacity.withOpacity(0.4),
        dark: splashColorWithoutOpacity.withOpacity(0.7),
      );

  Color get highlightColor => _themed(
        light: _darkGrey.withOpacity(0.3),
        dark: _darkGrey.withOpacity(0.3),
      );

  Color get tabLabelColorInActive => textPrimary;

  Color get tabLabelColorActive => white;

  Color get personAvatarBoxShadow => background.withOpacity(0.4);

  Color _themed({
    required Color light,
    required Color dark,
  }) {
    return _appTheme.map(
      system: () => _appTheme.brightness.isDark ? dark : light,
      light: () => light,
      dark: () => dark,
    );
  }
}
