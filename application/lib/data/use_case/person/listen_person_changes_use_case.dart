import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/data_source/storage_local/people_storage.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/changed_data/changed_data.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_id.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/data/data_source/storage_local/people/entity/person_entity.dart';

@Injectable(as: UseCase)
class ListenPersonChangesUseCase
    extends UseCase<ListenPersonChangesInput, ChangedData<Person, PersonId>> {
  final PeopleStorage _storage;
  final Mapper<PersonEntity, Person> _mapper;

  ListenPersonChangesUseCase(
    this._storage,
    this._mapper,
  );

  @override
  Stream<ChangedData<Person, PersonId>> transaction(
    ListenPersonChangesInput input,
  ) async* {
    final transformer = StreamTransformer.fromHandlers(
      handleData: (ChangedData<PersonEntity, PersonId> data,
              EventSink<ChangedData<Person, PersonId>> sink) =>
          data.map(
        deleted: (PersonId id) {
          sink.add(ChangedData.deleted(id));
        },
        updated: (PersonEntity entity) {
          sink.add(ChangedData.updated(_mapper.map(entity)));
        },
      ),
    );
    yield* _storage.watch(personId: input.personId).transform(transformer);
  }
}

@immutable
class ListenPersonChangesInput {
  final PersonId personId;

  const ListenPersonChangesInput(this.personId);
}
