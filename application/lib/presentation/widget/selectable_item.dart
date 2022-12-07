import 'package:flutter/material.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_graphic.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/svg_widget.dart';

class SelectableItem extends StatelessWidget {
  final SvgAssetGraphic? icon;
  final StringSingleLine title;
  final Widget trailing;
  final bool isSelected;
  final VoidCallback onPressed;

  const SelectableItem({
    required this.title,
    required this.trailing,
    required this.onPressed,
    required this.isSelected,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tile = ListTile(
      leading: _buildLeadingIcon(),
      shape: R.styles.selectedShape,
      title: Text(
        title.get(),
        style: R.styles.textSubTitle,
      ),
      trailing: trailing,
      onTap: () => onPressed(),
    );

    Widget selected() => Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: R.palette.accent,
              width: 1,
            ),
            borderRadius: R.styles.roundBorder,
          ),
          child: tile,
        );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: R.dimen.screenPaddingSide),
      child: isSelected ? selected() : tile,
    );
  }

  Widget? _buildLeadingIcon() {
    final icon = this.icon;
    if (icon == null) return null;
    final iconSize = R.dimen.unit4;
    return SvgWidget.graphic(icon, width: iconSize, height: iconSize);
  }
}
