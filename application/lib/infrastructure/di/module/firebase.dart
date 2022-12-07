import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/data_source/storage_local/app_state_storage.dart';
import 'package:mobile_app/infrastructure/env_config/env_config.dart';

@module
abstract class ModuleFirebase {
  @lazySingleton
  @preResolve
  Future<FirebaseCrashlytics> getFirebaseCrashlytics(
    AppStateStorage storage,
  ) async {
    await Firebase.initializeApp();
    final instance = FirebaseCrashlytics.instance;
    FlutterError.onError = instance.recordFlutterError;
    storage
        .getCrashLoggingEnabled()
        .then(instance.setCrashlyticsCollectionEnabled);
    return instance;
  }

  @factoryMethod
  NavigatorObserver analyticsNavigationObserver(FirebaseAnalytics analytics) {
    return FirebaseAnalyticsObserver(analytics: analytics);
  }

  @lazySingleton
  FirebaseDatabase get firebaseDatabase {
    final instance = FirebaseDatabase.instance;
    instance.setLoggingEnabled(!EnvConfig.isProd);
    return instance;
  }

  @preResolve
  @lazySingleton
  Future<FirebaseRemoteConfig> firebaseRemoteConfig(
    FirebaseCrashlytics a,
  ) async =>
      FirebaseRemoteConfig.instance;

  @lazySingleton
  FirebaseAnalytics firebaseAnalytics(
    FirebaseCrashlytics a,
    AppStateStorage storage,
  ) {
    final instance = FirebaseAnalytics.instance;
    storage.getTrackingEnabled().then(instance.setAnalyticsCollectionEnabled);
    return instance;
  }

  @lazySingleton
  FirebaseInstallations get firebaseInstallations =>
      FirebaseInstallations.instance;
}
