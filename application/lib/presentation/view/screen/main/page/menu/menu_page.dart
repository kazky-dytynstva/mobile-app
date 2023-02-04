import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/domain/extensions/string.dart';
import 'package:mobile_app/domain/feature_flag/feature.dart';
import 'package:mobile_app/domain/feature_flag/feature_flag_provider.dart';
import 'package:mobile_app/domain/model/app_version/app_version.dart';
import 'package:mobile_app/domain/model/menu_dynamic_item/menu_dynamic_item_data.dart';
import 'package:mobile_app/infrastructure/di/dependency_injection.dart';
import 'package:mobile_app/infrastructure/env_config/env_config.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/main/page/menu/manager/menu_page_manager.dart';
import 'package:mobile_app/presentation/view/screen/main/page/menu/model/menu_page_item_type.dart';
import 'package:mobile_app/presentation/view/screen/main/page/menu/widget/menu_page_item.dart';
import 'package:mobile_app/presentation/view/screen/manager_view_mixin.dart';
import 'package:mobile_app/presentation/widget/custom_theme.dart';
import 'package:mobile_app/presentation/widget/divider.dart';
import 'package:mobile_app/presentation/widget/fade_animated_switcher.dart';
import 'package:mobile_app/presentation/widget/made_with_love.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage>
    with
        AutomaticKeepAliveClientMixin,
        ManagerViewMixin,
        CustomThemeStatefulMixin {
  late final MenuPageManager _manager = getIt();
  late final FeatureFlagProvider _flagProvider = getIt();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Widget stateBuilder(BuildContext context, MenuPageState state) {
      final widget = state.map(
        initial: buildInitialState,
        ready: _buildStateReady,
      );
      return FadeAnimatedSwitcher.screen(child: widget);
    }

    return BlocBuilder(bloc: _manager, builder: stateBuilder);
  }

  Widget _buildStateReady(MenuPageStateReady state) {
    final children = [
      R.spaces.verticalUnit2,
      _buildWithLove(),
      _divider(),
      _buildMenuItemAddTale(),
      _buildMenuItemWriteDevelopers(),
      _buildMenuDynamicItem(state.dynamicItemDataOption),
      _divider(),
      _buildMenuItemShareApp(),
      _buildMenuItemDonate(state.showDotDonation),
      _buildMenuItemSettings(),
      _divider(),
      _buildMenuItemWhatsNew(state.appVersion, state.showDotWhatsNew),
      _buildMenuItemDebug(),
      _divider(),
    ];
    return ListView(children: children);
  }

  Widget _divider() => AppDivider(
        padding: EdgeInsets.symmetric(vertical: R.dimen.unit2),
      );

  Widget _buildMenuItemDonate(bool showDotDonation) =>
      !_flagProvider.isEnabled(Feature.donation)
          ? R.spaces.empty
          : MenuPageItem(
              title: R.strings.menuItem.donate,
              icon: R.assets.icons.support,
              onPressed: () => _manager.onItemPressed(MenuPageItemType.donate),
              showBlinkingDot: showDotDonation,
            );

  Widget _buildWithLove() {
    final withPadding = Padding(
      padding: EdgeInsets.symmetric(vertical: R.dimen.unit),
      child: const MadeWithLove(),
    );
    return SafeArea(child: withPadding);
  }

  Widget _buildMenuItemAddTale() => MenuPageItem(
        title: R.strings.menuItem.addTale,
        icon: R.assets.icons.addTale,
        onPressed: () => _manager.onItemPressed(MenuPageItemType.addTale),
      );

  Widget _buildMenuItemWriteDevelopers() => MenuPageItem(
        title: R.strings.menuItem.writeDevelopers,
        icon: R.assets.icons.writeDev,
        onPressed: () => _manager.onItemPressed(MenuPageItemType.writeDev),
      );

  Widget _buildMenuDynamicItem(Option<MenuDynamicItemData> dynamicItemOption) =>
      dynamicItemOption.fold(
        () => R.spaces.empty,
        (data) => MenuPageItem(
          title: data.title.get(),
          subTitle: data.subTitleOption.fold(() => null, (a) => a.get()),
          icon: R.assets.icons.report,
          accentIcon: true,
          onPressed: () => _manager.onItemPressed(MenuPageItemType.dynamic),
        ),
      );

  Widget _buildMenuItemShareApp() => MenuPageItem(
        title: R.strings.menuItem.shareApp,
        icon: R.assets.icons.share,
        onPressed: () => _manager.onItemPressed(MenuPageItemType.shareApp),
      );

  Widget _buildMenuItemSettings() => MenuPageItem(
        title: R.strings.menuItem.itemSettings,
        icon: R.assets.icons.settings,
        onPressed: () => _manager.onItemPressed(MenuPageItemType.settings),
      );

  Widget _buildMenuItemDebug() => EnvConfig.isProd
      ? R.spaces.empty
      : MenuPageItem(
          title: 'Debug screen',
          icon: R.assets.icons.devMode,
          onPressed: () => _manager.onItemPressed(MenuPageItemType.debug),
        );

  Widget _buildMenuItemWhatsNew(
    AppVersion appVersion,
    bool showWhatsNewDot,
  ) =>
      MenuPageItem(
        title: R.strings.menuItem.whatsNew,
        subTitle: R.strings.menuItem.itemAppVersion.format(appVersion.pretty),
        icon: R.assets.icons.info,
        onPressed: () => _manager.onItemPressed(MenuPageItemType.whatsNew),
        showBlinkingDot: showWhatsNewDot,
      );
}
