import 'package:flutter/material.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/button/fab.dart';
import 'package:mobile_app/presentation/widget/svg_widget.dart';

class Favorite extends StatelessWidget {
  final bool isFav;
  final VoidCallback _onPressed;
  final bool mini;
  final bool asFab;

  const Favorite({
    required VoidCallback onPressed,
    required this.isFav,
    this.mini = false,
    this.asFab = true,
    super.key,
  }) : _onPressed = onPressed;

  double get _iconSize => R.dimen.iconSize;

  @override
  Widget build(BuildContext context) {
    final switcher = AnimatedSwitcher(
      duration: R.durations.animShort,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      child: _getIcon(),
    );
    final padding = Padding(
      padding: EdgeInsets.all(R.dimen.unit),
      child: switcher,
    );
    return asFab
        ? Fab(
            padding,
            onPressed: _onPressed,
            mini: mini,
          )
        : InkWell(
            borderRadius: BorderRadius.all(Radius.circular(_iconSize)),
            onTap: _onPressed,
            child: padding,
          );
  }

  SvgWidget _getIcon() {
    final icon = isFav ? R.assets.icons.heartSolid : R.assets.icons.heart;
    final color = isFav ? R.palette.heartColor : R.palette.iconColor;
    return SvgWidget.icon(
      icon,
      width: _iconSize,
      height: _iconSize,
      color: color,
      key: isFav ? const ValueKey(true) : const ValueKey(false),
    );
  }
}
