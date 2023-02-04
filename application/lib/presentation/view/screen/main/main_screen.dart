import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_icon.dart';
import 'package:mobile_app/presentation/navigation/screen/router/router.gr.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/main/manager/main_screen_manager.dart';
import 'package:mobile_app/presentation/view/screen/main/model/main_screen_page.dart';
import 'package:mobile_app/presentation/view/screen/main/widget/current_playing_audio.dart';
import 'package:mobile_app/presentation/view/screen/manager_view_mixin.dart';
import 'package:mobile_app/presentation/view/screen/screen_mixin.dart';
import 'package:mobile_app/presentation/widget/blinking_dot.dart';
import 'package:mobile_app/presentation/widget/fade_animated_switcher.dart';
import 'package:mobile_app/presentation/widget/svg_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ScreenWidgetState<MainScreen, MainScreenManager>
    with ManagerViewMixin {
  @override
  Widget build(BuildContext context) {
    Widget stateBuilder(BuildContext context, MainScreenState state) {
      final widget = state.map(
        initial: buildInitialState,
        ready: _buildStateReady,
      );
      return FadeAnimatedSwitcher.screen(child: widget);
    }

    final bloc = BlocBuilder(bloc: manager, builder: stateBuilder);
    return Scaffold(body: bloc);
  }

  Widget _buildStateReady(MainScreenStateReady state) {
    final routes = state.pages.map(_getPageRoute).toList();
    return AutoTabsScaffold(
      routes: routes,
      bottomNavigationBuilder: (_, TabsRouter router) {
        manager.setChangePageAction(router.setActiveIndex);
        return _buildBottomBar(
          state.pages,
          state.currentPage,
          state.activeAudioTaleOption,
          state.showMenuDot,
        );
      },
    );
  }

  Widget _buildBottomBar(
    List<MainScreenPage> pages,
    MainScreenPage currentPage,
    Option<TalesPageItemData> activeAudioTaleOption,
    bool showMenuDot,
  ) {
    final currentPlaying = CurrentPlayingAudio(
      playingTaleOption: activeAudioTaleOption,
      onStopPressed: manager.onStopPlayingPressed,
      onTalePressed: manager.onTalePressed,
    );

    final items = pages
        .map(
          (e) => _buildBottomBarItem(
            e,
            isSelected: e == currentPage,
            hasBlinkingDot: e.isMenu && showMenuDot,
          ),
        )
        .toList();

    final textStyle = R.styles.textBody;
    final bar = BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      currentIndex: pages.indexOf(currentPage),
      showUnselectedLabels: true,
      showSelectedLabels: true,
      unselectedLabelStyle: textStyle,
      selectedLabelStyle: textStyle,
      elevation: R.dimen.toolbarElevation,
      selectedItemColor: R.palette.accent,
      unselectedItemColor: R.palette.iconColor,
      items: items,
      onTap: (int index) => manager.onPagePressed(pages[index]),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [currentPlaying, bar],
    );
  }

  BottomNavigationBarItem _buildBottomBarItem(
    MainScreenPage type, {
    required bool isSelected,
    required bool hasBlinkingDot,
  }) {
    final icon = Padding(
      padding: EdgeInsets.all(R.dimen.unit0_5),
      child: SvgWidget.icon(
        _getPageIcon(type, isSelected),
        color: isSelected ? R.palette.accent : R.palette.iconColor,
      ),
    );
    final label = _getPageLabel(type);

    final itemBgColor = R.palette.cardBackground;

    final child = !hasBlinkingDot
        ? icon
        : Stack(
            children: [
              icon,
              Positioned(
                top: 0,
                right: 0,
                child: BlinkingDot(borderColor: itemBgColor),
              ),
            ],
          );
    return BottomNavigationBarItem(
      icon: child,
      label: label,
      tooltip: label,
      backgroundColor: itemBgColor,
    );
  }

  PageRouteInfo _getPageRoute(MainScreenPage type) => type.map(
        tales: () => const TalesPageRoute(),
        fav: () => const FavPageRoute(),
        people: () => const PeoplePageRoute(),
        menu: () => const MenuPageRoute(),
      );

  String _getPageLabel(MainScreenPage type) => type.map(
        tales: () => R.strings.main.pageNameTalesList,
        fav: () => R.strings.taleFilterType.favorite,
        people: () => R.strings.main.pageNameCrewList,
        menu: () => R.strings.main.pageNameMenu,
      );

  SvgAssetIcon _getPageIcon(
    MainScreenPage type,
    bool isSelected,
  ) =>
      type.map(
        tales: () => isSelected
            ? R.assets.icons.talesListSolid
            : R.assets.icons.talesList,
        fav: () =>
            isSelected ? R.assets.icons.heartSolid : R.assets.icons.heart,
        people: () => isSelected
            ? R.assets.icons.talesCrewSolid
            : R.assets.icons.talesCrew,
        menu: () => isSelected ? R.assets.icons.menuSolid : R.assets.icons.menu,
      );
}
