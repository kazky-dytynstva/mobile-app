import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/screen_mixin.dart';
import 'package:mobile_app/presentation/view/screen/whats_new/manager/whats_new_screen_manager.dart';
import 'package:mobile_app/presentation/view/screen/whats_new/widget/whats_new_changes.dart';
import 'package:mobile_app/presentation/widget/bottom_bar_with_actions.dart';
import 'package:mobile_app/presentation/widget/fade_animated_switcher.dart';

@RoutePage()
class WhatsNewScreen extends StatefulWidget {
  const WhatsNewScreen({Key? key}) : super(key: key);

  @override
  State<WhatsNewScreen> createState() => _WhatsNewScreenState();
}

class _WhatsNewScreenState
    extends ScreenWidgetState<WhatsNewScreen, WhatsNewScreenManager> {
  @override
  void initState() {
    manager.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget stateBuilder(BuildContext context, WhatsNewScreenState state) {
      final widget = state.map(
        init: buildInitialState,
        ready: _buildReadyState,
      );
      return FadeAnimatedSwitcher.screen(child: widget);
    }

    final blocBuilder = BlocBuilder<WhatsNewScreenManager, WhatsNewScreenState>(
      bloc: manager,
      builder: stateBuilder,
    );
    return Scaffold(
      appBar: _buildToolbar(),
      body: blocBuilder,
    );
  }

  AppBar _buildToolbar() => AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          R.strings.menuItem.whatsNew,
          style: R.styles.toolbarTitle,
        ),
      );

  Widget _buildReadyState(WhatsNewScreenStateReady state) {
    final changes = <Widget>[
      ...state.changes.map((e) => WhatsNewsChanges(changes: e)).toList(),
      SizedBox(height: R.dimen.bottomBarWithActionsHeight)
    ];
    final content = SingleChildScrollView(child: Column(children: changes));

    return Stack(
      children: [
        Positioned.fill(child: content),
        Positioned.fill(
          top: null,
          child: _buildBottomBar(),
        ),
      ],
    );
  }

  Widget _buildBottomBar() => BottomBarWithActions(
        onBackPressed: manager.onBackPressed,
      );
}
