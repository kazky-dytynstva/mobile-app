import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/data_source/storage_local/people_storage.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/infrastructure/data_source/storage_local/people/entity/person_entity.dart';

@Injectable(as: UseCase)
class GetAllFavPeopleUseCase extends UseCase<Dry, GetAllFavPeopleOutput> {
  final PeopleStorage _peopleStorage;
  final Mapper<PersonEntity, Person> _mapper;

  GetAllFavPeopleUseCase(
    this._peopleStorage,
    this._mapper,
  );

  @override
  Stream<GetAllFavPeopleOutput> transaction(Dry input) async* {
    final entities = await _getPersonEntities();
    final people = entities.map(_mapper.map).toList();
    yield GetAllFavPeopleOutput(people);
  }

  Future<List<PersonEntity>> _getPersonEntities() async {
    final all = await _peopleStorage.getPeople();
    return all.where((element) => element.isFavorite == true).toList();
  }
}

@immutable
class GetAllFavPeopleOutput {
  final List<Person> people;

  const GetAllFavPeopleOutput(this.people);
}
