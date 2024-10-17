import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/settings/settings_data_general.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/settings/page/general/settings_section_app_theme.dart';
import 'package:mobile_app/presentation/view/screen/settings/page/general/settings_section_user_data.dart';

class SettingsPageGeneral extends StatelessWidget {
  final SettingsDataGeneral data;
  final OnThemeChanged onThemeChanged;
  final ValueChanged<bool> onTrackingEnabledPressed;
  final ValueChanged<bool> onCrashLoggingEnabledPressed;
  final VoidCallback onDeleteUserDataPressed;
  final VoidCallback onPrivacyPolityPressed;
  final VoidCallback onTermsAndConditionsPressed;

  const SettingsPageGeneral({
    super.key,
    required this.data,
    required this.onThemeChanged,
    required this.onTrackingEnabledPressed,
    required this.onCrashLoggingEnabledPressed,
    required this.onDeleteUserDataPressed,
    required this.onPrivacyPolityPressed,
    required this.onTermsAndConditionsPressed,
  });

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      _buildSectionAppTheme(),
      _buildSectionUserData(),

      // we need to respect bottomBar height
      SizedBox(height: R.dimen.bottomBarWithActionsHeight),
    ];
    return SingleChildScrollView(
      child: Column(children: children),
    );
  }

  Widget _buildSectionAppTheme() => SettingsSectionAppTheme(
        currentTheme: data.appTheme,
        onThemeChanged: onThemeChanged,
      );

  Widget _buildSectionUserData() => SettingsSectionUserData(
        isTrackingEnabled: data.isTrackingEnabled,
        isCrashLoggingEnabled: data.isCrashLoggingEnabled,
        onCrashLoggingEnabledPressed: onCrashLoggingEnabledPressed,
        onTrackingEnabledPressed: onTrackingEnabledPressed,
        onDeleteUserDataPressed: onDeleteUserDataPressed,
        onPrivacyPolityPressed: onPrivacyPolityPressed,
        onTermsAndConditionsPressed: onTermsAndConditionsPressed,
      );
}
