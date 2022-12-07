import 'package:flutter/material.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_icon.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/snackbar/base_snackbar.dart';

class ErrorSnackbar extends BaseSnackbar {
  final String? _title;
  final String _msg;

  ErrorSnackbar({
    required String message,
    String? title,
  })  : _title = title,
        _msg = message;

  @override
  String? get title => _title;

  @override
  String get message => _msg;

  @override
  SvgAssetIcon get icon => R.assets.icons.info;

  @override
  Color get backgroundColor => R.palette.error;

  @override
  bool get routeBlur => true;
}
