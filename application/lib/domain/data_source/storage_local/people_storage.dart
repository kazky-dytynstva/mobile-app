import 'package:dartz/dartz.dart';
import 'package:mobile_app/domain/model/changed_data/changed_data.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_id.dart';

import '../../../infrastructure/data_source/storage_local/people/entity/person_entity.dart';

abstract class PeopleStorage {
  Future<bool> isEmpty();

  Future<Iterable<PersonEntity>> getPeople();

  Future<PersonEntity?> find(PersonId personId);

  Future<Unit> update(PersonEntity entity);

  Future<Unit> updatePeople(Iterable<PersonEntity> entities);

  Future<Unit> deletePeople(Iterable<PersonId> ids);

  /// Emit [ChangedData] when changes happened :)
  /// If [personId] is NOT null, then will [watch] changes for it,
  /// otherwise - for the whole storage
  Stream<ChangedData<PersonEntity, PersonId>> watch({PersonId? personId});
}
