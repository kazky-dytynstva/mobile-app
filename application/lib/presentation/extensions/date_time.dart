extension DateTimeX on DateTime {
  DateTime roundDown({Duration delta = const Duration(minutes: 5)}) {
    final timeToRemove = millisecondsSinceEpoch % delta.inMilliseconds;
    return DateTime.fromMillisecondsSinceEpoch(
        millisecondsSinceEpoch - timeToRemove);
  }

  DateTime roundUp({Duration delta = const Duration(minutes: 5)}) {
    final timeToAdd =
        (millisecondsSinceEpoch % delta.inMilliseconds) - delta.inMilliseconds;
    return DateTime.fromMillisecondsSinceEpoch(
      millisecondsSinceEpoch - timeToAdd,
    );
  }
}
