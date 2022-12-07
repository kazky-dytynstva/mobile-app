import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/domain/exception/person_not_found_exception.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_id.dart';

void main() {
  const id = 7;
  final personId = PersonId(id);
  final exception = PersonNotFoundException(personId);
  test(
    'GIVEN exception THEN verify it is equatable',
    () async {
      // ASSERT
      expect(exception, isA<Equatable>());
      expect(exception.props, [personId]);
    },
  );
  test(
    'GIVEN exception THEN verify toString is correct',
    () async {
      // ASSERT
      expect(
        exception.toString(),
        'Person (with id=${personId.get()}) not found',
      );
    },
  );
}
