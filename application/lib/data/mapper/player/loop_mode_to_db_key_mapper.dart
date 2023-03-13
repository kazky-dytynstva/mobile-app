import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/player/loop_mode.dart';

const _off = 'off';
const _all = 'all';
const _one = 'one';

@Singleton(as: Mapper)
class LoopModeToDbKeyMapper implements Mapper<PlayerLoopMode, String> {
  @override
  String map(PlayerLoopMode input) {
    switch (input) {
      case PlayerLoopMode.off:
        return _off;
      case PlayerLoopMode.all:
        return _all;
      case PlayerLoopMode.one:
        return _one;
    }
  }
}

@Singleton(as: Mapper)
class DbKeyToLoopModeMapper implements Mapper<String?, PlayerLoopMode> {
  @override
  PlayerLoopMode map(String? input) {
    switch (input) {
      case _all:
        return PlayerLoopMode.all;
      case _one:
        return PlayerLoopMode.one;
      case _off:
        return PlayerLoopMode.off;

      default:
        return PlayerLoopMode.all;
    }
  }
}
