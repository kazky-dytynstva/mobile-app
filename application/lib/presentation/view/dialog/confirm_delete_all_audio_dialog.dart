import 'package:flutter/material.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/dialog/base/base_dialog.dart';

class ConfirmDeleteAllAudioDialog extends BaseDialog {
  final VoidCallback onConfirmPressed;
  final VoidCallback _onClosePressed;

  const ConfirmDeleteAllAudioDialog({
    required this.onConfirmPressed,
    required VoidCallback onClosePressed,
    super.key,
  }) : _onClosePressed = onClosePressed;

  @override
  BaseDialogState<BaseDialog> createState() => _State();
}

class _State extends BaseDialogState<ConfirmDeleteAllAudioDialog> {
  @override
  String get title => R.strings.dialog.confirmDeleteAllAudioTitle;

  @override
  DialogBtnData get positiveBtnData => DialogBtnData(
        text: R.strings.dialog.confirmDeleteAllAudioPos,
        onPressed: widget.onConfirmPressed,
        icon: R.assets.icons.trash,
        positionIconAtEdge: true,
      );

  @override
  DialogBtnData? get negativeBtnData => DialogBtnData(
        text: R.strings.general.cancel,
        onPressed: widget._onClosePressed,
        icon: R.assets.icons.circleCross,
        positionIconAtEdge: true,
      );
}
