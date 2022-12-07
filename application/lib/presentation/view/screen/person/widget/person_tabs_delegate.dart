import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/app_tab/app_tab_data.dart';
import 'package:mobile_app/domain/model/person/person_tales_tab_data.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/tabs/app_tab_bar.dart';

class PersonTabsDelegate extends SliverPersistentHeaderDelegate {
  final List<PersonTalesTabData> pages;
  final TabController tabController;

  PersonTabsDelegate(
    this.pages,
    this.tabController,
  );

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final child = pages.isEmpty
        ? R.spaces.empty
        : AppTabBar(
            controller: tabController,
            tabDataList: pages.map((e) => AppTabData(label: e.label)).toList(),
            isScrollable: pages.length > 2,
          );
    return Container(
      color: R.palette.background,
      height: maxExtent,
      child: child,
    );
  }

  @override
  double get maxExtent => R.dimen.toolbarHeight;

  @override
  double get minExtent => R.dimen.toolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
