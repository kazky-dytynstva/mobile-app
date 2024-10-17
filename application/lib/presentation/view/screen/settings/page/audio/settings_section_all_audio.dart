import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/settings/settings_data_audio.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/button/button_icon.dart';
import 'package:mobile_app/presentation/widget/fade_animated_switcher.dart';
import 'package:mobile_app/presentation/widget/labeled_child.dart';
import 'package:mobile_app/presentation/widget/list_item.dart';
import 'package:mobile_app/presentation/widget/loading_bar.dart';

class SettingsSectionAllAudio extends StatelessWidget {
  final SettingsDataAudio data;
  final VoidCallback onDeleteAllPressed;
  final VoidCallback onCacheAllPressed;
  final VoidCallback onStopCacheAllPressed;

  const SettingsSectionAllAudio({
    required this.data,
    required this.onDeleteAllPressed,
    required this.onCacheAllPressed,
    required this.onStopCacheAllPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) => LabeledChildren(
        label: R.strings.settings.sectionLabelAllAudio,
        children: [
          _buildCacheAllAudio(),
          _buildCachedAudio(),
        ],
      );

  Widget _buildCacheAllAudio() {
    final stopCaching = !data.isCachingNow
        ? null
        : Stack(
            alignment: AlignmentDirectional.center,
            children: [
              LoadingBar(size: R.dimen.iconSize + R.dimen.unit2),
              ButtonIcon(
                R.assets.icons.circleCross,
                onPressed: onStopCacheAllPressed,
              )
            ],
          );
    final tile = ListItem(
      withScreenSidePadding: true,
      title: data.isCachingNow
          ? R.strings.settings.cachingAllAudioTales
          : R.strings.settings.cacheAllAudioTales,
      subTitle: data.hasMoreAudioToCache ? data.needToCacheAudioInfo.get() : '',
      trailingChild: stopCaching,
      leadingIcon: R.assets.icons.download,
      onPressed: data.isCachingNow || !data.hasMoreAudioToCache
          ? null
          : onCacheAllPressed,
    );
    final result = data.hasMoreAudioToCache ? tile : R.spaces.empty;
    return FadeAnimatedSwitcher.short(child: result);
  }

  Widget _buildCachedAudio() {
    final deleteAllBtn = data.isCachingNow || data.hasCachedAudio == false
        ? null
        : ButtonIcon(
            R.assets.icons.trash,
            onPressed: onDeleteAllPressed,
          );
    final result = data.hasCachedAudio
        ? ListItem(
            withScreenSidePadding: true,
            title: R.strings.settings.cachedAudioTales,
            subTitle: data.cachedAudioInfo.get(),
            trailingChild: deleteAllBtn,
            leadingIcon: R.assets.icons.save,
          )
        : R.spaces.empty;
    return FadeAnimatedSwitcher.short(child: result);
  }
}
