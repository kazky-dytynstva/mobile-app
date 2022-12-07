import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/sort_and_filter/filter_type.dart';
import 'package:mobile_app/domain/model/tale_sort_and_filter/tale_filter_item_data.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/selectable_item.dart';

class TaleFilterPageItem extends StatelessWidget {
  final TaleFilterItemData item;
  final VoidCallback onPressed;
  final TaleFilterType selectedType;

  const TaleFilterPageItem({
    required this.item,
    required this.onPressed,
    required this.selectedType,
    Key? key,
  }) : super(key: key);

  TextStyle get style => R.styles.textSubTitle;

  @override
  Widget build(BuildContext context) => SelectableItem(
        icon: item.icon,
        title: item.name,
        trailing: _createCounter(),
        onPressed: onPressed,
        isSelected: selectedType == item.type,
      );

  Widget _createCounter() {
    final text = Text(
      item.amount.get().toString(),
      style: style,
    );
    return Padding(
      padding: EdgeInsets.only(right: R.dimen.unit2),
      child: text,
    );
  }
}
