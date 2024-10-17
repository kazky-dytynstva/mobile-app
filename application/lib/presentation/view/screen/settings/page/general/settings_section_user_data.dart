import 'package:flutter/material.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/app_check_box.dart';
import 'package:mobile_app/presentation/widget/labeled_child.dart';
import 'package:mobile_app/presentation/widget/list_item.dart';
import 'package:mobile_app/presentation/widget/svg_widget.dart';

class SettingsSectionUserData extends StatelessWidget {
  final bool isTrackingEnabled;
  final bool isCrashLoggingEnabled;
  final ValueChanged<bool> onTrackingEnabledPressed;
  final ValueChanged<bool> onCrashLoggingEnabledPressed;
  final VoidCallback onDeleteUserDataPressed;
  final VoidCallback onPrivacyPolityPressed;
  final VoidCallback onTermsAndConditionsPressed;

  const SettingsSectionUserData({
    required this.isTrackingEnabled,
    required this.isCrashLoggingEnabled,
    required this.onTrackingEnabledPressed,
    required this.onCrashLoggingEnabledPressed,
    required this.onDeleteUserDataPressed,
    required this.onTermsAndConditionsPressed,
    required this.onPrivacyPolityPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) => LabeledChildren(
        label: R.strings.settings.sectionLabelUserData,
        children: [
          _buildPrivacyPolicy(),
          _buildTermsAndConditions(),
          R.spaces.verticalUnit,
          _buildInfo(),
          R.spaces.verticalUnit4,
          _buildCrashLogging(),
          _buildTracking(),
          _buildDeleteUserData(),
        ],
      );

  Widget _buildInfo() => Padding(
        padding: EdgeInsets.symmetric(horizontal: R.dimen.screenPaddingSide),
        child: Text(
          R.strings.settings.userDataInfo,
          style: R.styles.textBodySecondary,
        ),
      );

  Widget _buildPrivacyPolicy() => ListItem(
        title: R.strings.settings.privacyPolicyTitle,
        onPressed: onPrivacyPolityPressed,
      );

  Widget _buildTermsAndConditions() => ListItem(
        title: R.strings.settings.termsAndConditionsTitle,
        onPressed: onTermsAndConditionsPressed,
      );

  Widget _buildTracking() => ListItem(
        title: R.strings.settings.trackingEnabledTitle,
        subTitle: R.strings.settings.trackingEnabledSubTitle,
        trailingChild: _buildCheckBox(
          isTrackingEnabled,
          onTrackingEnabledPressed,
        ),
        onPressed: () => onTrackingEnabledPressed(!isTrackingEnabled),
      );

  Widget _buildCrashLogging() => ListItem(
        title: R.strings.settings.crashLoggingEnabledTitle,
        subTitle: R.strings.settings.crashLoggingEnabledSubTitle,
        trailingChild: _buildCheckBox(
          isCrashLoggingEnabled,
          onCrashLoggingEnabledPressed,
        ),
        onPressed: () => onCrashLoggingEnabledPressed(!isCrashLoggingEnabled),
      );

  //ignore: unused_element
  Widget _buildDeleteUserData() => ListItem(
        title: R.strings.settings.deleteUserDataTitle,
        subTitle: R.strings.settings.deleteUserDataSubTitle,
        trailingChild: Padding(
          padding: EdgeInsets.only(right: R.dimen.unit1_5),
          child: SvgWidget.icon(
            R.assets.icons.trash,
            color: R.palette.accent,
          ),
        ),
        onPressed: onDeleteUserDataPressed,
      );

  AppCheckBox _buildCheckBox(
    bool isChecked,
    ValueChanged<bool> onChanged,
  ) =>
      AppCheckBox(
        value: isChecked,
        onChanged: onChanged,
      );
}
