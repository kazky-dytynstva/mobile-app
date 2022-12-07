import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/infrastructure/di/dependency_injection.dart';
import 'package:mobile_app/infrastructure/env_config/env_config.dart';
import 'package:mobile_app/infrastructure/helper/analytic/crash_analytic.dart';
import 'package:mobile_app/infrastructure/helper/logger/logger.dart';

@Singleton(as: CrashAnalytic)
class CrashAnalyticIml implements CrashAnalytic {
  final FirebaseCrashlytics _crashlytics;

  CrashAnalyticIml(this._crashlytics);

  @override
  void setEnable(bool enable) {
    _crashlytics.setCrashlyticsCollectionEnabled(enable);
    if (enable) {
      _crashlytics.sendUnsentReports();
    }
    _log('setEnable to $enable');
  }

  @override
  void exception(
    dynamic exception,
    StackTrace trace, {
    bool fatal = false,
  }) {
    _crashlytics.recordError(exception, trace, fatal: fatal);
    _log(
        'Exception:\n    isFatal:$fatal,\n    msg: $exception\n    trace: ${trace.toString()}');
  }

  @override
  void msg(String msg) {
    _crashlytics.log(msg);
    _log('msg: $msg');
  }

  @override
  void setKey({
    required String key,
    required String value,
  }) {
    _crashlytics.setCustomKey(key, value.toString());
    _log('setKey: key($key), value: (${value.toString()})');
  }

  @override
  void setUserId(String userId) {
    _crashlytics.setUserIdentifier(userId);
    _log('setUserId: $userId');
  }

  void _log(String msg) {
    if (!EnvConfig.isDebug) return;
    getIt<Logger>().log(
      () => msg,
      tag: 'CRASH_ANALYTIC',
      toCrashAnalytics: false,
    );
  }
}
