part of '../r.dart';

ThemeData _createThemeData(
  Brightness brightness,
  Palette palette,
  Dimen dimen,
) {
  final colorScheme = brightness == Brightness.light
      ? const ColorScheme.light()
      : const ColorScheme.dark().copyWith(
          onSurface: palette.background,
          onBackground: palette.background,
        );
  return ThemeData(
    // fontFamily: 'NotoSans',
    brightness: brightness,
    colorScheme: colorScheme.copyWith(
      primary: palette.primary,
      secondary: palette.accent,
    ),
    splashColor: palette.splashColor,
    highlightColor: palette.highlightColor,
    dialogBackgroundColor: palette.background,
    backgroundColor: palette.background,
    scaffoldBackgroundColor: palette.background,
    dividerColor: palette.divider,
    unselectedWidgetColor: palette.iconColorDisabled,
  );
}
