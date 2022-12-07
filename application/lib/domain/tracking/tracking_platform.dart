part of 'tracker.dart';

enum TrackingPlatform {
  debug('Debug'),
  firebase('Firebase');

  final String name;

  const TrackingPlatform(this.name);
}
