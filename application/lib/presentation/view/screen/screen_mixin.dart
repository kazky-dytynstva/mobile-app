import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/infrastructure/di/dependency_injection.dart';
import 'package:mobile_app/presentation/navigation/screen/context_keeper/screen_context_keeper.dart';
import 'package:mobile_app/presentation/view/screen/manager_view_mixin.dart';
import 'package:mobile_app/presentation/widget/custom_theme.dart';

abstract class ScreenWidgetState<T extends StatefulWidget,
        Manager extends Cubit> extends State<T>
    with CustomThemeStatefulMixin, WidgetsBindingObserver, ManagerViewMixin {
  late final _contextKeeper = getIt<ScreenContextKeeper>();
  @protected
  late final manager = getIt<Manager>();

  bool get disposeManager => true;

  @mustCallSuper
  @override
  void initState() {
    _contextKeeper.addState(this);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @mustCallSuper
  @override
  void dispose() {
    _contextKeeper.removeState(this);
    WidgetsBinding.instance.removeObserver(this);
    if (disposeManager) {
      manager.close();
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        onResume();
        break;
      case AppLifecycleState.paused:
        onPause();
        break;
      default:
        break;
    }
  }

  @protected
  void onResume() {}

  @protected
  void onPause() {}
}
