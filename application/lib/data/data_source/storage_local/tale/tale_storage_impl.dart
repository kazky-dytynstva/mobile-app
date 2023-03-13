import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_storage.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/model/changed_data/changed_data.dart';
import 'package:mobile_app/data/data_source/storage_local/box_names.dart';
import 'package:mobile_app/data/data_source/storage_local/tale/entity/rating/rating_entity.dart';
import 'entity/tale_entity.dart';
import 'helper/tale_entity_update_helper.dart';

@LazySingleton(as: TaleStorage)
class TaleStorageImpl implements TaleStorage {
  final Future<Box<TaleEntity>> _box;
  final TaleEntityUpdateHelper _taleUpdateHelper;

  TaleStorageImpl(
    HiveInterface hive,
    this._taleUpdateHelper,
  ) : _box = hive.openBox(BoxNames.tales);

  @override
  Future<bool> isEmpty() async {
    final box = await _box;
    return box.isEmpty;
  }

  @override
  Future<Iterable<TaleEntity>> getAll() async {
    final box = await _box;
    return box.values;
  }

  @override
  Future<TaleEntity?> find(TaleId taleId) async {
    final box = await _box;
    final entity = box.get(_createTaleKey(taleId));
    return entity;
  }

  @override
  Future<Unit> update(TaleEntity entity) async {
    final box = await _box;
    final key = _createTaleKeyNew(entity);
    if (entity != box.get(key)) {
      box.put(key, entity);
    }
    return unit;
  }

  @override
  Future<Unit> deleteTales(Iterable<TaleId> ids) async {
    final box = await _box;
    for (final id in ids) {
      final key = _createTaleKey(id);
      await box.delete(key);
    }
    return unit;
  }

  @override
  Future<Unit> updateTales(Iterable<TaleEntity> tales) async {
    final box = await _box;

    for (final newTale in tales) {
      final key = _createTaleKeyNew(newTale);
      final currentTale = box.get(key);

      if (currentTale == null) {
        box.put(key, newTale);
      } else {
        final updatedTale = _taleUpdateHelper.getUpdated(
          newTale: newTale,
          currentTale: currentTale,
        );
        if (currentTale != updatedTale) {
          box.put(key, updatedTale);
        }
      }
    }
    return unit;
  }

  @override
  Future<Unit> updateRatings(Map<TaleId, RatingEntity> ratings) async {
    final box = await _box;
    for (final entry in ratings.entries) {
      final key = _createTaleKey(entry.key);
      final tale = box.get(key);
      if (tale != null) {
        final updatedTale = tale.copyWith(rating: entry.value);
        await box.put(key, updatedTale);
      }
    }
    return unit;
  }

  @override
  Stream<ChangedData<TaleEntity, TaleId>> watch({TaleId? taleId}) async* {
    final transformer = StreamTransformer.fromHandlers(
      handleData: (
        BoxEvent event,
        EventSink<ChangedData<TaleEntity, TaleId>> sink,
      ) {
        late final ChangedData<TaleEntity, TaleId> data;
        if (event.deleted) {
          data = ChangedData.deleted(TaleId(event.key as int));
        } else {
          data = ChangedData.updated(event.value as TaleEntity);
        }
        sink.add(data);
      },
    );
    final id = taleId == null ? null : _createTaleKey(taleId);
    yield* (await _box).watch(key: id).transform(transformer);
  }

  int _createTaleKeyNew(TaleEntity entity) => entity.id;

  int _createTaleKey(TaleId id) => id.get();
}
