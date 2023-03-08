import 'package:flutter/material.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_icon.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/svg_widget.dart';

mixin ButtonMixin {
  SvgWidget buildIcon(
    SvgAssetIcon icon, {
    required Color color,
    double? size,
  }) =>
      SvgWidget.icon(
        icon,
        color: color,
        width: size ?? R.dimen.iconSize,
        height: size ?? R.dimen.iconSize,
      );

  Text buildText(
    String text, {
    required bool allCaps,
    required bool inverse,
    required bool white,
    required Color? color,
  }) {
    assert(
      inverse == false || white == false,
      'inverse and white can not be true at the same time',
    );
    final style = R.styles.textButton;
    final textColor = color ??
        (white
            ? R.palette.textWhite
            : inverse
                ? R.palette.textPrimaryInverted
                : style.color);
    return Text(
      allCaps ? text.toUpperCase() : text,
      style: style.copyWith(color: textColor, height: 1),
    );
  }

  Row buildTextWithIcon(
    String text,
    SvgAssetIcon icon, {
    required bool allCaps,
    required bool inverseTextColor,
    required bool whiteTextColor,
    required Color iconColor,
    required bool positionIconAtEdge,
    required Color? textColor,
  }) {
    final textWidget = buildText(
      text,
      allCaps: allCaps,
      inverse: inverseTextColor,
      white: whiteTextColor,
      color: textColor,
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildIcon(icon, color: iconColor),
        positionIconAtEdge ? R.spaces.expanded : R.spaces.horizontalUnit,
        textWidget,
        positionIconAtEdge ? R.spaces.expanded : R.spaces.empty,
      ],
    );
  }

  OutlinedBorder get buttonShape =>
      RoundedRectangleBorder(borderRadius: R.styles.roundBorder);

  OutlinedBorder getButtonShapeOutline(Color? lineColor) => buttonShape
      .copyWith(side: BorderSide(color: lineColor ?? R.palette.buttonPrimary));

  EdgeInsets get contentPadding => EdgeInsets.all(R.dimen.unit1_5);

  Size get maxHeight => Size.fromHeight(R.dimen.buttonHeight);

  ButtonStyle get buttonStyle;
}
