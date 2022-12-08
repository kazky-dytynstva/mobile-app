import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_id.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/value_objects/image_url.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/domain/value_objects/url_string.dart';
import 'package:mobile_app/infrastructure/env_config/env_config.dart';

import 'url_creator.dart';

const _contentVersion = 2;
const _contentPath = 'kazky-dytynstva/content';
const _prodBranch = 'main';
const _devBranch = 'dev';

@LazySingleton(as: UrlCreator)
class UrlCreatorImpl implements UrlCreator {
  UrlCreatorImpl() : isProd = EnvConfig.isProd;

  @visibleForTesting
  UrlCreatorImpl.test({required this.isProd});

  @visibleForTesting
  final bool isProd;

  @override
  String get baseUrl => 'https://raw.githubusercontent.com/';

  @override
  UrlString get urlPathPeopleList => UrlString('$peoplePath/list.json');

  @override
  UrlString get urlPathTalesList => UrlString('$talesPath/list.json');

  @override
  ImageUrl getTaleImageUrl(
    TaleId id, {
    required IntPositive chapterIndex,
    required IntPositive imageIndex,
  }) {
    final path = '$talesPath/'
        '${id.get().toString()}/'
        '${chapterIndex.get().toString()}/'
        'img/'
        '${imageIndex.get().toString()}.jpg';

    return ImageUrl(path);
  }

  @override
  UrlString getTaleAudioUrl(TaleId taleId, IntPositive chapterIndex) {
    final path = '$talesPath/'
        '${taleId.get().toString()}/'
        '${chapterIndex.get().toString()}/'
        'audio.mp3';

    return UrlString(path);
  }

  @override
  ImageUrl getPersonPhotoUrl(PersonId id) {
    final path = '$peoplePath/'
        'img/'
        '${id.get().toString()}.jpg';
    return ImageUrl(path);
  }

  @visibleForTesting
  String get branch => isProd ? _prodBranch : _devBranch;

  @visibleForTesting
  String get dataPath => '$baseUrl'
      '$_contentPath/'
      '$branch/'
      'data/'
      '$_contentVersion';

  @visibleForTesting
  String get peoplePath => '$dataPath/people';

  @visibleForTesting
  String get talesPath => '$dataPath/tales';
}
