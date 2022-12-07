import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_storage.dart';
import 'package:mobile_app/infrastructure/helper/logger/logger.dart';

@Injectable(as: UseCase)
class MarkTaleWatchedUseCase extends UseCase<TaleId, MarkTaleWatchedOutput> {
  final TaleStorage _storage;
  final Logger _logger;

  MarkTaleWatchedUseCase(
    this._storage,
    this._logger,
  );

  @override
  Stream<MarkTaleWatchedOutput> transaction(TaleId input) async* {
    final entity = await _storage.find(input);

    if (entity == null) {
      yield _output;
      _logger.log(
        () => 'tale with id ${input.get()} was not found',
        tag: logTag,
      );
      return;
    }

    if (entity.isWatched) {
      _logger.log(
        () => 'tale with id ${input.get()} already marked as watched',
        tag: logTag,
      );
      yield _output;
      return;
    }

    final updated = entity.copyWith(isWatched: true);
    await _storage.update(updated);
    _logger.log(
      () => 'tale with id ${input.get()} marked as watched',
      tag: logTag,
    );

    yield _output;
  }
}

class MarkTaleWatchedOutput {
  const MarkTaleWatchedOutput._();
}

const _output = MarkTaleWatchedOutput._();
