import 'package:flutter/material.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_graphic.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/dialog/base/base_dialog.dart';

class WipDialog extends BaseDialog {
  final VoidCallback _onClosePressed;

  const WipDialog(
    this._onClosePressed, {
    super.key,
  });

  @override
  BaseDialogState<BaseDialog> createState() => _State();
}

class _State extends BaseDialogState<WipDialog> {
  @override
  SvgAssetGraphic? get image => R.assets.graphics.wip;

  @override
  String? get title => R.strings.dialog.wipTitle;

  @override
  String? get message => R.strings.dialog.wipMsg;

  @override
  VoidCallback get getCloseBtnCallback => widget._onClosePressed;
}
