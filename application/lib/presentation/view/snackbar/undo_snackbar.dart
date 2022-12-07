import 'dart:ui';

import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/snackbar/base_snackbar.dart';

class UndoSnackbar extends BaseSnackbar {
  final String? _title;
  final String _msg;
  final VoidCallback onUndoPressed;
  final VoidCallback? onDismiss;

  UndoSnackbar({
    required String message,
    required this.onUndoPressed,
    String? title,
    this.onDismiss,
  })  : _msg = message,
        _title = title;

  @override
  VoidCallback? get dismissCallback => onDismiss;

  @override
  String? get title => _title;

  @override
  String get message => _msg;

  @override
  SnackbarActionData? get actionData => SnackbarActionData(
        R.strings.general.cancel,
        onUndoPressed,
      );
}
