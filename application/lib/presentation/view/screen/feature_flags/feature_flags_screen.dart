import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/domain/feature_flag/feature.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/feature_flags/manager/feature_flags_screen_manager.dart';
import 'package:mobile_app/presentation/view/screen/manager_view_mixin.dart';
import 'package:mobile_app/presentation/view/screen/screen_mixin.dart';
import 'package:mobile_app/presentation/widget/app_check_box.dart';
import 'package:mobile_app/presentation/widget/divider.dart';
import 'package:mobile_app/presentation/widget/fade_animated_switcher.dart';
import 'package:mobile_app/presentation/widget/list_item.dart';

@RoutePage()
class FeatureFlagsScreen extends StatefulWidget {
  const FeatureFlagsScreen({Key? key}) : super(key: key);

  @override
  State<FeatureFlagsScreen> createState() => _FeatureFlagsScreenState();
}

class _FeatureFlagsScreenState
    extends ScreenWidgetState<FeatureFlagsScreen, FeatureFlagsScreenManager>
    with ManagerViewMixin {
  @override
  void initState() {
    manager.getFeatureFlags();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget stateBuilder(BuildContext context, FeatureFlagsScreenState state) {
      final widget = state.map(
        initial: buildInitialState,
        ready: _buildStateReady,
      );
      return FadeAnimatedSwitcher.screen(child: widget);
    }

    final bloc = BlocBuilder(bloc: manager, builder: stateBuilder);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Feature flags',
          style: R.styles.textSubTitle,
        ),
      ),
      body: bloc,
    );
  }

  Widget _buildStateReady(FeatureFlagsScreenStateReady state) {
    final children = _getItems(state.featuresMap);
    final scrollable = SingleChildScrollView(child: Column(children: children));
    return Column(
      children: [
        R.spaces.verticalUnit,
        Expanded(child: scrollable),
        const AppDivider(),
        _buildBottomBar(state.flagsChanged),
      ],
    );
  }

  Widget _buildBottomBar(bool flagsChanged) {
    final child = !flagsChanged
        ? R.spaces.empty
        : Center(
            child: Text(
              '‼️ To apply changes,\nplease restart the app ‼️',
              style: R.styles.textSubTitle,
              textAlign: TextAlign.center,
            ),
          );

    final animated = FadeAnimatedSwitcher.middle(child: child);
    return SafeArea(
      child: SizedBox(
        height: R.dimen.toolbarHeight,
        child: animated,
      ),
    );
  }

  List<Widget> _getItems(Map<Feature, bool> featuresMap) {
    final list = <Widget>[];
    for (final entry in featuresMap.entries) {
      final item = _buildItem(entry);
      list.add(item);
    }
    return list;
  }

  Widget _buildItem(MapEntry<Feature, bool> entry) {
    final subtitle = StringBuffer('');
    if (entry.key.desc != null) {
      subtitle
        ..writeln('')
        ..writeln(entry.key.desc);
    }

    subtitle
      ..writeln('')
      ..writeln('key: ${entry.key.key}')
      ..writeln('owner: ${entry.key.owner.name}');
    void onPressed() => manager.changeFlag(entry.key);
    final checkBox = AppCheckBox(
      value: entry.value,
      onChanged: (_) => onPressed(),
    );
    final item = ListItem(
      withScreenSidePadding: false,
      contentPadding: EdgeInsets.symmetric(horizontal: R.dimen.unit),
      title: entry.key.title,
      subTitle: subtitle.toString(),
      trailingChild: checkBox,
      onPressed: onPressed,
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: R.dimen.screenPaddingSide),
      child: item,
    );
  }
}
