import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_id.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_name.dart';
import 'package:mobile_app/domain/value_objects/image_url.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/domain/value_objects/url_string.dart';

@immutable
class Person extends Equatable {
  final PersonId id;
  final PersonName name;
  final ImageUrl photoUrl;
  final Option<UrlString> pageOption;
  final Option<StringSingleLine> infoOption;
  final bool isFavorite;

  const Person(
    this.id,
    this.name,
    this.photoUrl,
    this.pageOption,
    this.infoOption,
    this.isFavorite,
  );

  @override
  List<Object> get props => [
        id,
        name,
        photoUrl,
        pageOption,
        infoOption,
        isFavorite,
      ];
}
