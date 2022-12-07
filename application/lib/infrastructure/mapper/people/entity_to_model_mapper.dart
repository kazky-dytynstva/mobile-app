import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_id.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_name.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/domain/value_objects/url_string.dart';
import 'package:mobile_app/infrastructure/data_source/storage_local/people/entity/person_entity.dart';
import 'package:mobile_app/infrastructure/helper/url_creator/url_creator.dart';

@LazySingleton(as: Mapper)
class PersonEntityToModelMapper implements Mapper<PersonEntity, Person> {
  final UrlCreator _urlCreator;

  PersonEntityToModelMapper(
    this._urlCreator,
  );

  @override
  Person map(PersonEntity input) {
    final id = PersonId(input.id);
    final name = PersonName(input.name);

    final photoUrl = _urlCreator.getPersonPhotoUrl(id);

    final Option<UrlString> pageOption =
        (input.url == null) ? const None() : Some(UrlString(input.url!));

    final Option<StringSingleLine> infoOption = (input.info == null)
        ? const None()
        : Some(StringSingleLine(input.info!));

    return Person(
      id,
      name,
      photoUrl,
      pageOption,
      infoOption,
      input.isFavorite ?? false,
    );
  }
}
