import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_id.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/domain/value_objects/url_string.dart';
import 'package:mobile_app/infrastructure/helper/url_creator/url_creator.dart';
import 'package:mobile_app/infrastructure/helper/url_creator/url_creator_impl.dart';

const _baseUrl = 'https://raw.githubusercontent.com/';
const _contentVersion = 2;
const _contentPath = 'kazky-dytynstva/content';
const _prodBranch = 'main';
const _devBranch = 'dev';

void main() {
  late UrlCreator devCreator;
  late UrlCreator prodCreator;

  // helpers below
  String getBranch(bool isProd) => isProd ? _prodBranch : _devBranch;

  String getDataPath(bool isProd) => '$_baseUrl'
      '$_contentPath/'
      '${getBranch(isProd)}/'
      'data/'
      '$_contentVersion';

  String getPeoplePath(bool isProd) => '${getDataPath(isProd)}/people';

  String getTalesPath(bool isProd) => '${getDataPath(isProd)}/tales';

  setUp(() {
    devCreator = UrlCreatorImpl.test(isProd: false);
    prodCreator = UrlCreatorImpl.test(isProd: true);
  });

  group('private params test', () {
    late UrlCreatorImpl dev;
    late UrlCreatorImpl prod;

    setUp(() {
      dev = UrlCreatorImpl.test(isProd: false);
      prod = UrlCreatorImpl.test(isProd: true);
    });
    test('VERIFY isProd is correct', () {
      final defTrue = UrlCreatorImpl(isProd: true);
      final defFalse = UrlCreatorImpl(isProd: false);

      expect(dev.isProd, isFalse);
      expect(prod.isProd, isTrue);
      expect(defTrue.isProd, isTrue);
      expect(defFalse.isProd, isFalse);
    });

    test('VERIFY branch is correct', () {
      expect(dev.branch, equals(_devBranch));
      expect(prod.branch, equals(_prodBranch));
      expect((devCreator as UrlCreatorImpl).branch, equals(_devBranch));
      expect((prodCreator as UrlCreatorImpl).branch, equals(_prodBranch));
    });

    test('VERIFY dataPath is correct', () {
      expect(dev.dataPath, equals(getDataPath(dev.isProd)));
      expect(prod.dataPath, equals(getDataPath(prod.isProd)));
    });

    test('VERIFY peoplePath is correct', () {
      expect(dev.peoplePath, equals(getPeoplePath(dev.isProd)));
      expect(prod.peoplePath, equals(getPeoplePath(prod.isProd)));
    });

    test('VERIFY getTalesPath is correct', () {
      expect(dev.talesPath, equals(getTalesPath(dev.isProd)));
      expect(prod.talesPath, equals(getTalesPath(prod.isProd)));
    });
  });

  group('UrlCreator test', () {
    test('VERIFY baseUrl is correct', () {
      expect(devCreator.baseUrl, equals(_baseUrl));
      expect(prodCreator.baseUrl, equals(_baseUrl));
    });

    test('VERIFY urlPathPeopleList is correct', () {
      expect(
        devCreator.urlPathPeopleList,
        equals(UrlString('${getPeoplePath(false)}/list.json')),
      );
      expect(
        prodCreator.urlPathPeopleList,
        equals(UrlString('${getPeoplePath(true)}/list.json')),
      );
    });

    test('VERIFY urlPathTalesList is correct', () {
      expect(
        devCreator.urlPathTalesList,
        equals(UrlString('${getTalesPath(false)}/list.json')),
      );
      expect(
        prodCreator.urlPathTalesList,
        equals(UrlString('${getTalesPath(true)}/list.json')),
      );
    });

    test('VERIFY getTaleImageUrl is correct', () {
      final taleId = TaleId(888);
      final chapterIndex = IntPositive(777);
      final imageIndex = IntPositive(666);

      final givenDevUrl = devCreator.getTaleImageUrl(
        taleId,
        chapterIndex: chapterIndex,
        imageIndex: imageIndex,
      );
      final givenProdUrl = prodCreator.getTaleImageUrl(
        taleId,
        chapterIndex: chapterIndex,
        imageIndex: imageIndex,
      );

      String expectedUrl(bool isProd) => '${getTalesPath(isProd)}/'
          '${taleId.get().toString()}/'
          '${chapterIndex.get().toString()}/'
          'img/'
          '${imageIndex.get().toString()}.jpg';

      expect(givenDevUrl, equals(UrlString(expectedUrl(false))));
      expect(givenProdUrl, equals(UrlString(expectedUrl(true))));
    });

    test('VERIFY getTaleAudioUrl is correct', () {
      final taleId = TaleId(888);
      final chapterIndex = IntPositive(777);

      final givenDevUrl = devCreator.getTaleAudioUrl(taleId, chapterIndex);
      final givenProdUrl = prodCreator.getTaleAudioUrl(taleId, chapterIndex);

      String expectedUrl(bool isProd) => '${getTalesPath(isProd)}/'
          '${taleId.get().toString()}/'
          '${chapterIndex.get().toString()}/'
          'audio.mp3';

      expect(givenDevUrl, equals(UrlString(expectedUrl(false))));
      expect(givenProdUrl, equals(UrlString(expectedUrl(true))));
    });

    test('VERIFY getPersonPhotoUrl is correct', () {
      final personId = PersonId(333);

      final givenDevUrl = devCreator.getPersonPhotoUrl(personId);
      final givenProdUrl = prodCreator.getPersonPhotoUrl(personId);

      String expectedUrl(bool isProd) => '${getPeoplePath(isProd)}/'
          'img/'
          '${personId.get().toString()}.jpg';

      expect(givenDevUrl, equals(UrlString(expectedUrl(false))));
      expect(givenProdUrl, equals(UrlString(expectedUrl(true))));
    });
  });
}
