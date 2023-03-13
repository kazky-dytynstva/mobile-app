import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/data_source/storage_local/people_storage.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_id.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/data/data_source/storage_local/people/entity/person_entity.dart';

@Injectable(as: UseCase)
class GetPersonUseCase extends UseCase<PersonId, GetPersonOutput> {
  final PeopleStorage _storage;
  final Mapper<PersonEntity, Person> _mapper;

  GetPersonUseCase(
    this._storage,
    this._mapper,
  );

  @override
  Stream<GetPersonOutput> transaction(PersonId input) async* {
    final entity = await _storage.find(input);
    final tale = _mapper.map(entity!);
    yield GetPersonOutput(tale);
  }
}

@immutable
class GetPersonOutput {
  final Person person;

  const GetPersonOutput(this.person);
}
