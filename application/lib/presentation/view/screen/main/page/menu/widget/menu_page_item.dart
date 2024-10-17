import 'package:flutter/material.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_icon.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/blinking_dot.dart';
import 'package:mobile_app/presentation/widget/list_item.dart';

class MenuPageItem extends StatefulWidget {
  final String title;
  final SvgAssetIcon icon;
  final VoidCallback? onPressed;
  final String? subTitle;
  final bool showBlinkingDot;
  final bool accentIcon;

  const MenuPageItem({
    required this.title,
    required this.icon,
    required this.onPressed,
    this.subTitle,
    this.showBlinkingDot = false,
    this.accentIcon = false,
    super.key,
  });

  @override
  State<MenuPageItem> createState() => _MenuPageItemState();
}

class _MenuPageItemState extends State<MenuPageItem> {
  double get sidePadding => R.dimen.screenPaddingSide / 2;

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.fromLTRB(
      sidePadding + R.dimen.unit,
      0,
      sidePadding,
      0,
    );
    final subTitle = widget.subTitle;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: sidePadding),
      child: ListItem(
        contentPadding: padding,
        leadingIcon: widget.icon,
        leadingIconColor: widget.accentIcon ? R.palette.accent : null,
        trailingChild: _buildBlinkingDot(),
        title: widget.title,
        subTitle: subTitle,
        onPressed: widget.onPressed,
      ),
    );
  }

  Widget? _buildBlinkingDot() => !widget.showBlinkingDot
      ? null
      : Padding(
          padding: EdgeInsets.symmetric(horizontal: R.dimen.unit),
          child: BlinkingDot(borderColor: R.palette.background),
        );
}
