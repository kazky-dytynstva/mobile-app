import 'package:flutter/material.dart';
import 'package:mobile_app/domain/extensions/string.dart';
import 'package:mobile_app/domain/model/player/countdown_time.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/dialog/base/base_dialog.dart';
import 'package:mobile_app/presentation/widget/flip_down_timer.dart';
import 'package:mobile_app/presentation/widget/list_item.dart';

typedef OnCountdownTimePressed = Function(CountdownTime time);

class AudiCountdownDialog extends BaseDialog {
  final Duration remainingTime;
  final OnCountdownTimePressed _onCountdownTimePressed;
  final VoidCallback _onClosePressed;

  const AudiCountdownDialog(
    this.remainingTime,
    this._onCountdownTimePressed,
    this._onClosePressed, {
    Key? key,
  }) : super(key: key);

  @override
  BaseDialogState<BaseDialog> createState() => _State();
}

class _State extends BaseDialogState<AudiCountdownDialog> {
  bool get isActive => widget.remainingTime.inSeconds > 0;

  @override
  String? get title => isActive
      ? R.strings.dialog.audioCountdownTitleActive
      : R.strings.dialog.audioCountdownTitleInActive;

  @override
  VoidCallback get getCloseBtnCallback => widget._onClosePressed;

  @override
  Widget get content =>
      isActive ? _buildActiveCountdown() : _buildInActiveCountdown();

  @override
  DialogBtnData? get positiveBtnData => !isActive
      ? null
      : DialogBtnData(
          text: R.strings.general.cancel,
          onPressed: () => widget._onCountdownTimePressed(CountdownTime.off),
        );

  Widget _buildInActiveCountdown() {
    final items = CountdownTime.values
        .where((element) => !element.isOff)
        .map(_createItem)
        .toList();
    final column = Column(
      mainAxisSize: MainAxisSize.min,
      children: items,
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: R.dimen.dialogOutsidePadding),
      child: column,
    );
  }

  Widget _buildActiveCountdown() => FlipDownTimer(
        duration: widget.remainingTime,
        digitSize: R.dimen.unit5,
        onDone: widget._onClosePressed,
      );

  Widget _createItem(CountdownTime time) => ListItem(
        title: R.strings.general.minutes
            .format(time.duration.inMinutes.toString()),
        onPressed: () => widget._onCountdownTimePressed(time),
      );
}
