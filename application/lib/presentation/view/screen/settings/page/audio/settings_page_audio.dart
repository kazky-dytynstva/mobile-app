import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/settings/settings_data_audio.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/settings/page/audio/settings_section_all_audio.dart';

class SettingsPageAudio extends StatelessWidget {
  final SettingsDataAudio data;
  final VoidCallback onDeleteAllPressed;
  final VoidCallback onCacheAllPressed;
  final VoidCallback onStopCacheAllPressed;

  const SettingsPageAudio({
    required this.data,
    required this.onDeleteAllPressed,
    required this.onCacheAllPressed,
    required this.onStopCacheAllPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      _buildSectionAllAudio(),
      // we need to respect bottomBar height
      SizedBox(height: R.dimen.bottomBarWithActionsHeight),
    ];

    return SingleChildScrollView(child: Column(children: children));
  }

  Widget _buildSectionAllAudio() => SettingsSectionAllAudio(
        data: data,
        onCacheAllPressed: onCacheAllPressed,
        onDeleteAllPressed: onDeleteAllPressed,
        onStopCacheAllPressed: onStopCacheAllPressed,
      );
}
