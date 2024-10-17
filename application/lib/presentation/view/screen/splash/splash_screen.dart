import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/screen_mixin.dart';
import 'package:mobile_app/presentation/view/screen/splash/manager/splash_screen_manager.dart';
import 'package:mobile_app/presentation/view/screen/splash/widget/loading_failed.dart';
import 'package:mobile_app/presentation/widget/fade_animated_switcher.dart';
import 'package:mobile_app/presentation/widget/loading_bar.dart';
import 'package:mobile_app/presentation/widget/made_with_love.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState
    extends ScreenWidgetState<SplashScreen, SplashScreenManager> {
  @override
  Widget build(BuildContext context) {
    Widget stateBuilder(BuildContext context, SplashScreenState state) {
      final widget = state.map(
        initial: createInitialState,
        failed: _createInitFailedState,
      );
      return FadeAnimatedSwitcher.screen(child: widget);
    }

    return Scaffold(
        body: BlocBuilder<SplashScreenManager, SplashScreenState>(
      bloc: manager,
      builder: stateBuilder,
    ));
  }

  Widget createInitialState(_) {
    final List<Widget> children = [
      const LoadingBar(),
      Padding(
        padding: EdgeInsets.all(R.dimen.unit5),
        child: const MadeWithLove(),
      ),
    ];
    final column = Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
    return Center(child: column);
  }

  Widget _createInitFailedState(state) => LoadingFailedWidget(
        errorMsg: state.errorMsg,
        onRetryPressed: manager.retryPressed,
      );
}
