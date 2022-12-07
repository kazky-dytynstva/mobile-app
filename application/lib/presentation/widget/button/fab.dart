import 'package:flutter/material.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_icon.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/loading_bar.dart';
import 'package:mobile_app/presentation/widget/svg_widget.dart';

class Fab extends FloatingActionButton {
  Fab(
    Widget child, {
    required VoidCallback onPressed,
    bool mini = false,
    Key? key,
    Clip clipBehavior = Clip.none,
  }) : super(
          key: key,
          child: child,
          onPressed: onPressed,
          mini: mini,
          heroTag: null,
          clipBehavior: clipBehavior,
          backgroundColor: R.palette.buttonFab,
        );

  Fab.icon(
    SvgAssetIcon icon, {
    required VoidCallback onPressed,
    bool mini = false,
    bool accentIcon = false,
    Color? iconColor,
    Key? key,
  }) : super(
          key: key,
          child: SvgWidget.icon(
            icon,
            color: accentIcon
                ? R.palette.accent
                : iconColor ?? R.palette.iconColor,
            width: mini ? R.dimen.unit3 : R.dimen.unit4,
          ),
          onPressed: onPressed,
          mini: mini,
          heroTag: null,
          backgroundColor: R.palette.buttonFab,
        );

  Fab.asProgress({
    bool mini = true,
    Key? key,
  }) : super(
          key: key,
          child: Padding(
            padding: EdgeInsets.all(R.dimen.unit),
            child: const LoadingBar(),
          ),
          onPressed: null,
          mini: mini,
          heroTag: null,
          backgroundColor: R.palette.buttonFab,
        );
}
