// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i18;
import 'package:flutter/material.dart' as _i19;

import '../../../../domain/model/forced_update_info/forced_update_info.dart'
    as _i28;
import '../../../../domain/model/menu_dynamic_item/menu_dynamic_item_data.dart'
    as _i29;
import '../../../../domain/model/person/person.dart' as _i25;
import '../../../../domain/model/settings/settings_page_type.dart' as _i24;
import '../../../../domain/model/sort_and_filter/data/sort_and_filter_open_type.dart'
    as _i20;
import '../../../../domain/model/sort_and_filter/filter_type.dart' as _i21;
import '../../../../domain/model/sort_and_filter/sort_type.dart' as _i22;
import '../../../../domain/model/tale/tale.dart' as _i23;
import '../../../../domain/model/tale/value_object/tale_name.dart' as _i26;
import '../../../../domain/model/tale_crew/tale_crew.dart' as _i27;
import '../../../view/screen/debug/debug_screen.dart' as _i2;
import '../../../view/screen/dynamic_item/dynamic_item_screen.dart' as _i13;
import '../../../view/screen/feature_flags/feature_flags_screen.dart' as _i11;
import '../../../view/screen/forced_update/forced_update_screen.dart' as _i10;
import '../../../view/screen/home/home_screen.dart' as _i5;
import '../../../view/screen/home/page/fav/fav_page.dart' as _i15;
import '../../../view/screen/home/page/menu/menu_page.dart' as _i17;
import '../../../view/screen/home/page/people/people_page.dart' as _i16;
import '../../../view/screen/home/page/tales/tales_page.dart' as _i14;
import '../../../view/screen/person/person_screen.dart' as _i7;
import '../../../view/screen/search_tale/search_tale_screen.dart' as _i8;
import '../../../view/screen/settings/settings_screen.dart' as _i6;
import '../../../view/screen/splash/splash_screen.dart' as _i1;
import '../../../view/screen/tale/tale_screen.dart' as _i4;
import '../../../view/screen/tale_crew/tale_crew_screen.dart' as _i9;
import '../../../view/screen/tale_sort_and_filter/tale_sort_and_filter_screen.dart'
    as _i3;
import '../../../view/screen/whats_new/whats_new_screen.dart' as _i12;

class AppRouter extends _i18.RootStackRouter {
  AppRouter([_i19.GlobalKey<_i19.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i18.PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) {
      return _i18.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashScreen(),
      );
    },
    DebugScreenRoute.name: (routeData) {
      return _i18.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const _i2.DebugScreen(),
      );
    },
    TaleSortAndFilterScreenRoute.name: (routeData) {
      final args = routeData.argsAs<TaleSortAndFilterScreenRouteArgs>();
      return _i18.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: _i3.TaleSortAndFilterScreen(
          args.openType,
          args.initialFilterType,
          args.initialSortType,
          key: args.key,
        ),
      );
    },
    TaleScreenRoute.name: (routeData) {
      final args = routeData.argsAs<TaleScreenRouteArgs>();
      return _i18.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: _i4.TaleScreen(
          initialTale: args.initialTale,
          openAudio: args.openAudio,
          filterType: args.filterType,
          key: args.key,
        ),
      );
    },
    HomeScreenRoute.name: (routeData) {
      return _i18.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const _i5.HomeScreen(),
      );
    },
    SettingsScreenRoute.name: (routeData) {
      final args = routeData.argsAs<SettingsScreenRouteArgs>();
      return _i18.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: _i6.SettingsScreen(
          openType: args.openType,
          key: args.key,
        ),
      );
    },
    PersonScreenRoute.name: (routeData) {
      final args = routeData.argsAs<PersonScreenRouteArgs>();
      return _i18.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: _i7.PersonScreen(
          person: args.person,
          key: args.key,
        ),
      );
    },
    SearchTaleScreenRoute.name: (routeData) {
      return _i18.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const _i8.SearchTaleScreen(),
      );
    },
    TaleCrewScreenRoute.name: (routeData) {
      final args = routeData.argsAs<TaleCrewScreenRouteArgs>();
      return _i18.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: _i9.TaleCrewScreen(
          taleName: args.taleName,
          crew: args.crew,
          key: args.key,
        ),
      );
    },
    ForcedUpdateScreenRoute.name: (routeData) {
      final args = routeData.argsAs<ForcedUpdateScreenRouteArgs>();
      return _i18.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: _i10.ForcedUpdateScreen(
          key: args.key,
          info: args.info,
        ),
      );
    },
    FeatureFlagsScreenRoute.name: (routeData) {
      return _i18.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const _i11.FeatureFlagsScreen(),
      );
    },
    WhatsNewScreenRoute.name: (routeData) {
      return _i18.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const _i12.WhatsNewScreen(),
      );
    },
    DynamicItemScreenRoute.name: (routeData) {
      final args = routeData.argsAs<DynamicItemScreenRouteArgs>();
      return _i18.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: _i13.DynamicItemScreen(
          data: args.data,
          key: args.key,
        ),
      );
    },
    TalesPageRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i14.TalesPage(),
      );
    },
    FavPageRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i15.FavPage(),
      );
    },
    PeoplePageRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i16.PeoplePage(),
      );
    },
    MenuPageRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i17.MenuPage(),
      );
    },
  };

  @override
  List<_i18.RouteConfig> get routes => [
        _i18.RouteConfig(
          SplashScreenRoute.name,
          path: '/',
        ),
        _i18.RouteConfig(
          DebugScreenRoute.name,
          path: '/debug-screen',
        ),
        _i18.RouteConfig(
          TaleSortAndFilterScreenRoute.name,
          path: '/tale-sort-and-filter-screen',
        ),
        _i18.RouteConfig(
          TaleScreenRoute.name,
          path: '/tale-screen',
        ),
        _i18.RouteConfig(
          HomeScreenRoute.name,
          path: '/home-screen',
          children: [
            _i18.RouteConfig(
              TalesPageRoute.name,
              path: 'tales-page',
              parent: HomeScreenRoute.name,
            ),
            _i18.RouteConfig(
              FavPageRoute.name,
              path: 'fav-page',
              parent: HomeScreenRoute.name,
            ),
            _i18.RouteConfig(
              PeoplePageRoute.name,
              path: 'people-page',
              parent: HomeScreenRoute.name,
            ),
            _i18.RouteConfig(
              MenuPageRoute.name,
              path: 'menu-page',
              parent: HomeScreenRoute.name,
            ),
          ],
        ),
        _i18.RouteConfig(
          SettingsScreenRoute.name,
          path: '/settings-screen',
        ),
        _i18.RouteConfig(
          PersonScreenRoute.name,
          path: '/person-screen',
        ),
        _i18.RouteConfig(
          SearchTaleScreenRoute.name,
          path: '/search-tale-screen',
        ),
        _i18.RouteConfig(
          TaleCrewScreenRoute.name,
          path: '/tale-crew-screen',
        ),
        _i18.RouteConfig(
          ForcedUpdateScreenRoute.name,
          path: '/forced-update-screen',
        ),
        _i18.RouteConfig(
          FeatureFlagsScreenRoute.name,
          path: '/feature-flags-screen',
        ),
        _i18.RouteConfig(
          WhatsNewScreenRoute.name,
          path: '/whats-new-screen',
        ),
        _i18.RouteConfig(
          DynamicItemScreenRoute.name,
          path: '/dynamic-item-screen',
        ),
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashScreenRoute extends _i18.PageRouteInfo<void> {
  const SplashScreenRoute()
      : super(
          SplashScreenRoute.name,
          path: '/',
        );

  static const String name = 'SplashScreenRoute';
}

/// generated route for
/// [_i2.DebugScreen]
class DebugScreenRoute extends _i18.PageRouteInfo<void> {
  const DebugScreenRoute()
      : super(
          DebugScreenRoute.name,
          path: '/debug-screen',
        );

  static const String name = 'DebugScreenRoute';
}

/// generated route for
/// [_i3.TaleSortAndFilterScreen]
class TaleSortAndFilterScreenRoute
    extends _i18.PageRouteInfo<TaleSortAndFilterScreenRouteArgs> {
  TaleSortAndFilterScreenRoute({
    required _i20.SortAndFilterOpenType openType,
    required _i21.TaleFilterType initialFilterType,
    required _i22.TaleSortType initialSortType,
    _i19.Key? key,
  }) : super(
          TaleSortAndFilterScreenRoute.name,
          path: '/tale-sort-and-filter-screen',
          args: TaleSortAndFilterScreenRouteArgs(
            openType: openType,
            initialFilterType: initialFilterType,
            initialSortType: initialSortType,
            key: key,
          ),
        );

  static const String name = 'TaleSortAndFilterScreenRoute';
}

class TaleSortAndFilterScreenRouteArgs {
  const TaleSortAndFilterScreenRouteArgs({
    required this.openType,
    required this.initialFilterType,
    required this.initialSortType,
    this.key,
  });

  final _i20.SortAndFilterOpenType openType;

  final _i21.TaleFilterType initialFilterType;

  final _i22.TaleSortType initialSortType;

  final _i19.Key? key;

  @override
  String toString() {
    return 'TaleSortAndFilterScreenRouteArgs{openType: $openType, initialFilterType: $initialFilterType, initialSortType: $initialSortType, key: $key}';
  }
}

/// generated route for
/// [_i4.TaleScreen]
class TaleScreenRoute extends _i18.PageRouteInfo<TaleScreenRouteArgs> {
  TaleScreenRoute({
    required _i23.Tale initialTale,
    required bool openAudio,
    required _i21.TaleFilterType? filterType,
    _i19.Key? key,
  }) : super(
          TaleScreenRoute.name,
          path: '/tale-screen',
          args: TaleScreenRouteArgs(
            initialTale: initialTale,
            openAudio: openAudio,
            filterType: filterType,
            key: key,
          ),
        );

  static const String name = 'TaleScreenRoute';
}

class TaleScreenRouteArgs {
  const TaleScreenRouteArgs({
    required this.initialTale,
    required this.openAudio,
    required this.filterType,
    this.key,
  });

  final _i23.Tale initialTale;

  final bool openAudio;

  final _i21.TaleFilterType? filterType;

  final _i19.Key? key;

  @override
  String toString() {
    return 'TaleScreenRouteArgs{initialTale: $initialTale, openAudio: $openAudio, filterType: $filterType, key: $key}';
  }
}

/// generated route for
/// [_i5.HomeScreen]
class HomeScreenRoute extends _i18.PageRouteInfo<void> {
  const HomeScreenRoute({List<_i18.PageRouteInfo>? children})
      : super(
          HomeScreenRoute.name,
          path: '/home-screen',
          initialChildren: children,
        );

  static const String name = 'HomeScreenRoute';
}

/// generated route for
/// [_i6.SettingsScreen]
class SettingsScreenRoute extends _i18.PageRouteInfo<SettingsScreenRouteArgs> {
  SettingsScreenRoute({
    required _i24.SettingsPageType openType,
    _i19.Key? key,
  }) : super(
          SettingsScreenRoute.name,
          path: '/settings-screen',
          args: SettingsScreenRouteArgs(
            openType: openType,
            key: key,
          ),
        );

  static const String name = 'SettingsScreenRoute';
}

class SettingsScreenRouteArgs {
  const SettingsScreenRouteArgs({
    required this.openType,
    this.key,
  });

  final _i24.SettingsPageType openType;

  final _i19.Key? key;

  @override
  String toString() {
    return 'SettingsScreenRouteArgs{openType: $openType, key: $key}';
  }
}

/// generated route for
/// [_i7.PersonScreen]
class PersonScreenRoute extends _i18.PageRouteInfo<PersonScreenRouteArgs> {
  PersonScreenRoute({
    required _i25.Person person,
    _i19.Key? key,
  }) : super(
          PersonScreenRoute.name,
          path: '/person-screen',
          args: PersonScreenRouteArgs(
            person: person,
            key: key,
          ),
        );

  static const String name = 'PersonScreenRoute';
}

class PersonScreenRouteArgs {
  const PersonScreenRouteArgs({
    required this.person,
    this.key,
  });

  final _i25.Person person;

  final _i19.Key? key;

  @override
  String toString() {
    return 'PersonScreenRouteArgs{person: $person, key: $key}';
  }
}

/// generated route for
/// [_i8.SearchTaleScreen]
class SearchTaleScreenRoute extends _i18.PageRouteInfo<void> {
  const SearchTaleScreenRoute()
      : super(
          SearchTaleScreenRoute.name,
          path: '/search-tale-screen',
        );

  static const String name = 'SearchTaleScreenRoute';
}

/// generated route for
/// [_i9.TaleCrewScreen]
class TaleCrewScreenRoute extends _i18.PageRouteInfo<TaleCrewScreenRouteArgs> {
  TaleCrewScreenRoute({
    required _i26.TaleName taleName,
    required _i27.TaleCrew crew,
    _i19.Key? key,
  }) : super(
          TaleCrewScreenRoute.name,
          path: '/tale-crew-screen',
          args: TaleCrewScreenRouteArgs(
            taleName: taleName,
            crew: crew,
            key: key,
          ),
        );

  static const String name = 'TaleCrewScreenRoute';
}

class TaleCrewScreenRouteArgs {
  const TaleCrewScreenRouteArgs({
    required this.taleName,
    required this.crew,
    this.key,
  });

  final _i26.TaleName taleName;

  final _i27.TaleCrew crew;

  final _i19.Key? key;

  @override
  String toString() {
    return 'TaleCrewScreenRouteArgs{taleName: $taleName, crew: $crew, key: $key}';
  }
}

/// generated route for
/// [_i10.ForcedUpdateScreen]
class ForcedUpdateScreenRoute
    extends _i18.PageRouteInfo<ForcedUpdateScreenRouteArgs> {
  ForcedUpdateScreenRoute({
    _i19.Key? key,
    required _i28.ForcedUpdateInfo info,
  }) : super(
          ForcedUpdateScreenRoute.name,
          path: '/forced-update-screen',
          args: ForcedUpdateScreenRouteArgs(
            key: key,
            info: info,
          ),
        );

  static const String name = 'ForcedUpdateScreenRoute';
}

class ForcedUpdateScreenRouteArgs {
  const ForcedUpdateScreenRouteArgs({
    this.key,
    required this.info,
  });

  final _i19.Key? key;

  final _i28.ForcedUpdateInfo info;

  @override
  String toString() {
    return 'ForcedUpdateScreenRouteArgs{key: $key, info: $info}';
  }
}

/// generated route for
/// [_i11.FeatureFlagsScreen]
class FeatureFlagsScreenRoute extends _i18.PageRouteInfo<void> {
  const FeatureFlagsScreenRoute()
      : super(
          FeatureFlagsScreenRoute.name,
          path: '/feature-flags-screen',
        );

  static const String name = 'FeatureFlagsScreenRoute';
}

/// generated route for
/// [_i12.WhatsNewScreen]
class WhatsNewScreenRoute extends _i18.PageRouteInfo<void> {
  const WhatsNewScreenRoute()
      : super(
          WhatsNewScreenRoute.name,
          path: '/whats-new-screen',
        );

  static const String name = 'WhatsNewScreenRoute';
}

/// generated route for
/// [_i13.DynamicItemScreen]
class DynamicItemScreenRoute
    extends _i18.PageRouteInfo<DynamicItemScreenRouteArgs> {
  DynamicItemScreenRoute({
    required _i29.MenuDynamicItemData data,
    _i19.Key? key,
  }) : super(
          DynamicItemScreenRoute.name,
          path: '/dynamic-item-screen',
          args: DynamicItemScreenRouteArgs(
            data: data,
            key: key,
          ),
        );

  static const String name = 'DynamicItemScreenRoute';
}

class DynamicItemScreenRouteArgs {
  const DynamicItemScreenRouteArgs({
    required this.data,
    this.key,
  });

  final _i29.MenuDynamicItemData data;

  final _i19.Key? key;

  @override
  String toString() {
    return 'DynamicItemScreenRouteArgs{data: $data, key: $key}';
  }
}

/// generated route for
/// [_i14.TalesPage]
class TalesPageRoute extends _i18.PageRouteInfo<void> {
  const TalesPageRoute()
      : super(
          TalesPageRoute.name,
          path: 'tales-page',
        );

  static const String name = 'TalesPageRoute';
}

/// generated route for
/// [_i15.FavPage]
class FavPageRoute extends _i18.PageRouteInfo<void> {
  const FavPageRoute()
      : super(
          FavPageRoute.name,
          path: 'fav-page',
        );

  static const String name = 'FavPageRoute';
}

/// generated route for
/// [_i16.PeoplePage]
class PeoplePageRoute extends _i18.PageRouteInfo<void> {
  const PeoplePageRoute()
      : super(
          PeoplePageRoute.name,
          path: 'people-page',
        );

  static const String name = 'PeoplePageRoute';
}

/// generated route for
/// [_i17.MenuPage]
class MenuPageRoute extends _i18.PageRouteInfo<void> {
  const MenuPageRoute()
      : super(
          MenuPageRoute.name,
          path: 'menu-page',
        );

  static const String name = 'MenuPageRoute';
}
