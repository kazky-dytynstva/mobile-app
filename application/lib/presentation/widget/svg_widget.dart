import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_app/domain/value_objects/asset_file_path.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_graphic.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_icon.dart';
import 'package:mobile_app/domain/value_objects/svg_string.dart';
import 'package:mobile_app/presentation/resource/r.dart';

class SvgWidget extends StatelessWidget {
  final SvgString? _svgString;
  final AssetFilePath? _assetPath;
  final SvgAssetIcon? _svgIcon;
  final SvgAssetGraphic? _svgGraphic;
  final double? width;
  final double? height;
  final Color? color;
  final bool disabled;

  const SvgWidget.string(
    SvgString string, {
    this.width,
    this.height,
    this.disabled = false,
    Key? key,
  })  : _svgString = string,
        _svgIcon = null,
        _svgGraphic = null,
        _assetPath = null,
        color = null,
        super(key: key);

  const SvgWidget.asset(
    AssetFilePath assetPath, {
    this.width,
    this.height,
    this.disabled = false,
    Key? key,
  })  : _svgString = null,
        _svgIcon = null,
        _svgGraphic = null,
        color = null,
        _assetPath = assetPath,
        super(key: key);

  const SvgWidget.icon(
    SvgAssetIcon icon, {
    this.width,
    this.height,
    this.color,
    this.disabled = false,
    Key? key,
  })  : _svgString = null,
        _assetPath = null,
        _svgGraphic = null,
        _svgIcon = icon,
        super(key: key);

  const SvgWidget.graphic(
    SvgAssetGraphic graphic, {
    this.width,
    this.height,
    this.color,
    this.disabled = false,
    Key? key,
  })  : _svgString = null,
        _assetPath = null,
        _svgGraphic = graphic,
        _svgIcon = null,
        super(key: key);

  @override
  Widget build(BuildContext context) =>
      _fromString() ?? _fromIcon() ?? _fromAsset() ?? _fromGraphic()!;

  Widget? _fromString() {
    final string = _svgString;
    if (string == null) return null;
    return SvgPicture.string(
      string.get(),
      width: width,
      height: height,
    );
  }

  Widget? _fromAsset() {
    final asset = _assetPath;
    if (asset == null) return null;
    return SvgPicture.asset(
      asset.get(),
      width: width,
      height: height,
    );
  }

  Widget? _fromIcon() {
    final icon = _svgIcon;
    if (icon == null) return null;
    return SvgPicture.asset(
      icon.path,
      width: width ?? R.dimen.iconSize,
      height: height ?? R.dimen.iconSize,
      color: color ?? R.palette.iconColor,
    );
  }

  Widget? _fromGraphic() {
    final graphic = _svgGraphic;
    if (graphic == null) return null;
    return SvgPicture.asset(
      graphic.path,
      width: width,
      height: height,
    );
  }
}
