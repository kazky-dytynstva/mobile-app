import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/changed_data/changed_data.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_id.dart';
import 'package:mobile_app/infrastructure/data_source/storage_local/box_names.dart';

import 'entity/person_entity.dart';
import '../../../../domain/data_source/storage_local/people_storage.dart';

@LazySingleton(as: PeopleStorage)
class PeopleStorageImpl implements PeopleStorage {
  final Future<Box<PersonEntity>> _box;

  PeopleStorageImpl(
    HiveInterface hive,
  ) : _box = hive.openBox(BoxNames.people);

  @override
  Future<bool> isEmpty() async {
    final box = await _box;
    return box.isEmpty;
  }

  @override
  Future<Iterable<PersonEntity>> getPeople() async => (await _box).values;

  @override
  Future<Unit> update(PersonEntity entity) async {
    final box = await _box;
    final key = _createPersonKey(entity);
    if (entity != box.get(key)) {
      box.put(key, entity);
    }
    return unit;
  }

  @override
  Future<PersonEntity?> find(PersonId personId) async {
    final box = await _box;
    final entity = box.get(personId.toKey);
    return entity;
  }

  @override
  Future<Unit> deletePeople(Iterable<PersonId> ids) async {
    final box = await _box;
    for (final id in ids) {
      await box.delete(id.toKey);
    }
    return unit;
  }

  @override
  Future<Unit> updatePeople(Iterable<PersonEntity> entities) async {
    final box = await _box;
    for (final newEntity in entities) {
      final key = _createPersonKey(newEntity);
      final currentEntity = box.get(key);

      if (currentEntity == null) {
        box.put(key, newEntity);
      } else {
        final updatedEntity = currentEntity.copy(
          name: newEntity.name,
          url: newEntity.url,
          info: newEntity.info,
          //region should be taken from current person
          isFavorite: currentEntity.isFavorite,
          //endregion should be taken from current person
        );
        if (updatedEntity != currentEntity) {
          box.put(key, updatedEntity);
        }
      }
    }

    return unit;
  }

  int _createPersonKey(PersonEntity entity) => entity.id;

  @override
  Stream<ChangedData<PersonEntity, PersonId>> watch({
    PersonId? personId,
  }) async* {
    final transformer = StreamTransformer.fromHandlers(
      handleData: (
        BoxEvent event,
        EventSink<ChangedData<PersonEntity, PersonId>> sink,
      ) {
        final ChangedData<PersonEntity, PersonId> data = event.deleted
            ? ChangedData.deleted(PersonId(event.key as int))
            : ChangedData.updated(event.value as PersonEntity);
        sink.add(data);
      },
    );
    yield* (await _box).watch(key: personId?.toKey).transform(transformer);
  }
}

extension on PersonId {
  int get toKey => get();
}
