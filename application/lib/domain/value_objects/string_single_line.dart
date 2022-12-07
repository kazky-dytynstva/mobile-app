import 'package:dartz/dartz.dart';

import 'utils/value_failure.dart';
import 'utils/value_object.dart';
import 'utils/value_validators.dart';

class StringSingleLine extends ValueObject<String> {
  factory StringSingleLine(String input) {
    final singleLineEither = validateStringSingleLine(input);
    return singleLineEither.isLeft()
        ? StringSingleLine._(singleLineEither)
        : StringSingleLine._(validateStringNotEmpty(input));
  }

  const StringSingleLine._(Either<ValueFailure<String>, String> value)
      : super(value);

  StringSingleLine operator +(dynamic other) {
    if (other is String) {
      return StringSingleLine(get() + other);
    } else if (other is StringSingleLine) {
      return StringSingleLine(get() + other.get());
    } else {
      throw UnsupportedError('Can not execute operation');
    }
  }
}
