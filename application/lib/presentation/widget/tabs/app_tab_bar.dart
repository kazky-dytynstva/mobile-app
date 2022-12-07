import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/app_tab/app_tab_data.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/tabs/app_tab.dart';

class AppTabBar extends StatefulWidget implements PreferredSizeWidget {
  final bool isScrollable;
  final List<AppTabData> tabDataList;
  final EdgeInsets? padding;
  final TabController controller;
  final bool respectTopPadding;

  const AppTabBar({
    required this.tabDataList,
    required this.controller,
    this.isScrollable = false,
    this.respectTopPadding = false,
    this.padding,
    Key? key,
  })  : assert(
          tabDataList.length > 0,
          'There should be at least 1 $AppTabData',
        ),
        super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(R.dimen.toolbarHeight);

  @override
  State<AppTabBar> createState() => _AppTabBarState();
}

class _AppTabBarState extends State<AppTabBar> {
  late var selectedIndex = widget.controller.index;
  var goingRight = true;
  late var aValue = widget.controller.animation?.value ?? 0.0;

  EdgeInsets get _padding {
    final padding = widget.padding ?? EdgeInsets.zero;

    return widget.respectTopPadding
        ? padding.copyWith(top: R.dimen.screenPadding.top)
        : padding;
  }

  @override
  void initState() {
    final animation = widget.controller.animation;
    if (animation != null) {
      animation.addListener(() {
        aValue = animation.value;
        selectedIndex = widget.controller.index;
        goingRight = aValue >= selectedIndex;
        setState(() {});
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = <AppTab>[];
    for (int i = 0; i < widget.tabDataList.length; i++) {
      final data = widget.tabDataList[i];
      late final double colorPercent;
      //1 - selected
      //0 - unselected
      if (selectedIndex == i) {
        colorPercent = goingRight
            ? 1 - (aValue - selectedIndex)
            : 1 - (selectedIndex - aValue);
      } else if (selectedIndex + 1 == i && goingRight) {
        colorPercent = max(0, aValue - selectedIndex);
      } else if (selectedIndex - 1 == i && !goingRight) {
        colorPercent = max(0, selectedIndex - aValue);
      } else {
        colorPercent = 0;
      }

      final tab = AppTab(
        data: data,
        selectPercent: colorPercent,
      );
      tabs.add(tab);
    }
    return TabBar(
      tabs: tabs,
      controller: widget.controller,
      isScrollable: widget.isScrollable,
      padding: _padding,
      indicatorPadding: EdgeInsets.all(R.dimen.unit0_5),
      indicator: ShapeDecoration(
        shape: R.styles.selectedShape,
        color: R.palette.accent,
      ),
      splashBorderRadius: R.styles.roundBorder,
    );
  }
}
