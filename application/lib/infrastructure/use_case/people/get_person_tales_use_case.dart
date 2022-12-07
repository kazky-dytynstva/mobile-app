import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_id.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/infrastructure/data_source/storage_local/tale/entity/tale_entity.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_storage.dart';
import 'package:mobile_app/infrastructure/helper/logger/logger.dart';

@Injectable(as: UseCase)
class GetPersonTalesUseCase extends UseCase<PersonId, GetPersonTalesOutput> {
  final TaleStorage _taleStorage;

  final Logger _logger;

  GetPersonTalesUseCase(
    this._taleStorage,
    this._logger,
  );

  @override
  Stream<GetPersonTalesOutput> transaction(PersonId input) async* {
    _logger.log(
      () => 'getPersonTalesUseCase useCase called',
      tag: logTag,
    );
    final id = input.get();
    final allTales = await _taleStorage.getAll();

    final filtered = allTales.where((tale) {
      final crew = tale.crew;

      if (crew == null) return false;

      return crew.authors?.contains(id) == true ||
          crew.readers?.contains(id) == true ||
          crew.musicians?.contains(id) == true ||
          crew.translators?.contains(id) == true ||
          crew.graphics?.contains(id) == true ||
          false;
    }).toList(growable: false);

    _logger.log(
      () => 'tales count: ${filtered.length}',
      tag: logTag,
    );

    yield GetPersonTalesOutput(filtered);
  }
}

class GetPersonTalesOutput {
  final Iterable<TaleEntity> tales;

  GetPersonTalesOutput(this.tales);
}
