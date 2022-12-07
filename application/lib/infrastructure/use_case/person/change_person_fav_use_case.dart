import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/data_source/storage_local/people_storage.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_id.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/infrastructure/helper/logger/logger.dart';

@Injectable(as: UseCase)
class ChangePersonFavUseCase extends UseCase<ChangePersonFavInput, Dry> {
  final PeopleStorage _storage;
  final Logger _logger;

  ChangePersonFavUseCase(
    this._storage,
    this._logger,
  );

  @override
  Stream<Dry> transaction(ChangePersonFavInput input) async* {
    final entity = await _storage.find(input.id);
    if (entity != null) {
      await _storage.update(entity.copy(isFavorite: input.isFav));
      _logger.log(
        () => 'Person with id: ${input.id} new isFav = ${input.isFav}',
        tag: logTag,
      );
    } else {
      _logger.log(
        () => 'Can not change isFav.Person with id: ${input.id} not found',
        tag: logTag,
      );
    }
    yield dry;
  }
}

@immutable
class ChangePersonFavInput {
  final PersonId id;
  final bool isFav;

  const ChangePersonFavInput(
    this.id,
    this.isFav,
  );
}
