import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/domain/model/app_tab/app_tab_data.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/manager_view_mixin.dart';
import 'package:mobile_app/presentation/view/screen/screen_mixin.dart';
import 'package:mobile_app/presentation/view/screen/settings/manager/settings_screen_manager.dart';
import 'package:mobile_app/domain/model/settings/settings_page_type.dart';
import 'package:mobile_app/presentation/view/screen/settings/page/audio/settings_page_audio.dart';
import 'package:mobile_app/presentation/view/screen/settings/page/general/settings_page_general.dart';
import 'package:mobile_app/presentation/view/screen/settings/page/text/settings_page_text.dart';
import 'package:mobile_app/presentation/widget/bottom_bar_with_actions.dart';
import 'package:mobile_app/presentation/widget/fade_animated_switcher.dart';
import 'package:mobile_app/presentation/widget/tabs/app_tab_bar.dart';

class SettingsScreen extends StatefulWidget {
  final SettingsPageType openType;

  const SettingsScreen({
    required this.openType,
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState
    extends ScreenWidgetState<SettingsScreen, SettingsScreenManager>
    with ManagerViewMixin, SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    manager.init(widget.openType);
    super.initState();
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget stateBuilder(BuildContext context, SettingsScreenState state) {
      final widget = state.map(
        initial: buildInitialState,
        ready: _buildReadyState,
      );
      return FadeAnimatedSwitcher.screen(child: widget);
    }

    return BlocBuilder<SettingsScreenManager, SettingsScreenState>(
      bloc: manager,
      builder: stateBuilder,
    );
  }

  Widget _buildReadyState(SettingsScreenStateReady state) {
    tabController ??= TabController(
      length: state.pages.length,
      vsync: this,
      initialIndex: state.initialPageIndex,
    );
    return Scaffold(
      appBar: _buildTabBar(state.pages),
      body: _buildBody(state),
    );
  }

  AppTabBar _buildTabBar(List<SettingsPageType> pages) {
    final items = pages.map(_buildTab).toList();

    return AppTabBar(
      controller: tabController!,
      tabDataList: items,
      respectTopPadding: true,
    );
  }

  AppTabData _buildTab(
    SettingsPageType type,
  ) {
    final label = _getPageLabel(type);
    return AppTabData(label: StringSingleLine(label));
  }

  Widget _buildBody(SettingsScreenStateReady state) {
    final items = state.pages.map((e) => _buildTabPage(e, state)).toList();

    return Stack(
      children: [
        Positioned.fill(
            child: TabBarView(
          controller: tabController,
          children: items,
        )),
        Positioned.fill(top: null, child: _buildBottomBar()),
      ],
    );
  }

  Widget _buildTabPage(
    SettingsPageType type,
    SettingsScreenStateReady stateReady,
  ) {
    SettingsPageGeneral buildGeneral() => SettingsPageGeneral(
          data: stateReady.dataGeneral,
          onThemeChanged: manager.onThemeChanged,
          onTrackingEnabledPressed: manager.setTrackingEnabled,
          onCrashLoggingEnabledPressed: manager.setCrashLoggingEnabled,
          onDeleteUserDataPressed: manager.onDeleteUserDataPressed,
          onPrivacyPolityPressed: manager.onPrivacyPolityPressed,
          onTermsAndConditionsPressed: manager.onTermsAndConditionsPressed,
        );

    SettingsPageAudio buildAudio() => SettingsPageAudio(
          data: stateReady.dataAudio,
          onDeleteAllPressed: manager.onDeleteAllAudioPressed,
          onCacheAllPressed: manager.onCacheAllAudioPressed,
          onStopCacheAllPressed: manager.onStopCacheAllAudioPressed,
        );

    SettingsPageText buildText() => SettingsPageText(
          data: stateReady.dataText,
          onTextScaleFactorPressed: manager.onTextScaleFactorChanged,
        );
    return type.map(
      general: buildGeneral,
      text: buildText,
      audio: buildAudio,
    );
  }

  String _getPageLabel(SettingsPageType type) => type.map(
        general: () => R.strings.settings.pageNameGeneral,
        text: () => R.strings.settings.pageNameText,
        audio: () => R.strings.settings.pageNameAudio,
      );

  Widget _buildBottomBar() => BottomBarWithActions(
        onBackPressed: manager.onBackPressed,
      );
}
