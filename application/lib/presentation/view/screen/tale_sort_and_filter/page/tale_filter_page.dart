import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/sort_and_filter/filter_type.dart';
import 'package:mobile_app/domain/model/tale_sort_and_filter/tale_filter_item_data.dart';
import 'package:mobile_app/presentation/view/screen/tale_sort_and_filter/widget/tale_filter_item.dart';

typedef OnItemPressed = Function(TaleFilterType type);

class TaleFilterPage extends StatelessWidget {
  final List<TaleFilterItemData> filterItems;
  final TaleFilterType selected;
  final OnItemPressed onItemPressed;

  const TaleFilterPage({
    required this.filterItems,
    required this.selected,
    required this.onItemPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = filterItems.map(_buildFilterItem).toList();
    final column = Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
    return Center(
      child: SingleChildScrollView(child: column),
    );
  }

  Widget _buildFilterItem(TaleFilterItemData item) => TaleFilterPageItem(
        item: item,
        onPressed: () => onItemPressed(item.type),
        selectedType: selected,
      );
}
