import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_app/domain/value_objects/utils/value_failure.dart';
import 'package:mobile_app/domain/value_objects/utils/value_object.dart';
import 'package:mobile_app/domain/extensions/string.dart';

@immutable
class TaleName extends ValueObject<String> {
  factory TaleName(String input) => TaleName._(_validate(input));

  const TaleName._(super.value);
}

Either<ValueFailure<String>, String> _validate(String input) => (input.isEmpty)
    ? left(ValueFailure.empty(failedValue: input))
    : (input.length < 2)
        ? left(ValueFailure.deficiencyLength(failedValue: input, min: 2))
        : (input.isMultiLine)
            ? left(ValueFailure.multilineString(failedValue: input))
            : right(input);
