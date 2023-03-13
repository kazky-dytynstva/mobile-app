import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/player/loop_mode.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/data_source/storage_local/app_state_storage.dart';
import 'package:mobile_app/data/helper/logger/logger.dart';

@Injectable(as: UseCase)
class SaveLoopModeUseCase extends UseCase<PlayerLoopMode, SaveLoopModeOutput> {
  final AppStateStorage _storage;
  final Logger _logger;

  SaveLoopModeUseCase(
    this._storage,
    this._logger,
  );

  @override
  Stream<SaveLoopModeOutput> transaction(PlayerLoopMode input) async* {
    await _storage.setLoopMode(input);

    _logger.log(
      () => 'New loopMode was saved ($input)',
      tag: logTag,
    );

    yield _output;
  }
}

class SaveLoopModeOutput {
  const SaveLoopModeOutput._();
}

const _output = SaveLoopModeOutput._();
