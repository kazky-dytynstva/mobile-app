import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/data/data_source/storage_local/tale/entity/tale_entity.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_storage.dart';
import 'package:mobile_app/data/helper/logger/logger.dart';

const _maxTryCount = 5;

@Injectable(as: UseCase)
class GetRandomTalePageItemDataUseCase extends UseCase<Dry, TalesPageItemData> {
  final TaleStorage _storage;
  final Mapper<TaleEntity, TalesPageItemData> _mapper;
  final Logger _logger;

  final Set<TaleEntity> _previous = {};

  GetRandomTalePageItemDataUseCase(
    this._storage,
    this._logger,
    this._mapper,
  );

  int _tryCounter = 0;

  @override
  Stream<TalesPageItemData> transaction(Dry input) async* {
    _tryCounter = 0;
    final all = await _storage.getAll();
    if (_previous.length == all.length) {
      // chances are low, but still )
      _previous.clear();
    }
    final random = _getRandom(all.toList());
    final itemData = _mapper.map(random);
    _logger.log(
      () => 'Random tale was selected. id=${random.id} ',
      tag: logTag,
    );
    yield itemData;
  }

  TaleEntity _getRandom(List<TaleEntity> all) {
    all.shuffle();
    final entity = all.first;
    if (_previous.contains(entity)) {
      return _getRandom(all);
    }

    while (entity.isWatched == true && _tryCounter < _maxTryCount) {
      _tryCounter++;
      return _getRandom(all);
    }
    return entity;
  }
}
