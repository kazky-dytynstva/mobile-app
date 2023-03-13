import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/changed_data/changed_data.dart';
import 'package:mobile_app/domain/model/tale/tale.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/data/data_source/storage_local/tale/entity/tale_entity.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_storage.dart';

@Injectable(as: UseCase)
class ListenTaleChangesUseCase
    extends UseCase<ListenTaleChangesInput, ChangedData<Tale, TaleId>> {
  final TaleStorage _storage;
  final Mapper<TaleEntity, Tale> _mapper;

  ListenTaleChangesUseCase(
    this._storage,
    this._mapper,
  );

  @override
  Stream<ChangedData<Tale, TaleId>> transaction(
    ListenTaleChangesInput input,
  ) async* {
    final transformer = StreamTransformer.fromHandlers(
      handleData: (ChangedData<TaleEntity, TaleId> data,
              EventSink<ChangedData<Tale, TaleId>> sink) =>
          data.map(
        deleted: (TaleId id) {
          sink.add(ChangedData.deleted(id));
        },
        updated: (TaleEntity entity) {
          sink.add(ChangedData.updated(_mapper.map(entity)));
        },
      ),
    );
    yield* _storage.watch(taleId: input.taleId).transform(transformer);
  }
}

@immutable
class ListenTaleChangesInput {
  final TaleId taleId;

  const ListenTaleChangesInput(this.taleId);
}
