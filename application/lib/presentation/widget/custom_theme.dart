import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/domain/data_source/storage_local/settings_storage.dart';
import 'package:mobile_app/domain/model/app_theme/app_theme.dart';
import 'package:mobile_app/data/di/dependency_injection.dart';
import 'package:mobile_app/presentation/resource/r.dart';

typedef AppBuilder = Widget Function();

class CustomTheme extends StatefulWidget {
  final Widget app;
  final AppTheme initialTheme;

  const CustomTheme({
    super.key,
    required this.initialTheme,
    required this.app,
  });

  @override
  State<CustomTheme> createState() => _CustomThemeState();

  static void depend(BuildContext context) {
    context.dependOnInheritedWidgetOfExactType<_CustomTheme>();
  }
}

class _CustomThemeState extends State<CustomTheme> with WidgetsBindingObserver {
  @override
  void didChangeMetrics() {
    R.setData(MediaQuery.of(context));
    super.didChangeMetrics();
  }

  @override
  void didChangePlatformBrightness() => _updateTheme(R.theme);

  ThemeData get themeData => R.themeData;

  @override
  void initState() {
    getIt<SettingsStorage>().watchAppThemeChanges().listen(_updateTheme);
    R.setTheme(widget.initialTheme);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _CustomTheme(
        data: this,
        child: widget.app,
      );

  void _updateTheme(AppTheme theme) => setState(() {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(statusBarBrightness: theme.brightness),
        );
        R.setTheme(theme);
      });
}

class _CustomTheme extends InheritedWidget {
  final _CustomThemeState data;

  const _CustomTheme({
    required this.data,
    required super.child,
  });

  @override
  bool updateShouldNotify(_CustomTheme oldWidget) {
    return true;
  }
}

mixin CustomThemeStatefulMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      CustomTheme.depend(context);
    });
    super.initState();
  }
}

mixin CustomThemeStatelessMixin on StatelessWidget {
  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    CustomTheme.depend(context);
    return R.spaces.empty;
  }
}
