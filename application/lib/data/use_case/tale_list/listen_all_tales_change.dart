import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/changed_data/changed_data.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/data/data_source/storage_local/tale/entity/tale_entity.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_storage.dart';
import 'package:mobile_app/data/helper/logger/logger.dart';

@Injectable(as: UseCase)
class ListenAllTalesChangeUseCase
    extends UseCase<Dry, ChangedData<TalesPageItemData, TaleId>> {
  final TaleStorage _storage;
  final Mapper<TaleEntity, TalesPageItemData> _mapper;
  final Logger _logger;

  ListenAllTalesChangeUseCase(
    this._storage,
    this._mapper,
    this._logger,
  );

  @override
  Stream<ChangedData<TalesPageItemData, TaleId>> transaction(Dry input) async* {
    final transformer = StreamTransformer.fromHandlers(
      handleData: (
        ChangedData<TaleEntity, TaleId> data,
        EventSink<ChangedData<TalesPageItemData, TaleId>> sink,
      ) =>
          data.map(
        deleted: (TaleId id) {
          _logger.log(
            () => 'Tale with id: $id was deleted',
            tag: logTag,
          );
          sink.add(ChangedData.deleted(id));
        },
        updated: (TaleEntity entity) {
          _logger.log(
            () => 'Tale with id: ${entity.id} was changed',
            tag: logTag,
          );
          final item = _mapper.map(entity);
          sink.add(ChangedData.updated(item));
        },
      ),
    );
    yield* _storage.watch().transform(transformer);
  }
}
