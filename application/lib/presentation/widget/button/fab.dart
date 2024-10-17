import 'package:flutter/material.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_icon.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/loading_bar.dart';
import 'package:mobile_app/presentation/widget/svg_widget.dart';

class Fab extends FloatingActionButton {
  Fab(
    Widget child, {
    required VoidCallback super.onPressed,
    super.mini,
    super.key,
    super.clipBehavior,
  }) : super(
          child: child,
          heroTag: null,
          backgroundColor: R.palette.buttonFab,
        );

  Fab.icon(
    SvgAssetIcon icon, {
    required VoidCallback super.onPressed,
    super.mini,
    bool accentIcon = false,
    Color? iconColor,
    super.key,
  }) : super(
          child: SvgWidget.icon(
            icon,
            color: accentIcon
                ? R.palette.accent
                : iconColor ?? R.palette.iconColor,
            width: mini ? R.dimen.unit3 : R.dimen.unit4,
          ),
          heroTag: null,
          backgroundColor: R.palette.buttonFab,
        );

  Fab.asProgress({
    super.mini = true,
    super.key,
  }) : super(
          child: Padding(
            padding: EdgeInsets.all(R.dimen.unit),
            child: const LoadingBar(),
          ),
          onPressed: null,
          heroTag: null,
          backgroundColor: R.palette.buttonFab,
        );
}
