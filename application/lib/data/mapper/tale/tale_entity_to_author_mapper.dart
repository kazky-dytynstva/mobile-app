import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_id.dart';
import 'package:mobile_app/domain/repository/people_repository.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/data/data_source/storage_local/tale/entity/tale_entity.dart';
import 'package:mobile_app/presentation/resource/r.dart';

@Singleton(as: Mapper)
class TaleEntityToAuthorMapper implements Mapper<TaleEntity, StringSingleLine> {
  final PeopleRepository _peopleRepository;

  TaleEntityToAuthorMapper(
    this._peopleRepository,
  );

  @override
  StringSingleLine map(TaleEntity input) {
    final authorIds = input.crew?.authors;
    if (authorIds == null || authorIds.isEmpty) {
      return StringSingleLine(R.strings.general.authorNation);
    } else {
      final names = authorIds
          .map((id) => _peopleRepository.find(PersonId(id)).fold(
                () => null,
                (a) => a.name.get(),
              ))
          .where((element) => element != null);
      return StringSingleLine(names.join(", "));
    }
  }
}
