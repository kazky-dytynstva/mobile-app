import 'package:dartz/dartz.dart';

import 'package:mobile_app/domain/value_objects/utils/value_failure.dart';

import 'utils/value_object.dart';
import 'utils/value_validators.dart';

class SvgString extends ValueObject<String> {
  factory SvgString(String input) => SvgString._(validateStringNotEmpty(input));

  const SvgString._(Either<ValueFailure<String>, String> value) : super(value);
}
