import 'package:flutter/material.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_icon.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/snackbar/base_snackbar.dart';

class InfoSnackbar extends BaseSnackbar {
  final String? _title;
  final String _msg;
  final bool? blurBackground;
  final VoidCallback? onDismiss;
  final Duration? showDuration;

  InfoSnackbar({
    required String message,
    String? title,
    required this.onDismiss,
    required this.blurBackground,
    required this.showDuration,
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

  @override
  bool get routeBlur => blurBackground ?? false;

  @override
  Duration? get duration => showDuration;
}
