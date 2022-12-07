import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_storage.dart';
import 'package:mobile_app/infrastructure/helper/logger/logger.dart';

@Injectable(as: UseCase)
class ChangeTaleFavUseCase extends UseCase<ChangeTaleFavInput, Dry> {
  final TaleStorage _storage;
  final Logger _logger;

  ChangeTaleFavUseCase(
    this._storage,
    this._logger,
  );

  @override
  Stream<Dry> transaction(ChangeTaleFavInput input) async* {
    final entity = await _storage.find(input.id);
    if (entity != null) {
      await _storage.update(entity.copyWith(isFavorite: input.isFav));
      _logger.log(
        () => 'Tale with id: ${input.id} new isFav = ${input.isFav}',
        tag: logTag,
      );
    } else {
      _logger.log(
        () => 'Can not change isFav.Tale with id: ${input.id} not found',
        tag: logTag,
      );
    }
    yield dry;
  }
}

@immutable
class ChangeTaleFavInput {
  final TaleId id;
  final bool isFav;

  const ChangeTaleFavInput(
    this.id,
    this.isFav,
  );
}
