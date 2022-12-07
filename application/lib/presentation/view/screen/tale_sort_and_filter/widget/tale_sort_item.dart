import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/sort_and_filter/sort_type.dart';
import 'package:mobile_app/domain/model/tale_sort_and_filter/tale_sort_item_data.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/selectable_item.dart';

class TaleSortPageItem extends StatelessWidget {
  final TaleSortItemData item;
  final VoidCallback onPressed;
  final TaleSortType selectedType;

  const TaleSortPageItem({
    Key? key,
    required this.item,
    required this.selectedType,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SelectableItem(
        title: item.name,
        trailing: Radio(
          activeColor: R.palette.accent,
          value: item.type,
          groupValue: selectedType,
          onChanged: (TaleSortType? newValue) => onPressed(),
        ),
        onPressed: onPressed,
        isSelected: selectedType == item.type,
      );
}
