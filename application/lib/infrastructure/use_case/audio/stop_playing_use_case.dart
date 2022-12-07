import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/play_audio_action/play_audio_action.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/infrastructure/helper/player/audio_player.dart';

@Injectable(as: UseCase)
class StopPlayingUseCase extends UseCase<Dry, StopPlayingOutput> {
  final AudioPlayer _player;

  StopPlayingUseCase(this._player);

  @override
  Stream<StopPlayingOutput> transaction(Dry input) async* {
    await _player.action(const PlayAudioAction.stop());
    yield _unit;
  }
}

class StopPlayingOutput {
  const StopPlayingOutput._();
}

const _unit = StopPlayingOutput._();
