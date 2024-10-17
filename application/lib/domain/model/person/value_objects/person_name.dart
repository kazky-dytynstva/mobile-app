import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:mobile_app/domain/value_objects/utils/value_failure.dart';
import 'package:mobile_app/domain/value_objects/utils/value_object.dart';
import 'package:mobile_app/domain/extensions/string.dart';

const _minNameLength = 4;

@immutable
class PersonName extends ValueObject<String> {
  factory PersonName(String input) => PersonName._(_validate(input));

  const PersonName._(super.value);
}

Either<ValueFailure<String>, String> _validate(
  String input,
) {
  if (input.isEmpty) {
    return left(ValueFailure.empty(failedValue: input));
  }
  if (input.length < _minNameLength) {
    return left(
      ValueFailure.deficiencyLength(failedValue: input, min: _minNameLength),
    );
  }
  if (input.isMultiLine) {
    return left(ValueFailure.multilineString(failedValue: input));
  }
  return right(input);
}
