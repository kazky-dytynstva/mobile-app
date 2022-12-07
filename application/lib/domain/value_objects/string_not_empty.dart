import 'package:dartz/dartz.dart';

import 'utils/value_failure.dart';
import 'utils/value_object.dart';
import 'utils/value_validators.dart';

class StringNonEmpty extends ValueObject<String> {
  factory StringNonEmpty(String input) =>
      StringNonEmpty._(validateStringNotEmpty(input));

  const StringNonEmpty._(Either<ValueFailure<String>, String> value)
      : super(value);
}
