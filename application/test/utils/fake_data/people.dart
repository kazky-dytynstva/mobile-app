import 'package:dartz/dartz.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_id.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_name.dart';
import 'package:mobile_app/domain/value_objects/image_url.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/domain/value_objects/url_string.dart';

Person getPerson({
  int? id,
  String? name,
  String? imageUrl,
  String? pageUrl,
  String? info,
  bool? isFavorite,
}) =>
    Person(
      PersonId(id ?? 0),
      PersonName(name ?? 'name$id'),
      ImageUrl(imageUrl ?? 'imageUrl'),
      pageUrl == null ? const None() : Some(UrlString(pageUrl)),
      info == null ? const None() : Some(StringSingleLine(info)),
      isFavorite ?? false,
    );
