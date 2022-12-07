import 'package:injectable/injectable.dart';
import 'package:mobile_app/infrastructure/env_config/env_config.dart';
import 'package:mobile_app/infrastructure/helper/analytic/crash_analytic.dart';

import 'logger.dart';

@LazySingleton(as: Logger)
class LoggerImpl implements Logger {
  final CrashAnalytic _crashAnalytic;

  LoggerImpl(
    this._crashAnalytic,
  );

  bool get _isDebug => EnvConfig.isDebug;

  @override
  void log(
    String Function() msg, {
    String? tag,
    bool toCrashAnalytics = false,
  }) {
    if (!_isDebug) return;
    final buffer = StringBuffer()
      ..write(tag == null ? '' : '[$tag]: ')
      ..write(msg());
    final text = buffer.toString();
    // ignore: avoid_print
    print(text);
    if (toCrashAnalytics) _crashAnalytic.msg(text);
  }
}
