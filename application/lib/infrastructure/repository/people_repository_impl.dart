import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_id.dart';
import 'package:mobile_app/domain/model/changed_data/changed_data.dart';
import 'package:mobile_app/domain/repository/people_repository.dart';
import 'package:mobile_app/infrastructure/data_source/storage_local/people/entity/person_entity.dart';
import 'package:mobile_app/domain/data_source/storage_local/people_storage.dart';

@LazySingleton(as: PeopleRepository)
class PeopleRepositoryImpl implements PeopleRepository {
  final PeopleStorage _storage;
  final List<Person> _peopleList = [];
  final Mapper<PersonEntity, Person> _entityToModelMapper;

  PeopleRepositoryImpl(
    this._storage,
    this._entityToModelMapper,
  );

  @override
  Option<Person> find(PersonId id) {
    final person = _peopleList.firstWhereOrNull((it) => it.id == id);
    if (person == null) {
      return const None();
    }
    return Some(person);
  }

  @override
  Iterable<Person> getAll() => _peopleList;

  @override
  Future<Unit> prepare(bool force) async {
    if (force) {
      _peopleList.clear();
    }
    if (_peopleList.isEmpty) {
      final entities = await _storage.getPeople();
      final people = entities.map(_entityToModelMapper.map);
      _peopleList.addAll(people);
      _setStorageWatchListener();
    }
    return unit;
  }

  void _setStorageWatchListener() {
    void listener(ChangedData<PersonEntity, PersonId> data) => data.map(
          deleted: (PersonId id) =>
              _peopleList.removeWhere((it) => it.id == id),
          updated: (PersonEntity entity) {
            final person = _entityToModelMapper.map(entity);
            final index = _peopleList.indexWhere((it) => it.id == person.id);
            if (index < 0) {
              _peopleList.add(person);
            } else {
              _peopleList[index] = person;
            }
          },
        );
    _storage.watch().listen(listener);
  }
}
