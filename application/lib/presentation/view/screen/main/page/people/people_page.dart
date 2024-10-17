import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/domain/model/app_tab/app_tab_data.dart';
import 'package:mobile_app/domain/model/people/people_page_tab_data.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/data/di/dependency_injection.dart';
import 'package:mobile_app/presentation/view/screen/main/page/people/manager/people_page_manager.dart';
import 'package:mobile_app/presentation/view/screen/main/page/people/widget/role_people_tab_page.dart';
import 'package:mobile_app/presentation/view/screen/manager_view_mixin.dart';
import 'package:mobile_app/presentation/widget/custom_theme.dart';
import 'package:mobile_app/presentation/widget/fade_animated_switcher.dart';
import 'package:mobile_app/presentation/widget/tabs/app_tab_bar.dart';

@RoutePage()
class PeoplePage extends StatefulWidget {
  const PeoplePage({super.key});

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage>
    with
        AutomaticKeepAliveClientMixin,
        ManagerViewMixin,
        CustomThemeStatefulMixin,
        SingleTickerProviderStateMixin {
  late final _manager = getIt<PeoplePageManager>();

  @override
  bool get wantKeepAlive => true;

  TabController? tabsController;

  @override
  void dispose() {
    tabsController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Widget stateBuilder(BuildContext context, PeoplePageState state) {
      final widget = state.map(
        initial: buildInitialState,
        ready: _buildStateReady,
      );
      return FadeAnimatedSwitcher.screen(child: widget);
    }

    return BlocBuilder(bloc: _manager, builder: stateBuilder);
  }

  Widget _buildStateReady(PeoplePageStateReady state) {
    tabsController ??= TabController(
      length: state.tabDataList.length,
      vsync: this,
    );
    return Scaffold(
      appBar: AppBar(title: _buildTabs(state.tabDataList.map((e) => e.label))),
      body: _buildViewPager(state.tabDataList),
    );
  }

  AppTabBar _buildTabs(Iterable<StringSingleLine> pages) {
    final items = pages.map((e) => AppTabData(label: e)).toList();

    return AppTabBar(
      controller: tabsController!,
      tabDataList: items,
      isScrollable: true,
    );
  }

  Widget _buildViewPager(List<PeoplePageTabData> tabLabels) {
    Widget buildPage(PeoplePageTabData tabData) {
      void onPositionChanged(double position) {
        _manager.onScrollPositionChanged(tabData, position);
      }

      return RolePeopleTabPage(
        tabData: tabData,
        onPersonPressed: _manager.onPersonPressed,
        onPersonFavPressed: _manager.onPersonFavPressed,
        onScrollPositionChanged: onPositionChanged,
      );
    }

    final pages = tabLabels.map(buildPage).toList();
    return TabBarView(
      controller: tabsController,
      children: pages,
    );
  }
}
