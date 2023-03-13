import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_id.dart';
import 'package:mobile_app/domain/model/tale_crew/tale_crew.dart';
import 'package:mobile_app/domain/repository/people_repository.dart';
import 'package:mobile_app/data/data_source/storage_local/tale/entity/crew/crew_entity.dart';

@LazySingleton(as: Mapper)
class TaleCrewEntityToTaleCrew implements Mapper<TaleCrewEntity?, TaleCrew?> {
  final PeopleRepository _repository;

  TaleCrewEntityToTaleCrew(this._repository);

  @override
  TaleCrew? map(TaleCrewEntity? input) {
    if (input == null) return null;

    if (_isNullOrEmpty(input.authors) &&
        _isNullOrEmpty(input.readers) &&
        _isNullOrEmpty(input.translators) &&
        _isNullOrEmpty(input.musicians) &&
        _isNullOrEmpty(input.graphics)) {
      return null;
    }

    return TaleCrew(
      authors: _mapList(input.authors),
      readers: _mapList(input.readers),
      translators: _mapList(input.translators),
      musicians: _mapList(input.musicians),
      graphics: _mapList(input.graphics),
    );
  }

  bool _isNullOrEmpty(List<int>? list) => list == null || list.isEmpty;

  List<Person> _mapList(List<int>? humanIdList) {
    if (_isNullOrEmpty(humanIdList)) {
      return const [];
    }
    final list = <Person>[];

    for (final humanId in humanIdList!) {
      _repository.find(PersonId(humanId)).fold(
            () => null,
            (a) => list.add(a),
          );
    }

    return list;
  }
}
