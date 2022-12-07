import 'package:flutter/material.dart';
import 'package:mobile_app/presentation/resource/r.dart';

import 'settings_section_label.dart';

class SettingsSection extends StatelessWidget {
  final String label;
  final List<Widget> children;

  const SettingsSection({
    required this.label,
    required this.children,
    super.key,
  })  : assert(label.length > 0),
        assert(children.length > 0);

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SettingsSectionLabel(label: label),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: R.dimen.screenPaddingSide,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          )
        ],
      );
}
