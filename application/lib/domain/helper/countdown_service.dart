import 'package:mobile_app/domain/model/player/countdown_time.dart';

abstract class CountdownService {
  void set(CountdownTime time);

  bool get isRunning;

  Duration get remainingTime;

  void pingWhenDone(Function callback);
}
