import 'package:flutter/material.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/dialog/base/base_dialog.dart';

class SwitchToWiFiDialog extends BaseDialog {
  final VoidCallback onContinuePressed;
  final VoidCallback _onClosePressed;

  const SwitchToWiFiDialog({
    required this.onContinuePressed,
    required VoidCallback onClosePressed,
    Key? key,
  })  : _onClosePressed = onClosePressed,
        super(key: key);

  @override
  BaseDialogState<BaseDialog> createState() => _State();
}

class _State extends BaseDialogState<SwitchToWiFiDialog> {
  @override
  String get title => R.strings.dialog.switchToWiFiTitle;

  @override
  String? get message => R.strings.dialog.switchToWiFiMsg;

  @override
  DialogBtnData get positiveBtnData => DialogBtnData(
        text: R.strings.dialog.switchToWiFiPos,
        onPressed: widget._onClosePressed,
        icon: R.assets.icons.circleCross,
        positionIconAtEdge: true,
      );

  @override
  DialogBtnData? get negativeBtnData => DialogBtnData(
        text: R.strings.dialog.switchToWiFiNeg,
        onPressed: widget.onContinuePressed,
        icon: R.assets.icons.download,
        positionIconAtEdge: true,
      );
}
