import 'package:flutter/material.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_icon.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/button/button_mixin.dart';

class ButtonSecondary extends StatelessWidget with ButtonMixin {
  final VoidCallback? onPressed;
  final SvgAssetIcon? _assetIcon;
  final Color? _iconColor;
  final Color? _outlineColor;
  final Color? _bgColor;
  final String? _text;
  final Widget? _child;
  final bool _allCaps;
  final bool _fixedMaxHeight;
  final bool _positionIconAtEdge;
  final EdgeInsets? _contentPadding;

  const ButtonSecondary({
    required this.onPressed,
    required Widget child,
    bool fixedMaxHeight = false,
    EdgeInsets? contentPadding,
    Color? bgColor,
    Color? outlineColor,
    super.key,
  })  : _child = child,
        _text = null,
        _assetIcon = null,
        _contentPadding = contentPadding,
        _bgColor = bgColor,
        _outlineColor = outlineColor,
        _iconColor = null,
        _allCaps = false,
        _positionIconAtEdge = false,
        _fixedMaxHeight = fixedMaxHeight;

  const ButtonSecondary.text(
    String text, {
    required this.onPressed,
    bool allCaps = true,
    bool fixedMaxHeight = true,
    EdgeInsets? contentPadding,
    Color? bgColor,
    Color? outlineColor,
    super.key,
  })  : _child = null,
        _text = text,
        _allCaps = allCaps,
        _fixedMaxHeight = fixedMaxHeight,
        _bgColor = bgColor,
        _outlineColor = outlineColor,
        _assetIcon = null,
        _iconColor = null,
        _positionIconAtEdge = false,
        _contentPadding = contentPadding;

  const ButtonSecondary.textWithIcon(
    String text,
    SvgAssetIcon icon, {
    required this.onPressed,
    Color? iconColor,
    bool allCaps = true,
    bool fixedMaxHeight = true,
    bool positionIconAtEdge = false,
    EdgeInsets? contentPadding,
    Color? bgColor,
    Color? outlineColor,
    super.key,
  })  : _child = null,
        _text = text,
        _assetIcon = icon,
        _allCaps = allCaps,
        _iconColor = iconColor,
        _outlineColor = outlineColor,
        _bgColor = bgColor,
        _fixedMaxHeight = fixedMaxHeight,
        _positionIconAtEdge = positionIconAtEdge,
        _contentPadding = contentPadding;

  const ButtonSecondary.icon(
    SvgAssetIcon icon, {
    required this.onPressed,
    Color? iconColor,
    bool allCaps = true,
    bool fixedMaxHeight = true,
    EdgeInsets? contentPadding,
    Color? bgColor,
    Color? outlineColor,
    super.key,
  })  : _child = null,
        _text = null,
        _assetIcon = icon,
        _iconColor = iconColor,
        _bgColor = bgColor,
        _outlineColor = outlineColor,
        _allCaps = allCaps,
        _fixedMaxHeight = fixedMaxHeight,
        _positionIconAtEdge = false,
        _contentPadding = contentPadding;

  @override
  ButtonStyle get buttonStyle => TextButton.styleFrom(
        elevation: 0,
        foregroundColor: R.palette.splashColorWithoutOpacity,
        backgroundColor: _bgColor ?? R.palette.cardBackground,
        shape: getButtonShapeOutline(_outlineColor),
        padding: _contentPadding ?? contentPadding,
        maximumSize: _fixedMaxHeight ? maxHeight : null,
      );

  Color getIconColor() => _iconColor ?? R.palette.iconColor;

  @override
  Widget build(BuildContext context) {
    final child =
        _child ?? _buildTextWithIcon() ?? _buildText() ?? _buildIcon();

    return ElevatedButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: child!,
    );
  }

  Widget? _buildTextWithIcon() {
    final text = _text;
    if (text == null) return null;
    final icon = _assetIcon;
    if (icon == null) return null;
    return buildTextWithIcon(
      text,
      icon,
      allCaps: _allCaps,
      iconColor: getIconColor(),
      inverseTextColor: false,
      whiteTextColor: false,
      positionIconAtEdge: _positionIconAtEdge,
      textColor: null,
    );
  }

  Widget? _buildText() {
    final text = _text;
    return (text == null)
        ? null
        : buildText(
            text,
            allCaps: _allCaps,
            inverse: false,
            white: false,
            color: null,
          );
  }

  Widget? _buildIcon() {
    final icon = _assetIcon;
    return (icon == null) ? null : buildIcon(icon, color: getIconColor());
  }
}
