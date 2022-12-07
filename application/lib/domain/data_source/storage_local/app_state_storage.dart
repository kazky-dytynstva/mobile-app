import 'package:dartz/dartz.dart';
import 'package:mobile_app/domain/model/app_version/app_version.dart';
import 'package:mobile_app/domain/model/player/loop_mode.dart';
import 'package:mobile_app/domain/model/show_dot/show_dot_type.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';

abstract class AppStateStorage {
  //region lastContentUpdateDate
  Future<DateTime> getLastContentUpdateDate();

  Future<Unit> setLastContentUpdateDate(DateTime date);

  //endregion lastContentUpdateDate

  //region appStartsCount

  Future<IntPositive> getAppStartsCount();

  Future<Unit> setAppStartsCount(IntPositive appStartsCount);

  //endregion appStartsCount

  //region numberOfRatedTales
  Future<Unit> incrementNumberOfRatedTales();

  Future<IntPositive> getNumberOfRatedTales();

  //endregion numberOfRatedTales

  //region remoteConfigSyncInterval
  Future<Duration> getRemoteConfigSyncInterval();

  Future<Unit> setRemoteConfigSyncInterval({
    required IntPositive hours,
  });

  //endregion

  //region loopMode
  Future<PlayerLoopMode> getLoopMode();

  Future<Unit> setLoopMode(PlayerLoopMode loopMode);

//endregion loopMode

  //region lastKnownAppVersion

  Future<AppVersion> getLastKnownAppVersion();

  Future<Unit> setLastKnownAppVersion(AppVersion appVersion);

  //endregion lastKnownAppVersion

  //region crashLoggingEnabled

  Future<bool> getCrashLoggingEnabled();

  Future<Unit> setCrashLoggingEnabled(bool isEnabled);

  //endregion crashLoggingEnabled

  //region trackingEnabled

  Future<bool> getTrackingEnabled();

  Future<Unit> setTrackingEnabled(bool isEnabled);

  //endregion trackingEnabled

  //region showDotType
  Future<bool> showDotForType(ShowDotType type);

  Future<Unit> setShowDotType(ShowDotType type, {required bool show});

  Stream<bool> watchShowDotForType(ShowDotType type);
//endregion showDotType
}
