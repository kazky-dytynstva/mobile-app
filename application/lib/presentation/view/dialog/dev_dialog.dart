import 'package:flutter/material.dart';
import 'package:mobile_app/presentation/view/dialog/base/base_dialog.dart';

class DevDialog extends BaseDialog {
  final String msg;
  final VoidCallback _onClosePressed;

  const DevDialog(
    this.msg,
    this._onClosePressed, {
    super.key,
  });

  @override
  BaseDialogState<BaseDialog> createState() => _State();
}

class _State extends BaseDialogState<DevDialog> {
  @override
  String? get title => 'Dev dialog';

  @override
  String? get message => widget.msg;

  @override
  VoidCallback get getCloseBtnCallback => widget._onClosePressed;
}
