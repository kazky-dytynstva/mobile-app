import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_name.dart';
import 'package:mobile_app/domain/value_objects/utils/value_failure.dart';
import 'package:mobile_app/domain/value_objects/utils/value_object.dart';

const _minLength = 4;

void main() {
  String getName(int length) {
    final buffer = StringBuffer();
    for (int i = 0; i < length; i++) {
      buffer.write('a');
    }
    return buffer.toString();
  }

  test(
    'GIVEN value with 0 length THEN throw UnexpectedValueError with ValueFailureEmptyString',
    () async {
      // ARRANGE
      final name = getName(0);
      final person = PersonName(name);

      // ASSERT
      expect(
        () => person.get(),
        throwsA(isA<UnexpectedValueError>()),
      );
      try {
        person.get();
      } on UnexpectedValueError catch (e) {
        expect(e.valueFailure, isA<ValueFailureEmptyString>());
      }
    },
  );
  test(
    'GIVEN value with less then min length THEN throw UnexpectedValueError with ValueFailureDeficiencyLength',
    () async {
      // ARRANGE
      final name = getName(_minLength - 1);
      final person = PersonName(name);

      // ASSERT
      expect(
        () => person.get(),
        throwsA(isA<UnexpectedValueError>()),
      );
      try {
        person.get();
      } on UnexpectedValueError catch (e) {
        expect(e.valueFailure, isA<ValueFailureDeficiencyLength>());
      }
    },
  );
  test(
    'GIVEN value multiline symbol THEN throw UnexpectedValueError with ValueFailureMultilineString',
    () async {
      // ARRANGE
      final name = '${getName(_minLength)}\n';
      final person = PersonName(name);

      // ASSERT
      expect(
        () => person.get(),
        throwsA(isA<UnexpectedValueError>()),
      );
      try {
        person.get();
      } on UnexpectedValueError catch (e) {
        expect(e.valueFailure, isA<ValueFailureMultilineString>());
      }
    },
  );
  test(
    'GIVEN value with min length THEN no exception are thrown',
    () async {
      // ARRANGE
      final name = getName(_minLength);
      final person = PersonName(name);

      // ASSERT
      expect(person.get(), equals(name));
    },
  );
}
