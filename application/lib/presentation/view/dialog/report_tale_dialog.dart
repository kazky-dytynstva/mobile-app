import 'package:flutter/material.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/dialog/base/base_dialog.dart';

class ReportTaleDialog extends BaseDialog {
  final VoidCallback onReportPressed;
  final VoidCallback onClosePressed;

  const ReportTaleDialog({
    required this.onReportPressed,
    required this.onClosePressed,
    super.key,
  });

  @override
  BaseDialogState<BaseDialog> createState() => _State();
}

class _State extends BaseDialogState<ReportTaleDialog> {
  @override
  String? get title => R.strings.dialog.reportTaleTitle;

  @override
  String? get message => R.strings.dialog.reportTaleMsg;

  @override
  VoidCallback get getCloseBtnCallback => widget.onClosePressed;

  @override
  DialogBtnData get positiveBtnData => DialogBtnData(
        text: R.strings.dialog.reportTalePos,
        onPressed: widget.onReportPressed,
        icon: R.assets.icons.report,
      );
}
