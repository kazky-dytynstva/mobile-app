import 'package:mobile_app/domain/tracking/tracker.dart';

export 'package:mobile_app/domain/tracking/tracker.dart';

class TrackerGroupImpl implements Tracker {
  final List<Tracker> _trackers;

  const TrackerGroupImpl(this._trackers);

  @override
  void event(TrackingEvent event, [Map<String, Object>? params]) {
    for (final Tracker tracker in _trackers) {
      tracker.event(event, params);
    }
  }

  @override
  void view(TrackingView view) {
    for (final Tracker tracker in _trackers) {
      tracker.view(view);
    }
  }
}
