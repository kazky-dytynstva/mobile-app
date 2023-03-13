import 'package:mobile_app/domain/tracking/tracker.dart';
import 'package:mobile_app/data/env_config/env_config.dart';
import 'package:mobile_app/data/helper/logger/logger.dart';

class DebugTracker implements Tracker {
  final Logger _logger;

  DebugTracker(this._logger);

  @override
  void event(TrackingEvent event, [Map<String, dynamic>? params]) {
    _log("event", event.name, event.platforms, params);
  }

  @override
  void view(TrackingView view) {
    _log("view", view.name, view.platforms, null);
  }

  void _log(
    String type,
    String name,
    List<TrackingPlatform> platforms,
    Map<String, dynamic>? params,
  ) {
    if (EnvConfig.isProd) return;

    _printMsg(" ╔═════════ FirebaseAnalytics event ═══");
    _printMsg(" ║ type: $type");
    _printMsg(" ║ name: $name");
    _printMsg(" ║ platforms: ${platforms.map((e) => e.name).join(", ")}");

    if (params == null) {
      _printMsg(" ║ params: [empty]");
    } else {
      _printMsg(" ║ params:");
      params.forEach((String key, dynamic value) {
        _printMsg(" ║    $key : $value");
      });
    }
    _printMsg(" ╚═════════");
  }

  void _printMsg(String msg) => _logger.log(
        () => msg,
        tag: 'DEBUG_TRACKER',
      );
}
