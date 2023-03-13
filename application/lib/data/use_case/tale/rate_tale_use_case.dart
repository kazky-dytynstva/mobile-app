import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/data_source/storage_local/app_state_storage.dart';
import 'package:mobile_app/domain/model/rating/rating_type.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_storage.dart';
import 'package:mobile_app/data/data_source/remote_api/base/api_client.dart';
import 'package:mobile_app/data/helper/logger/logger.dart';

@Injectable(as: UseCase)
class RateTaleUseCase extends UseCase<RateTaleInput, bool> {
  final ApiClient _apiClient;
  final TaleStorage _storage;
  final AppStateStorage _appStateStorage;
  final Logger _logger;

  RateTaleUseCase(
    this._apiClient,
    this._storage,
    this._appStateStorage,
    this._logger,
  );

  @override
  Stream<bool> transaction(RateTaleInput input) async* {
    final entity = await _storage.find(input.taleId);

    if (entity == null) {
      yield false;
      _logger.log(
        () => 'tale with id ${input.taleId.get()} was not found',
        tag: logTag,
      );
      return;
    }

    if (entity.isRated) {
      _logger.log(
        () => 'tale with id ${input.taleId.get()} already marked as rated',
        tag: logTag,
      );
      yield false;
      return;
    }
    final either =
        await _apiClient.rateTale(taleId: input.taleId, type: input.type);
    yield* either.fold((l) async* {
      yield false;
    }, (r) async* {
      final updated = entity.copyWith(isRated: true);
      await _storage.update(updated);
      _logger.log(
        () => 'tale with id ${input.taleId.get()} marked as rated',
        tag: logTag,
      );
      await _appStateStorage.incrementNumberOfRatedTales();
      yield true;
    });
  }
}

class RateTaleInput {
  final TaleId taleId;
  final RatingType type;

  RateTaleInput(
    this.taleId,
    this.type,
  );
}
