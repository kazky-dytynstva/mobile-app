import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_id.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_name.dart';
import 'package:mobile_app/domain/value_objects/image_url.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/domain/value_objects/url_string.dart';

void main() {
  const defaultId = 7;
  const defaultName = 'Name';
  const defaultImageUrl = 'imageUrl';
  const defaultPageUrl = 'pageUrl';
  const defaultInfo = 'info';
  const defaultIsFavorite = false;
  Person create({
    int? id,
    String? name,
    String? imageUrl,
    String? pageUrl = defaultPageUrl,
    String? info = defaultInfo,
    bool? isFavorite = defaultIsFavorite,
  }) =>
      Person(
        PersonId(id ?? defaultId),
        PersonName(name ?? defaultName),
        ImageUrl(imageUrl ?? defaultImageUrl),
        pageUrl == null ? const None() : Some(UrlString(pageUrl)),
        info == null ? const None() : Some(StringSingleLine(info)),
        isFavorite ?? defaultIsFavorite,
      );
  test(
    'GIVEN person object THEN verify it is equatable instance',
    () async {
      // ARRANGE
      final person = create();
      final expectedProps = [
        person.id,
        person.name,
        person.photoUrl,
        person.pageOption,
        person.infoOption,
        person.isFavorite,
      ];

      // ASSERT
      expect(person, isA<Equatable>());
      expect(person.props, equals(expectedProps));
    },
  );
  test(
    'GIVEN person with custom params THEN params set correctly',
    () async {
      // ARRANGE
      const customId = 33;
      const customName = 'MyName';
      const customImageUrl = 'MyImageUrl';
      const customPageUrl = 'MyPageUrl';
      const customInfo = 'MyInfo';
      const customFav = !defaultIsFavorite;
      final person = create(
        id: customId,
        name: customName,
        imageUrl: customImageUrl,
        pageUrl: customPageUrl,
        info: customInfo,
        isFavorite: customFav,
      );

      // ASSERT
      expect(person.id, equals(PersonId(customId)));
      expect(person.name, equals(PersonName(customName)));
      expect(person.photoUrl, equals(ImageUrl(customImageUrl)));
      expect(person.pageOption, equals(Some(UrlString(customPageUrl))));
      expect(person.infoOption, equals(Some(StringSingleLine(customInfo))));
      expect(person.isFavorite, equals(customFav));
    },
  );
  test(
    'GIVEN person nullable pageUrl and info params THEN params set to None',
    () async {
      // ARRANGE
      final person = create(
        pageUrl: null,
        info: null,
      );

      // ASSERT
      expect(person.pageOption, equals(const None()));
      expect(person.infoOption, equals(const None()));
    },
  );
}
