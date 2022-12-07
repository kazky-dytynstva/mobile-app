import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/sort_and_filter/sort_type.dart';
import 'package:mobile_app/domain/model/tale_sort_and_filter/tale_sort_item_data.dart';
import 'package:mobile_app/presentation/view/screen/tale_sort_and_filter/widget/tale_sort_item.dart';

typedef OnItemPressed = Function(TaleSortType type);

class TaleSortPage extends StatelessWidget {
  final List<TaleSortItemData> sortItems;
  final TaleSortType selected;
  final OnItemPressed onItemPressed;

  const TaleSortPage({
    required this.sortItems,
    required this.selected,
    required this.onItemPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = sortItems.map(_buildItem).toList();
    final column = Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
    return Center(
      child: SingleChildScrollView(child: column),
    );
  }

  Widget _buildItem(TaleSortItemData sortItem) => TaleSortPageItem(
        item: sortItem,
        selectedType: selected,
        onPressed: () => onItemPressed(sortItem.type),
      );
}
