import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:mobile_app/domain/value_objects/utils/value_failure.dart';
import 'package:mobile_app/domain/value_objects/utils/value_object.dart';

@immutable
class TaleId extends ValueObject<int> {
  factory TaleId(int input) => TaleId._(_validate(input));

  const TaleId._(Either<ValueFailure<int>, int> value) : super(value);
}

Either<ValueFailure<int>, int> _validate(int input) => (input < 0)
    ? left(ValueFailure.numberTooSmall(min: 0, failedValue: input))
    : right(input);
