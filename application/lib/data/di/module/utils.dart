import 'package:audio_session/audio_session.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/services.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:mobile_app/data/di/dependency_injection.dart';
import 'package:mobile_app/data/env_config/env_config.dart';
import 'package:mobile_app/data/helper/logger/logger.dart';
import 'package:mobile_app/data/helper/player/audio_session_hanler.dart';
import 'package:mobile_app/data/helper/tracking/tracker_debug.dart';
import 'package:mobile_app/data/helper/tracking/tracker_firebase.dart';
import 'package:mobile_app/data/helper/tracking/tracker_group.dart';
import 'package:mobile_app/presentation/navigation/screen/router/router.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:package_info_plus/package_info_plus.dart';

@module
abstract class ModuleUtils {
  @lazySingleton
  Tracker tracker(FirebaseAnalytics analytics) => TrackerGroupImpl([
        DebugTracker(getIt<Logger>()),
        FirebaseTracker(analytics),
      ]);

  @lazySingleton
  AssetBundle get assetBundle => rootBundle;

  @lazySingleton
  InAppReview get inAppReview => InAppReview.instance;

  @preResolve
  @singleton
  Future<PackageInfo> get packageInfo async => PackageInfo.fromPlatform();

  @singleton
  AudioPlayer get audioPlayer {
    final android = AndroidLoadControl(prioritizeTimeOverSizeThresholds: true);
    final loadConfig = AudioLoadConfiguration(androidLoadControl: android);
    final player = AudioPlayer(audioLoadConfiguration: loadConfig);

    final sessionConfig = AudioSessionHandler(AudioSession.instance, player);
    sessionConfig.init();

    Future.delayed(const Duration(seconds: 1)).then((value) {
      JustAudioBackground.init(
        androidNotificationChannelId: EnvConfig.appBundle,
        androidNotificationChannelName: R.strings.general.appName,
        androidNotificationOngoing: true,
        androidStopForegroundOnPause: true,
        notificationColor: R.palette.accent,
        preloadArtwork: false,
      );
    });

    return player;
  }

  @singleton
  RootStackRouter get appRouter => AppRouter();
}
