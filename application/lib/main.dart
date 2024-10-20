import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/domain/data_source/storage_local/settings_storage.dart';
import 'package:mobile_app/data/di/dependency_injection.dart';
import 'package:mobile_app/data/env_config/env_config.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/application/application.dart';
import 'package:mobile_app/presentation/widget/custom_theme.dart';

void main() async {
  EnvConfig.validateStaging();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runZonedGuarded(
    () async {
      await configureInjection(EnvConfig.staging);
      final initialTheme = await getIt<SettingsStorage>().getAppTheme();

      final themed = CustomTheme(
        initialTheme: initialTheme,
        app: const Application(),
      );
      //ignore: deprecated_member_use
      final mediaData = MediaQueryData.fromWindow(
        //ignore: deprecated_member_use
        WidgetsBinding.instance.window,
      );
      final mediaQuery = MediaQuery(data: mediaData, child: themed);
      R.setData(mediaData);
      runApp(mediaQuery);
    },
    (Object error, StackTrace stack) {
      getIt<FirebaseCrashlytics>().recordError(error, stack);
    },
  );
}
