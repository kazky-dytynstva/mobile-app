import 'package:flutter/material.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_icon.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/button/button_mixin.dart';

class ButtonGhost extends StatelessWidget with ButtonMixin {
  final VoidCallback? onPressed;
  final SvgAssetIcon? _assetIcon;
  final Color? _iconColor;
  final String? _text;
  final Widget? _child;
  final bool _allCaps;
  final bool _positionIconAtEdge;
  final bool _fixedMaxHeight;
  final Color? _textColor;
  final EdgeInsets? _contentPadding;

  const ButtonGhost({
    required this.onPressed,
    required Widget child,
    bool fixedMaxHeight = false,
    EdgeInsets? contentPadding,
    Key? key,
  })  : _child = child,
        _text = null,
        _assetIcon = null,
        _iconColor = null,
        _allCaps = false,
        _textColor = null,
        _positionIconAtEdge = false,
        _fixedMaxHeight = fixedMaxHeight,
        _contentPadding = contentPadding,
        super(key: key);

  const ButtonGhost.text(
    String text, {
    required this.onPressed,
    bool allCaps = true,
    bool fixedMaxHeight = true,
    Color? textColor,
    EdgeInsets? contentPadding,
    Key? key,
  })  : _child = null,
        _text = text,
        _allCaps = allCaps,
        _textColor = textColor,
        _assetIcon = null,
        _iconColor = null,
        _fixedMaxHeight = fixedMaxHeight,
        _positionIconAtEdge = false,
        _contentPadding = contentPadding,
        super(key: key);

  const ButtonGhost.textWithIcon(
    String text,
    SvgAssetIcon icon, {
    required this.onPressed,
    Color? iconColor,
    bool allCaps = true,
    bool fixedMaxHeight = true,
    bool positionIconAtEdge = false,
    Color? textColor,
    EdgeInsets? contentPadding,
    Key? key,
  })  : _child = null,
        _text = text,
        _assetIcon = icon,
        _allCaps = allCaps,
        _textColor = textColor,
        _iconColor = iconColor,
        _fixedMaxHeight = fixedMaxHeight,
        _positionIconAtEdge = positionIconAtEdge,
        _contentPadding = contentPadding,
        super(key: key);

  const ButtonGhost.icon(
    SvgAssetIcon icon, {
    required this.onPressed,
    Color? iconColor,
    bool fixedMaxHeight = true,
    EdgeInsets? contentPadding,
    Key? key,
  })  : _child = null,
        _text = null,
        _assetIcon = icon,
        _iconColor = iconColor,
        _allCaps = false,
        _textColor = null,
        _fixedMaxHeight = fixedMaxHeight,
        _positionIconAtEdge = false,
        _contentPadding = contentPadding,
        super(key: key);

  @override
  ButtonStyle get buttonStyle => TextButton.styleFrom(
        foregroundColor: R.palette.splashColorWithoutOpacity,
        shape: buttonShape,
        padding: _contentPadding ?? contentPadding,
        maximumSize: _fixedMaxHeight ? maxHeight : null,
      );

  Color getIconColor() => _iconColor ?? R.palette.iconColor;

  @override
  Widget build(BuildContext context) {
    final child =
        _child ?? _buildTextWithIcon() ?? _buildText() ?? _buildIcon();

    return TextButton(
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
      textColor: _textColor,
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
            color: _textColor,
          );
  }

  Widget? _buildIcon() {
    final icon = _assetIcon;
    return (icon == null) ? null : buildIcon(icon, color: getIconColor());
  }
}
