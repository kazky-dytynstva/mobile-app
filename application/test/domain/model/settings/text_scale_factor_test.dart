import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/domain/model/settings/text_scale_factor.dart';

void main() {
  test('GIVEN enum list THEN verify it has 4 items', () {
    expect(TextScaleFactor.values.length, equals(4));
  });
  test('GIVEN enum list THEN verify size list is correct', () {
    expect(
      TextScaleFactor.values.map((e) => e.size),
      equals([0.7, 1.0, 1.5, 2.0]),
    );
  });
}
