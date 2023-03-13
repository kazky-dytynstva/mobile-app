import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:mobile_app/domain/tracking/tracker.dart';

class FirebaseTracker implements Tracker {
  final FirebaseAnalytics _firebaseAnalytics;

  FirebaseTracker(this._firebaseAnalytics);

  @override
  void event(TrackingEvent event, [Map<String, dynamic>? params]) {
    if (event.platforms.contains(TrackingPlatform.firebase)) {
      _firebaseAnalytics.logEvent(name: event.name, parameters: params);
    }
  }

  @override
  void view(TrackingView view) {
    if (view.platforms.contains(TrackingPlatform.firebase)) {
      _firebaseAnalytics.logScreenView(screenName: view.name);
    }
  }
}
