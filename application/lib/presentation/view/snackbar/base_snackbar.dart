import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_icon.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/button/button_ghost.dart';
import 'package:mobile_app/presentation/widget/svg_widget.dart';

abstract class BaseSnackbar {
  BaseSnackbar();

  String? get title => null;

  Color get titleColor => R.palette.textWhite;

  TextStyle get titleStyle => R.styles.textSubTitle.copyWith(color: titleColor);

  String get message;

  Color get messageColor => R.palette.textWhite;

  TextStyle get messageStyle => R.styles.textBody.copyWith(color: messageColor);

  SvgAssetIcon? get icon => null;

  double? get iconSize => null;

  Color get iconColor => R.palette.iconColorInverse;

  Duration? get duration => null;

  Duration get animationDuration => R.durations.animMiddle;

  Color get backgroundColor => R.palette.snackbarBackground;

  Color get progressColor => R.palette.accent;

  VoidCallback? get dismissCallback => null;

  bool get floating => false;

  bool get routeBlur => false;

  bool get showProgress => false;

  SnackbarActionData? get actionData => null;

  Flushbar? _flushbar;

  void show(BuildContext context) {
    _flushbar = Flushbar(
      mainButton: _buildButton(),
      title: title,
      titleColor: titleStyle.color,
      titleSize: titleStyle.fontSize,
      message: message,
      messageColor: messageStyle.color,
      messageSize: messageStyle.fontSize,
      onStatusChanged: _onStatusChanged,
      showProgressIndicator: showProgress,
      progressIndicatorBackgroundColor: progressColor,
      icon: _buildIcon(),
      backgroundColor: backgroundColor,
      duration: duration ?? const Duration(seconds: 4),
      flushbarStyle: floating ? FlushbarStyle.FLOATING : FlushbarStyle.GROUNDED,
      routeBlur: routeBlur ? 1.0 : 0.0,
      animationDuration: animationDuration,
      blockBackgroundInteraction: routeBlur,
    );
    _flushbar?.show(context);
  }

  Widget? _buildIcon() {
    final icon = this.icon;
    if (icon == null) return null;
    return SvgWidget.icon(
      icon,
      color: iconColor,
      width: iconSize,
      height: iconSize,
    );
  }

  Widget? _buildButton() {
    final data = actionData;
    if (data == null) return null;
    var pressed = false;
    return ButtonGhost.text(
      data.text,
      onPressed: () {
        if (pressed) return;
        pressed = true;
        _flushbar?.dismiss();
        data.onPressed.call();
      },
      textColor: data.textColor ?? R.palette.textWhite,
    );
  }

  void _onStatusChanged(FlushbarStatus? status) {
    if (status == null) return;
    switch (status) {
      case FlushbarStatus.DISMISSED:
        dismissCallback?.call();
        break;
      case FlushbarStatus.SHOWING:
      case FlushbarStatus.IS_APPEARING:
      case FlushbarStatus.IS_HIDING:
        break;
    }
  }
}

@immutable
class SnackbarActionData {
  final String text;
  final VoidCallback onPressed;
  final Color? textColor;

  const SnackbarActionData(
    this.text,
    this.onPressed, [
    this.textColor,
  ]);
}
