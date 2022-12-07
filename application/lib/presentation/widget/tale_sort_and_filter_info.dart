import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/tale_sort_and_filter/tale_filter_item_data.dart';
import 'package:mobile_app/domain/model/tale_sort_and_filter/tale_sort_item_data.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/svg_widget.dart';

class TaleSortAndFilterInfo extends StatelessWidget {
  final TaleFilterItemData filterData;
  final TaleSortItemData sortData;

  const TaleSortAndFilterInfo({
    required this.filterData,
    required this.sortData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameWithAmount =
        '${filterData.name.get()} (${filterData.amount.get()})';
    final title = Text(
      nameWithAmount,
      style: R.styles.textSubTitle,
    );
    final subtitle = Text(
      sortData.name.get(),
      style: R.styles.textBody,
    );
    final column = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [title, subtitle],
    );

    final iconSize = R.dimen.toolbarHeight - R.dimen.unit2;
    final icon = SvgWidget.graphic(
      filterData.icon,
      height: iconSize,
      width: iconSize,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        R.spaces.horizontalUnit2,
        column,
      ],
    );
  }
}
