import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/tale/tale_more_item.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/dialog/base/base_dialog.dart';

typedef OnTaleMoreItemPressed = Function(TaleMoreType);

class TaleMoreDialog extends BaseDialog {
  final OnTaleMoreItemPressed onTaleMoreItemPressed;

  const TaleMoreDialog({
    required this.onTaleMoreItemPressed,
    Key? key,
  }) : super(key: key);

  @override
  BaseDialogState<BaseDialog> createState() => _State();
}

class _State extends BaseDialogState<TaleMoreDialog> {
  @override
  List<DialogBtnData> get buttonList => [
        _getTaleReportData(),
        _getSettingsData(),
      ];

  DialogBtnData _getSettingsData() => DialogBtnData(
        text: R.strings.dialog.taleMoreBtnSettings,
        icon: R.assets.icons.settings,
        onPressed: () => widget.onTaleMoreItemPressed(TaleMoreType.settings),
      );

  DialogBtnData _getTaleReportData() => DialogBtnData(
        text: R.strings.dialog.taleMoreBtnReport,
        icon: R.assets.icons.report,
        onPressed: () => widget.onTaleMoreItemPressed(TaleMoreType.reportTale),
      );
}
