import 'dart:async';
import 'dart:ui';

class Debouncer {
  final Duration _duration;

  Timer? _timer;

  Debouncer(this._duration);

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(_duration, action);
  }
}
