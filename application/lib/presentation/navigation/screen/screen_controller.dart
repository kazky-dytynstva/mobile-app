import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/forced_update_info/forced_update_info.dart';
import 'package:mobile_app/domain/model/menu_dynamic_item/menu_dynamic_item_data.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/domain/model/sort_and_filter/data/sort_and_filter_open_type.dart';
import 'package:mobile_app/domain/model/sort_and_filter/filter_type.dart';
import 'package:mobile_app/domain/model/sort_and_filter/sort_type.dart';
import 'package:mobile_app/domain/model/tale/tale.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_name.dart';
import 'package:mobile_app/domain/model/tale_crew/tale_crew.dart';
import 'package:mobile_app/domain/model/settings/settings_page_type.dart';

/// Responsible for the navigation between screens
/// All screens should extend from [BaseScreenWidget]
abstract class ScreenController {
  RouterDelegate<Object> get routerDelegate;

  RouteInformationParser<Object> get routerParser;

  RouteInformationProvider get routerProvider;

  //region general

  void pop();

  //endregion

  //region openScreen
  void openDebug();

  void openDynamicItem(MenuDynamicItemData data);

  void openFeatureFlags();

  void openWhatsNew();

  void openHome();

  void openSettings({
    SettingsPageType openType = SettingsPageType.general,
  });

  void openSortAndFilter({
    required SortAndFilterOpenType openType,
    required TaleSortType sortType,
    required TaleFilterType filterType,
  });

  void openForcedUpdate({
    required ForcedUpdateInfo info,
  });

  void openTale({
    required Tale tale,
    bool openAudio = false,
    TaleFilterType? filterType,
  });

  void openSearchTale();

  void openTaleCrew({
    required TaleName name,
    required TaleCrew crew,
  });

  void openPerson({
    required Person person,
  });
//endregion openScreen
}
