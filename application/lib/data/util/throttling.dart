class Throttler {
  final Duration _duration;

  Throttler(this._duration);

  bool _isReady = true;

  void throttle(Function action) {
    if (!_isReady) return;

    _isReady = false;
    action();
    Future.delayed(_duration).then((value) => _isReady = true);
  }

  bool canDoAction() => _isReady;
}
