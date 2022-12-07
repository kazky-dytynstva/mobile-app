import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_app/domain/value_objects/utils/value_failure.dart';
import 'package:mobile_app/domain/value_objects/utils/value_object.dart';
import 'package:mobile_app/domain/value_objects/utils/value_validators.dart';

@immutable
class PersonId extends ValueObject<int> {
  factory PersonId(int input) {
    return PersonId._(validateIntPositive(input));
  }

  const PersonId._(Either<ValueFailure<int>, int> value) : super(value);
}
