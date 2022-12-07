import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/infrastructure/data_source/storage_local/tale/entity/tale_entity.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_storage.dart';
import 'package:mobile_app/infrastructure/helper/logger/logger.dart';

typedef GetAllTalesOutput = Iterable<TalesPageItemData>;

@Injectable(as: UseCase)
class GetAllTalesUseCase extends UseCase<Dry, GetAllTalesOutput> {
  final TaleStorage _storage;
  final Mapper<TaleEntity, TalesPageItemData> _mapper;
  final Logger _logger;

  GetAllTalesUseCase(
    this._storage,
    this._mapper,
    this._logger,
  );

  @override
  Stream<GetAllTalesOutput> transaction(Dry input) async* {
    _logger.log(
      () => 'getAllTales useCase called',
      tag: logTag,
    );
    final entities = await _storage.getAll();
    _logger.log(
      () => 'tales count: ${entities.length}',
      tag: logTag,
    );
    yield entities.map(_mapper.map);
  }
}
