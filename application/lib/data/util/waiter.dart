import 'package:dartz/dartz.dart';

class Waiter {
  final Duration timeToWait;

  Waiter({
    required this.timeToWait,
  });

  DateTime? _start;

  void start() {
    _start = DateTime.now();
  }

  Future<Unit> waitFor() async {
    final start = _start;
    if (start == null) return unit;

    final diff = DateTime.now().difference(start);
    final leftToWait = timeToWait.inMilliseconds - diff.inMilliseconds;
    if (leftToWait > 0) {
      await Future.delayed(Duration(milliseconds: leftToWait));
    }

    return unit;
  }
}
