import 'package:flutter/material.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_icon.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/button/button_mixin.dart';
import 'package:mobile_app/presentation/widget/svg_widget.dart';

class ButtonIcon extends StatelessWidget with ButtonMixin {
  final SvgAssetIcon icon;
  final VoidCallback onPressed;
  final EdgeInsets? iconPadding;
  final Color? color;
  final double? size;

  const ButtonIcon(
    this.icon, {
    required this.onPressed,
    this.color,
    this.size,
    this.iconPadding,
    Key? key,
  }) : super(key: key);

  EdgeInsets get _padding => iconPadding ?? EdgeInsets.all(R.dimen.unit);

  double get _size => size ?? R.dimen.iconSize;

  double get _splashRadius => _size;

  @override
  Widget build(BuildContext context) => InkResponse(
        borderRadius: BorderRadius.all(Radius.circular(_size)),
        onTap: onPressed,
        radius: _splashRadius,
        child: _buildIcon(),
      );

  @override
  ButtonStyle get buttonStyle => throw UnimplementedError();

  Widget _buildIcon() => Padding(
        padding: _padding,
        child: SvgWidget.icon(
          icon,
          width: _size,
          height: _size,
          color: color ?? R.palette.iconColor,
        ),
      );
}
