import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/data/di/dependency_injection.dart';
import 'package:mobile_app/presentation/view/screen/manager_view_mixin.dart';
import 'package:mobile_app/presentation/view/screen/tale/manager/tale_screen_manager.dart';

abstract class BaseTalePageState<T extends StatefulWidget,
        Manager extends Cubit> extends State<T>
    with AutomaticKeepAliveClientMixin<T>, ManagerViewMixin {
  late final TaleScreenManager _screenManager = getIt<TaleScreenManager>();

  @protected
  late final manager = getIt<Manager>();

  @override
  bool get wantKeepAlive => !_screenManager.isStopped;

  @override
  void initState() {
    _screenManager.addTaleUpdateListener(manager as UpdateTaleCallback);
    super.initState();
  }
}
