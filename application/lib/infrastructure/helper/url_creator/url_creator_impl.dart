import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_id.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/value_objects/image_url.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/domain/value_objects/url_string.dart';
import 'package:mobile_app/infrastructure/env_config/env_config.dart';

import 'url_creator.dart';

const _anc0 = '%s0';
const _anc1 = '%s1';
const _anc2 = '%s2';

const _contentVersion = 2;
const _contentPath = 'kazky-dytynstva/content/';
const _prodBranch = 'main';
const _devBranch = 'dev';

@LazySingleton(as: UrlCreator)
class UrlCreatorImpl implements UrlCreator {
  @override
  String get baseUrl => 'https://raw.githubusercontent.com/';

  @override
  UrlString get urlPathPeopleList => UrlString('${_peoplePath}list.json');

  @override
  UrlString get urlPathTalesList => UrlString('${_talesPath}list.json');

  @override
  ImageUrl getTaleImageUrl(
    TaleId id, {
    required IntPositive chapterIndex,
    required IntPositive imageIndex,
  }) {
    final path = '$_talesPath$_anc0/$_anc1/img/$_anc2.jpg'
        .replaceFirst(_anc0, id.get().toString())
        .replaceFirst(_anc1, chapterIndex.get().toString())
        .replaceFirst(_anc2, imageIndex.get().toString());

    return ImageUrl(path);
  }

  @override
  UrlString getTaleAudioUrl(TaleId taleId, IntPositive chapterIndex) {
    final path = '$_talesPath$_anc0/$_anc1/audio.mp3'
        .replaceFirst(_anc0, taleId.get().toString())
        .replaceFirst(_anc1, chapterIndex.get().toString());

    return UrlString(path);
  }

  @override
  ImageUrl getPersonPhotoUrl(PersonId id) {
    final path = '${_peoplePath}img/$_anc0.jpg';
    return ImageUrl(path);
  }

  String get _dataPath =>
      '$baseUrl$_contentPath$_branch/data/$_contentVersion/';

  String get _branch => EnvConfig.isProd ? _prodBranch : _devBranch;

  String get _peoplePath => '${_dataPath}people/';

  String get _talesPath => '${_dataPath}tales/';
}
