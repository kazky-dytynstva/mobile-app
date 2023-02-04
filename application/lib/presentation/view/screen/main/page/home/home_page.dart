import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/infrastructure/di/dependency_injection.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/main/page/home/manager/home_page_manager.dart';
import 'package:mobile_app/presentation/view/screen/manager_view_mixin.dart';
import 'package:mobile_app/presentation/widget/custom_theme.dart';
import 'package:mobile_app/presentation/widget/fade_animated_switcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with
        AutomaticKeepAliveClientMixin,
        ManagerViewMixin,
        CustomThemeStatefulMixin,
        SingleTickerProviderStateMixin {
  late final _manager = getIt<HomePageManager>();

  late final tabController = TabController(
    length: 2,
    vsync: this,
  );

  Duration get showBackTimeOut => R.durations.showHiddenScrolledWidget;

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Widget stateBuilder(BuildContext context, HomePageState state) {
      final widget = state.map(
        initial: buildInitialState,
      );
      return FadeAnimatedSwitcher.screen(child: widget);
    }

    return BlocBuilder(bloc: _manager, builder: stateBuilder);
  }
}
