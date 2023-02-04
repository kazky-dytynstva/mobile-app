import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/forced_update_info/forced_update_info.dart';
import 'package:mobile_app/domain/model/menu_dynamic_item/menu_dynamic_item_data.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/domain/model/sort_and_filter/data/sort_and_filter_open_type.dart';
import 'package:mobile_app/domain/model/sort_and_filter/filter_type.dart';
import 'package:mobile_app/domain/model/sort_and_filter/sort_type.dart';
import 'package:mobile_app/domain/model/tale/tale.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_name.dart';
import 'package:mobile_app/domain/model/tale_crew/tale_crew.dart';
import 'package:mobile_app/infrastructure/env_config/env_config.dart';
import 'package:mobile_app/infrastructure/helper/tracking/tracker_group.dart';
import 'package:mobile_app/presentation/navigation/screen/active_screen_notifier/active_screen_notifier.dart';
import 'package:mobile_app/presentation/navigation/screen/router/router.gr.dart';
import 'package:mobile_app/presentation/navigation/screen/screen_controller.dart';
import 'package:mobile_app/domain/model/settings/settings_page_type.dart';

@LazySingleton(as: ScreenController)
class ScreenControllerImpl implements ScreenController {
  final Tracker _tracker;
  final RootStackRouter _appRouter;
  final NavigatorObserver _navigatorObserver;
  final ActiveScreenNotifier _activeScreenNotifier;

  ScreenControllerImpl(
    this._tracker,
    this._appRouter,
    this._navigatorObserver,
    this._activeScreenNotifier,
  );

  @override
  RouterDelegate<Object> get routerDelegate => _appRouter.delegate(
      navigatorObservers: () => [
            _navigatorObserver,
            _activeScreenNotifier.screenObserver,
          ]);

  @override
  RouteInformationParser<Object> get routerParser =>
      _appRouter.defaultRouteParser();

  @override
  RouteInformationProvider get routerProvider => _appRouter.routeInfoProvider();

  @override
  void pop() => _appRouter.pop();

  //region openScreen
  @override
  void openMain() {
    _tracker.view(TrackingViews.screenMain);
    _appRouter.replace(const MainScreenRoute());
  }

  @override
  void openDynamicItem(MenuDynamicItemData data) {
    _tracker.view(TrackingViews.screenDynamicItem);
    _appRouter.push(DynamicItemScreenRoute(data: data));
  }

  @override
  void openWhatsNew() {
    _tracker.view(TrackingViews.screenWhatsNew);
    _appRouter.push(const WhatsNewScreenRoute());
  }

  @override
  void openDebug() {
    if (EnvConfig.isProd) return;
    _appRouter.push(const DebugScreenRoute());
  }

  @override
  void openFeatureFlags() {
    if (EnvConfig.isProd) return;
    _appRouter.push(const FeatureFlagsScreenRoute());
  }

  @override
  void openSettings({
    SettingsPageType openType = SettingsPageType.general,
  }) {
    _tracker.view(TrackingViews.screenSettings);
    _appRouter.push(SettingsScreenRoute(openType: openType));
  }

  @override
  void openForcedUpdate({
    required ForcedUpdateInfo info,
  }) {
    _tracker.view(TrackingViews.screenForcedUpdate);
    _appRouter.replace(ForcedUpdateScreenRoute(info: info));
  }

  @override
  void openTaleCrew({
    required TaleName name,
    required TaleCrew crew,
  }) {
    _tracker.view(TrackingViews.screenTaleCrew);
    final route = TaleCrewScreenRoute(taleName: name, crew: crew);
    _closeSimilar(route);
    _appRouter.push(route);
  }

  @override
  void openSortAndFilter({
    required SortAndFilterOpenType openType,
    required TaleSortType sortType,
    required TaleFilterType filterType,
  }) {
    _tracker.view(TrackingViews.screenTaleSortAndFilter);

    final route = TaleSortAndFilterScreenRoute(
      openType: openType,
      initialFilterType: filterType,
      initialSortType: sortType,
    );
    _appRouter.push(route);
  }

  @override
  void openTale({
    required Tale tale,
    bool openAudio = false,
    TaleFilterType? filterType,
  }) {
    _tracker.view(TrackingViews.screenTale);
    final taleRoute = TaleScreenRoute(
      initialTale: tale,
      openAudio: openAudio,
      filterType: filterType,
    );
    _closeSimilar(taleRoute);
    _appRouter.push(taleRoute);
  }

  @override
  void openPerson({
    required Person person,
  }) {
    _tracker.view(TrackingViews.screenPerson);
    final route = PersonScreenRoute(person: person);
    _closeSimilar(route);
    _appRouter.push(route);
  }

  @override
  void openSearchTale() {
    _tracker.view(TrackingViews.screenSearchTale);
    const route = SearchTaleScreenRoute();
    _appRouter.push(route);
  }

//endregion openScreen

  /// this prevents showing 2 similar screen
  void _closeSimilar(PageRouteInfo screenRoute) =>
      _appRouter.removeWhere((route) => route.path == screenRoute.path);
}
