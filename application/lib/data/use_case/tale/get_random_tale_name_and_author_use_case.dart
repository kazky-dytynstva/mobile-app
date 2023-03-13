import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_id.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_name.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_name.dart';
import 'package:mobile_app/domain/repository/people_repository.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_storage.dart';

@Injectable(as: UseCase)
class GetRandomTaleNameAndAuthorUseCase
    extends UseCase<Dry, GetRandomTaleNameAndAuthorOutput> {
  final TaleStorage _storage;
  final PeopleRepository _peopleRepository;

  GetRandomTaleNameAndAuthorUseCase(
    this._storage,
    this._peopleRepository,
  );

  @override
  Stream<GetRandomTaleNameAndAuthorOutput> transaction(Dry input) async* {
    final taleWithAuthor = (await _storage.getAll())
        .where((element) => element.crew?.authors?.isNotEmpty == true)
        .toList();
    taleWithAuthor.shuffle();
    final tale = taleWithAuthor.first;
    final authorId = tale.crew!.authors!.first;

    final taleName = TaleName(tale.name);
    final authorName =
        (_peopleRepository.find(PersonId(authorId)) as Some<Person>).value.name;

    yield GetRandomTaleNameAndAuthorOutput(taleName, authorName);
  }
}

@immutable
class GetRandomTaleNameAndAuthorOutput {
  final TaleName taleName;
  final PersonName authorName;

  const GetRandomTaleNameAndAuthorOutput(
    this.taleName,
    this.authorName,
  );
}
