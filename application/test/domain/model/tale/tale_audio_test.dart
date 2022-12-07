import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/domain/value_objects/file_path.dart';
import 'package:mobile_app/domain/value_objects/image_url.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/domain/value_objects/url_string.dart';

import '../../../utils/utils.dart';

void main() {
  final chapterIndex = IntPositive(888);
  const duration = Duration(days: 3, hours: 5, minutes: 1);
  final urlString = UrlString('my_custom_url');
  final images = [
    ImageUrl('my_custom_image_url_0'),
    ImageUrl('my_custom_image_url_1'),
    ImageUrl('my_custom_image_url_2'),
  ];
  final filePath = FilePath('my_custom_path');
  final audioLocal = getTaleAudio(
    chapterIndex: chapterIndex,
    duration: duration,
    urlString: urlString,
    filePath: filePath,
    images: images,
    isCachedFuture: Future.value(true),
  );
  final audioRemote = getTaleAudio(
    chapterIndex: chapterIndex,
    duration: duration,
    urlString: urlString,
    filePath: filePath,
    images: images,
    isCachedFuture: Future.value(false),
  );

  test("GIVEN instance THEN verify it is Equatable", () {
    expect(audioLocal, isA<Equatable>());
  });

  test("GIVEN instance THEN verify equatable props are correct set", () {
    final propsLocal = [
      chapterIndex,
      duration,
      urlString,
      filePath,
      images,
      true,
    ];
    final propsRemote = [
      chapterIndex,
      duration,
      urlString,
      filePath,
      images,
      false,
    ];
    expect(audioLocal.props, equals(propsLocal));
    expect(audioRemote.props, equals(propsRemote));
  });

  test("GIVEN 2 different instances with same params THEN treat them as equal",
      () {
    // ARRANGE
    final a = getTaleAudio(
      chapterIndex: chapterIndex,
      duration: duration,
      urlString: urlString,
      filePath: filePath,
      images: images,
      isCachedFuture: Future.value(false),
    );
    final b = getTaleAudio(
      chapterIndex: chapterIndex,
      duration: duration,
      urlString: urlString,
      filePath: filePath,
      images: images,
      isCachedFuture: Future.value(false),
    );

    // ASSERT
    expect(a, equals(b));
  });
}
