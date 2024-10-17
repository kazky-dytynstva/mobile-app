import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/app_tab/app_tab_data.dart';
import 'package:mobile_app/domain/model/app_theme/app_theme.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/data/di/dependency_injection.dart';
import 'package:mobile_app/data/env_config/env_config.dart';
import 'package:mobile_app/presentation/navigation/screen/screen_controller.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/debug/page/debug_page_app_rich_text.dart';
import 'package:mobile_app/presentation/view/screen/debug/page/debug_page_assets.dart';
import 'package:mobile_app/presentation/view/screen/debug/page/base_debug_page.dart';
import 'package:mobile_app/presentation/view/screen/debug/page/debug_page_buttons.dart';
import 'package:mobile_app/presentation/view/screen/debug/page/debug_page_checkbox.dart';
import 'package:mobile_app/presentation/view/screen/debug/page/debug_page_flip_down_timer.dart';
import 'package:mobile_app/presentation/view/screen/debug/page/debug_page_progress.dart';
import 'package:mobile_app/presentation/view/screen/debug/page/debug_page_rating.dart';
import 'package:mobile_app/presentation/view/screen/debug/page/debug_page_snackbar.dart';
import 'package:mobile_app/presentation/view/screen/debug/page/debug_page_text_styles.dart';
import 'package:mobile_app/presentation/view/screen/debug/page/debug_page_url_preview.dart';
import 'package:mobile_app/presentation/widget/button/button_icon.dart';
import 'package:mobile_app/presentation/widget/custom_theme.dart';
import 'package:mobile_app/presentation/widget/tabs/app_tab_bar.dart';

@RoutePage()
class DebugScreen extends StatefulWidget {
  const DebugScreen({Key? key}) : super(key: key);

  @override
  State<DebugScreen> createState() => _DebugScreenState();
}

class _DebugScreenState extends State<DebugScreen>
    with CustomThemeStatefulMixin, SingleTickerProviderStateMixin {
  late final _pages = <StringSingleLine, BaseDebugPage>{
    StringSingleLine('Assets'): const DebugPageAssets(),
    StringSingleLine('AppRichText'): const DebugPageAppRichText(),
    StringSingleLine('Rating'): const DebugPageRating(),
    StringSingleLine('FlipDownTimer'): const DebugPageFlipDownTimer(),
    StringSingleLine('Checkbox'): const DebugPageCheckbox(),
    StringSingleLine('Snackbar'): const DebugPageSnackbar(),
    StringSingleLine('UrlPreview'): const DebugPageUrlPreview(),
    StringSingleLine('Text styles'): const DebugPageTextStyles(),
    StringSingleLine('Buttons'): const DebugPageButtons(),
    StringSingleLine('ProgressBar'): const DebugPageProgress(),
  };

  late final tabsController = TabController(
    length: _pages.length,
    vsync: this,
  );

  @override
  void dispose() {
    tabsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(!EnvConfig.isProd);
    return Scaffold(
      appBar: _buildTabBar(_pages.keys.toSet()),
      body: TabBarView(
        controller: tabsController,
        children: _pages.values.toList(),
      ),
    );
  }

  AppBar _buildTabBar(Set<StringSingleLine> pages) {
    final items = pages
        .map((e) => AppTabData(
              label: e,
              icon: e.get() == 'Assets' ? R.assets.icons.palette : null,
            ))
        .toList();

    final changeThemeBtn = ButtonIcon(
      R.assets.icons.palette,
      onPressed: _onChangeThemePressed,
    );
    final featureFlagsBtn = ButtonIcon(
      R.assets.icons.flag,
      onPressed: _onFeatureFlagsPressed,
    );
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text('Debug Screen', style: R.styles.textSubTitle),
      actions: [
        featureFlagsBtn,
        changeThemeBtn,
      ],
      bottom: AppTabBar(
        tabDataList: items,
        controller: tabsController,
        isScrollable: true,
        respectTopPadding: false,
      ),
    );
  }

  void _onChangeThemePressed() async {
    final setThemeUseCase = getIt<UseCase<AppTheme, Dry>>();
    final theme = R.theme.isDark ? AppTheme.light : AppTheme.dark;
    setThemeUseCase.call(theme);
  }

  void _onFeatureFlagsPressed() => getIt<ScreenController>().openFeatureFlags();
}
