import 'package:flutter/material.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_icon.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/fade_animated_switcher.dart';
import 'package:mobile_app/presentation/widget/svg_widget.dart';

class ListItem extends StatelessWidget {
  final String title;
  final String? subTitle;
  final VoidCallback? onPressed;
  final SvgAssetIcon? leadingIcon;
  final Widget? trailingChild;
  final EdgeInsets? contentPadding;
  final bool withScreenSidePadding;
  final bool centerLeadingVertically;
  final Color? leadingIconColor;

  const ListItem({
    required this.title,
    this.subTitle,
    this.onPressed,
    this.leadingIcon,
    this.trailingChild,
    this.contentPadding,
    this.withScreenSidePadding = false,
    this.centerLeadingVertically = true,
    this.leadingIconColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        contentPadding: withScreenSidePadding
            ? EdgeInsets.symmetric(horizontal: R.dimen.screenPaddingSide)
            : contentPadding,
        leading: _buildLeadingIcon(),
        shape: R.styles.selectedShape,
        title: _buildTitle(),
        subtitle: _buildSubTitle(),
        trailing: trailingChild,
        onTap: onPressed,
      );

  Widget _buildTitle() => Text(
        title,
        style: R.styles.textSubTitle,
        key: Key(title),
      );

  Widget? _buildSubTitle() {
    final subTitle = this.subTitle;
    if (subTitle == null) return null;
    final text = Text(
      subTitle,
      style: R.styles.textBodySecondary,
      key: Key(subTitle),
    );
    return Padding(
      padding: EdgeInsets.only(top: R.dimen.unit0_5),
      child: text,
    );
  }

  Widget? _buildLeadingIcon() {
    final leadingIcon = this.leadingIcon;
    if (leadingIcon == null) return null;
    final iconSize = R.dimen.unit3;
    final icon = SvgWidget.icon(
      leadingIcon,
      width: iconSize,
      height: iconSize,
      color: leadingIconColor,
      key: ValueKey(leadingIcon),
    );
    return !centerLeadingVertically
        ? _animated(icon)
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_animated(icon)],
          );
  }

  Widget _animated(Widget child) => FadeAnimatedSwitcher.short(child: child);
}
