import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/data_source/storage_local/app_state_storage.dart';
import 'package:mobile_app/infrastructure/helper/player/audio_player.dart';

@Injectable(as: UseCase)
class SetInitialLoopModeUseCase extends UseCase<Dry, SetInitialLoopModeOutput> {
  final AppStateStorage _storage;
  final AudioPlayer _player;

  SetInitialLoopModeUseCase(
    this._storage,
    this._player,
  );

  @override
  Stream<SetInitialLoopModeOutput> transaction(Dry input) async* {
    final loopMode = await _storage.getLoopMode();
    await _player.setInitialLoopMode(loopMode);
    yield _output;
  }
}

class SetInitialLoopModeOutput {
  const SetInitialLoopModeOutput._();
}

const _output = SetInitialLoopModeOutput._();
