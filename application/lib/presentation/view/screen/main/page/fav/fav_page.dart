import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/domain/model/app_tab/app_tab_data.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/data/di/dependency_injection.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/main/page/fav/manager/fav_page_manager.dart';
import 'package:mobile_app/presentation/widget/list_of_people.dart';
import 'package:mobile_app/presentation/widget/tabs/app_tab_bar.dart';
import 'package:mobile_app/presentation/view/screen/manager_view_mixin.dart';
import 'package:mobile_app/presentation/widget/custom_theme.dart';
import 'package:mobile_app/presentation/widget/fade_animated_switcher.dart';
import 'package:mobile_app/presentation/widget/list_of_tales.dart';

@RoutePage()
class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage>
    with
        AutomaticKeepAliveClientMixin,
        ManagerViewMixin,
        CustomThemeStatefulMixin,
        SingleTickerProviderStateMixin {
  late final FavPageManager _manager = getIt();

  late final tabController = TabController(
    length: 2,
    vsync: this,
  );

  Duration get showBackTimeOut => R.durations.showHiddenScrolledWidget;

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Widget stateBuilder(BuildContext context, FavPageState state) {
      final widget = state.map(
        initial: buildInitialState,
        ready: _buildStateReady,
      );
      return FadeAnimatedSwitcher.screen(child: widget);
    }

    return BlocBuilder(bloc: _manager, builder: stateBuilder);
  }

  Widget _buildStateReady(FavPageStateReady state) => Scaffold(
        appBar: AppBar(title: _buildTabs(state)),
        body: _buildViewPager(state),
      );

  Widget _buildViewPager(FavPageStateReady state) {
    final pages = [
      _buildTalesPage(state.tales),
      _buildPeoplePage(state.people),
    ];
    return TabBarView(
      controller: tabController,
      children: pages,
    );
  }

  AppTabBar _buildTabs(FavPageStateReady state) {
    final talesLabel = state.tales.isEmpty
        ? R.strings.main.pageNameTalesList
        : '${R.strings.main.pageNameTalesList} (${state.tales.length})';
    final peopleLabel = state.people.isEmpty
        ? R.strings.main.pageNameCrewList
        : '${R.strings.main.pageNameCrewList} (${state.people.length})';
    final items = <AppTabData>[
      AppTabData(
        label: StringSingleLine(talesLabel),
        icon: R.assets.icons.talesList,
      ),
      AppTabData(
        label: StringSingleLine(peopleLabel),
        icon: R.assets.icons.talesCrew,
      )
    ];

    return AppTabBar(
      controller: tabController,
      tabDataList: items,
      // respectTopPadding: true,
    );
  }

  Widget _buildTalesPage(List<TalesPageItemData> tales) => ListOfTales(
        tales: tales,
        onTalePressed: _manager.onTalePressed,
        onTaleFavPressed: _manager.onTaleFavPressed,
        onRatingPressed: _manager.onRatingPressed,
        isFavList: true,
      );

  Widget _buildPeoplePage(List<Person> people) => PeopleList(
        peopleList: people,
        onPersonPressed: _manager.onPersonPressed,
        onPersonFavPressed: _manager.onPersonFavPressed,
      );
}
