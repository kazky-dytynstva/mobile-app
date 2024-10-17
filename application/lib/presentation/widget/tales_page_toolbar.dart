import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/tale_sort_and_filter/tale_filter_item_data.dart';
import 'package:mobile_app/domain/model/tale_sort_and_filter/tale_sort_item_data.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/tale_sort_and_filter_info.dart';

class TalesPageToolbar extends StatelessWidget {
  final TaleFilterItemData filterData;
  final TaleSortItemData sortData;

  const TalesPageToolbar({
    super.key,
    required this.filterData,
    required this.sortData,
  });

  @override
  Widget build(BuildContext context) {
    final info = TaleSortAndFilterInfo(
      filterData: filterData,
      sortData: sortData,
    );
    return AppBar(
      elevation: R.dimen.elevation,
      backgroundColor: R.palette.primary,
      title: Padding(
        padding: EdgeInsets.only(right: R.dimen.toolbarHeight),
        child: info,
      ),
      automaticallyImplyLeading: false,
    );
  }
}
