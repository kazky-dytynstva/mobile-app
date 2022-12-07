import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:mobile_app/domain/data_source/storage_local/people_storage.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/changed_data/changed_data.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_id.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/infrastructure/data_source/storage_local/people/entity/person_entity.dart';

@Injectable(as: UseCase)
class ListenPeopleChangesUseCase
    extends UseCase<Dry, ListenPeopleChangesOutput> {
  final PeopleStorage _storage;
  final Mapper<PersonEntity, Person> _mapper;

  ListenPeopleChangesUseCase(
    this._storage,
    this._mapper,
  );

  @override
  Stream<ListenPeopleChangesOutput> transaction(Dry input) async* {
    final transformer = StreamTransformer.fromHandlers(handleData: (
      ChangedData<PersonEntity, PersonId> data,
      EventSink<ListenPeopleChangesOutput> sink,
    ) {
      final ChangedData<Person, PersonId> outcomeData = data.map(
        deleted: (id) => ChangedData.deleted(id),
        updated: (entity) => ChangedData.updated(_mapper.map(entity)),
      );
      sink.add(ListenPeopleChangesOutput(outcomeData));
    });
    yield* _storage.watch().transform(transformer);
  }
}

@immutable
class ListenPeopleChangesOutput {
  final ChangedData<Person, PersonId> data;

  const ListenPeopleChangesOutput(this.data);
}
