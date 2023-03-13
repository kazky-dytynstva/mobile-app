import 'package:mobile_app/data/env_config/env_config.dart';

enum CountdownTime {
  min5(EnvConfig.isProd ? Duration(minutes: 5) : Duration(seconds: 63)),
  min10(EnvConfig.isProd ? Duration(minutes: 10) : Duration(seconds: 123)),
  min20(Duration(minutes: 20)),
  min30(Duration(minutes: 30)),
  min60(Duration(minutes: 60)),
  min120(Duration(minutes: 120)),
  off(Duration.zero);

  final Duration duration;

  const CountdownTime(this.duration);
}

extension CountdownTimeX on CountdownTime {
  bool get isOff => this == CountdownTime.off;

  bool get isLessThanHour => duration.inMinutes < 60;
}
