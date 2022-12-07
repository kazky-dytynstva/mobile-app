import 'package:flutter/material.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_icon.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/button/button_mixin.dart';

class ButtonPrimary extends StatelessWidget with ButtonMixin {
  final VoidCallback? onPressed;
  final SvgAssetIcon? _assetIcon;
  final Color? _iconColor;
  final String? _text;
  final Widget? _child;
  final bool _allCaps;
  final bool _positionIconAtEdge;
  final EdgeInsets? _contentPadding;

  const ButtonPrimary({
    required this.onPressed,
    required Widget child,
    EdgeInsets? contentPadding,
    Key? key,
  })  : _child = child,
        _text = null,
        _assetIcon = null,
        _iconColor = null,
        _allCaps = false,
        _positionIconAtEdge = false,
        _contentPadding = contentPadding,
        super(key: key);

  const ButtonPrimary.text(
    String text, {
    required this.onPressed,
    bool allCaps = true,
    EdgeInsets? contentPadding,
    Key? key,
  })  : _child = null,
        _text = text,
        _allCaps = allCaps,
        _assetIcon = null,
        _iconColor = null,
        _positionIconAtEdge = false,
        _contentPadding = contentPadding,
        super(key: key);

  const ButtonPrimary.textWithIcon(
    String text,
    SvgAssetIcon icon, {
    required this.onPressed,
    Color? iconColor,
    bool allCaps = true,
    bool positionIconAtEdge = false,
    EdgeInsets? contentPadding,
    Key? key,
  })  : _child = null,
        _text = text,
        _assetIcon = icon,
        _allCaps = allCaps,
        _iconColor = iconColor,
        _positionIconAtEdge = positionIconAtEdge,
        _contentPadding = contentPadding,
        super(key: key);

  const ButtonPrimary.icon(
    SvgAssetIcon icon, {
    required this.onPressed,
    Color? iconColor,
    bool allCaps = true,
    EdgeInsets? contentPadding,
    Key? key,
  })  : _child = null,
        _text = null,
        _assetIcon = icon,
        _iconColor = iconColor,
        _allCaps = allCaps,
        _positionIconAtEdge = false,
        _contentPadding = contentPadding,
        super(key: key);

  @override
  ButtonStyle get buttonStyle => ElevatedButton.styleFrom(
        elevation: R.dimen.elevation,
        backgroundColor: R.palette.buttonPrimary,
        shape: buttonShape,
        padding: _contentPadding ?? contentPadding,
        maximumSize: maxHeight,
      );

  Color getIconColor() => _iconColor ?? R.palette.iconColorInverse;

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
      whiteTextColor: true,
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
            white: true,
            color: null,
          );
  }

  Widget? _buildIcon() {
    final icon = _assetIcon;
    return (icon == null) ? null : buildIcon(icon, color: getIconColor());
  }
}
