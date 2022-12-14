import 'package:flutter/material.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_icon.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/snackbar/base_snackbar.dart';

class InfoSnackbar extends BaseSnackbar {
  final String? _title;
  final String _msg;
  final VoidCallback? onDismiss;

  InfoSnackbar({
    required String message,
    String? title,
    this.onDismiss,
  })  : _title = title,
        _msg = message;

  @override
  VoidCallback? get dismissCallback => onDismiss;

  @override
  String? get title => _title;

  @override
  String get message => _msg;

  @override
  SvgAssetIcon get icon => R.assets.icons.info;
}
