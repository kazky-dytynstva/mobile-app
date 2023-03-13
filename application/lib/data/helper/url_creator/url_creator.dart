import 'package:mobile_app/domain/model/person/value_objects/person_id.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/value_objects/image_url.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/domain/value_objects/url_string.dart';

abstract class UrlCreator {
  String get baseUrl;

  UrlString get urlPathPeopleList;

  UrlString get urlPathTalesList;

  ImageUrl getTaleImageUrl(
    TaleId id, {
    required IntPositive chapterIndex,
    required IntPositive imageIndex,
  });

  UrlString getTaleAudioUrl(TaleId id, IntPositive chapterIndex);

  ImageUrl getPersonPhotoUrl(PersonId id);
}
