part of '../r.dart';

class Styles {
  final Palette _palette;
  final Dimen _dimen;
  final TextTheme _textTheme;

  Styles._(
    ThemeData themeData,
    this._palette,
    this._dimen,
  ) : _textTheme = themeData.textTheme;

  //ignore: unused_element
  FontWeight get textWeightBold => FontWeight.w700;

  FontWeight get textWeightMedium => FontWeight.w500;

  FontWeight get textWeightNormal => FontWeight.w400;

  //region main text styles
  TextStyle get textHeadline => _textTheme.headline6!.copyWith(
        color: _palette.textPrimary,
        fontSize: 22,
        fontWeight: textWeightMedium,
        letterSpacing: 0.15,
      );

  TextStyle get textSubTitle => _textTheme.subtitle1!.copyWith(
        color: _palette.textPrimary,
        fontSize: 17,
        fontWeight: textWeightNormal,
        letterSpacing: 0.15,
      );

  TextStyle get taleText => textSubTitle;

  TextStyle get textSubTitleSecondary =>
      textSubTitle.copyWith(color: _palette.textSecondary);

  TextStyle get textBody => _textTheme.bodyText2!.copyWith(
        color: _palette.textPrimary,
        fontWeight: textWeightNormal,
        fontSize: 14.0,
        letterSpacing: 0.25,
      );

  TextStyle get textBodySecondary => textBody.copyWith(
        color: _palette.textSecondary,
      );

  TextStyle get textCaption => _textTheme.caption!.copyWith(
        color: _palette.textPrimary,
        fontWeight: textWeightNormal,
        fontSize: 12.0,
        letterSpacing: 0.4,
      );

  //endregion main text styles

  //region secondary text styles

  TextStyle get textButton => textBody.copyWith(
        fontWeight: textWeightMedium,
        fontSize: 14,
        letterSpacing: 1.25,
      );

  TextStyle get textButtonInverse =>
      textButton.copyWith(color: _palette.textPrimary);

  TextStyle get toolbarTitle => textHeadline;
  TextStyle get toolbarSubTitle => textBody;

  //endregion secondary text styles
  BorderRadius get roundBorder => BorderRadius.circular(_dimen.unit);

  BorderRadius get roundBorder0_5 => BorderRadius.circular(_dimen.unit0_5);

  BorderRadius get imageBorderRadius => roundBorder * 1.5;

  BorderRadius get imageBorderRadiusSmall => roundBorder;

  BorderRadius get dialogTopBorder => BorderRadius.only(
        topLeft: Radius.circular(_dimen.unit3),
        topRight: Radius.circular(_dimen.unit3),
      );

  RoundedRectangleBorder get selectedShape => RoundedRectangleBorder(
        side: BorderSide(color: _palette.transparent),
        borderRadius: roundBorder,
      );
}

extension TextStyleX on TextStyle {
  TextStyle get withNiceFont => copyWith(fontFamily: 'Kotyhoroshko');
}
