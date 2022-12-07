import 'package:flutter/material.dart';
import 'package:mobile_app/infrastructure/di/dependency_injection.dart';
import 'package:mobile_app/infrastructure/env_config/env_config.dart';
import 'package:mobile_app/presentation/navigation/screen/screen_controller.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/custom_theme.dart';

class Application extends StatefulWidget {
  const Application({
    Key? key,
  }) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application>
    with CustomThemeStatefulMixin {
  late final _screenController = getIt<ScreenController>();

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerDelegate: _screenController.routerDelegate,
        routeInformationParser: _screenController.routerParser,
        routeInformationProvider: _screenController.routerProvider,
        debugShowCheckedModeBanner: EnvConfig.isDebug,
        theme: R.themeData,
      );
}
