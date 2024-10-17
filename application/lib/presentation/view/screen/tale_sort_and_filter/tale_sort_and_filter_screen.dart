import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/domain/model/app_tab/app_tab_data.dart';
import 'package:mobile_app/domain/model/sort_and_filter/data/sort_and_filter_open_type.dart';
import 'package:mobile_app/domain/model/sort_and_filter/filter_type.dart';
import 'package:mobile_app/domain/model/sort_and_filter/sort_type.dart';
import 'package:mobile_app/domain/model/tale_sort_and_filter/tale_filter_item_data.dart';
import 'package:mobile_app/domain/model/tale_sort_and_filter/tale_sort_item_data.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_icon.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/screen_mixin.dart';
import 'package:mobile_app/presentation/view/screen/tale_sort_and_filter/manager/tale_sort_and_filter_manager.dart';
import 'package:mobile_app/presentation/view/screen/manager_view_mixin.dart';
import 'package:mobile_app/presentation/view/screen/tale_sort_and_filter/page/tale_filter_page.dart';
import 'package:mobile_app/presentation/view/screen/tale_sort_and_filter/page/tale_sort_page.dart';
import 'package:mobile_app/presentation/widget/bottom_bar_with_actions.dart';
import 'package:mobile_app/presentation/widget/button/button_secondary.dart';
import 'package:mobile_app/presentation/widget/fade_animated_switcher.dart';
import 'package:mobile_app/presentation/widget/tabs/app_tab_bar.dart';

@RoutePage()
class TaleSortAndFilterScreen extends StatefulWidget {
  final SortAndFilterOpenType openType;
  final TaleFilterType initialFilterType;
  final TaleSortType initialSortType;

  const TaleSortAndFilterScreen(
    this.openType,
    this.initialFilterType,
    this.initialSortType, {
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TaleSortAndFilterScreenState();
}

class _TaleSortAndFilterScreenState
    extends ScreenWidgetState<TaleSortAndFilterScreen, TaleSortAndFilterManager>
    with ManagerViewMixin, SingleTickerProviderStateMixin {
  late final tabsController = TabController(
    length: 2,
    initialIndex: widget.openType.index,
    vsync: this,
  );

  @override
  void initState() {
    manager.init(widget.initialFilterType, widget.initialSortType);
    super.initState();
  }

  @override
  void dispose() {
    tabsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget stateBuilder(BuildContext context, TaleSortAndFilterState state) {
      final widget = state.map(
        initial: buildInitialState,
        ready: _buildStateReady,
      );
      return FadeAnimatedSwitcher.screen(child: widget);
    }

    final blocBuilder =
        BlocBuilder<TaleSortAndFilterManager, TaleSortAndFilterState>(
      bloc: manager,
      builder: stateBuilder,
    );

    return Scaffold(body: blocBuilder);
  }

  Widget _buildStateReady(TaleSortAndFilterStateReady state) {
    final pager = _buildPager(
      state.filterItems,
      state.selectedFilterType,
      state.sortItems,
      state.selectedSortType,
    );
    final List<Widget> columnChildren = [
      _buildTabBar(),
      Expanded(child: pager),
      _buildBottomBar(state.showApplyButton),
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: columnChildren,
    );
  }

  Widget _buildPager(
    List<TaleFilterItemData> filterItems,
    TaleFilterType selectedFilterType,
    List<TaleSortItemData> sortItems,
    TaleSortType selectedSortType,
  ) {
    final pageFilter = TaleFilterPage(
      filterItems: filterItems,
      selected: selectedFilterType,
      onItemPressed: manager.onFilterPressed,
    );
    final pageSort = TaleSortPage(
      sortItems: sortItems,
      selected: selectedSortType,
      onItemPressed: manager.onSortPressed,
    );
    return TabBarView(
      controller: tabsController,
      children: [pageFilter, pageSort],
    );
  }

  Widget _buildBottomBar(bool showApplyButton) => BottomBarWithActions(
      itemsAlignment: MainAxisAlignment.spaceAround,
      onBackPressed: manager.onBackPressed,
      items: [_buildApplyBtn(showApplyButton)]);

  Widget _buildApplyBtn(bool showApplyButton) {
    final child = showApplyButton
        ? ButtonSecondary.text(
            R.strings.sortAndFilter.btnApply,
            onPressed: manager.onApplyBtnPressed,
          )
        : R.spaces.empty;
    return FadeAnimatedSwitcher.long(child: child);
  }

  AppTabBar _buildTabBar() {
    AppTabData buildTab(String text, SvgAssetIcon icon) => AppTabData(
          label: StringSingleLine(text),
          icon: icon,
        );

    final items = [
      buildTab(R.strings.sortAndFilter.btnFilter, R.assets.icons.filter),
      buildTab(R.strings.sortAndFilter.btnSort, R.assets.icons.sort),
    ];

    return AppTabBar(
      tabDataList: items,
      controller: tabsController,
      respectTopPadding: true,
    );
  }
}
