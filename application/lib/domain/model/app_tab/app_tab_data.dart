import 'package:flutter/material.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_icon.dart';

class AppTabData {
  final StringSingleLine label;
  final SvgAssetIcon? icon;
  final Key? key;

  const AppTabData({
    required this.label,
    this.icon,
    this.key,
  });
}
