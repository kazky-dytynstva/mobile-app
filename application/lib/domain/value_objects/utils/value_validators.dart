import 'package:dartz/dartz.dart';
import 'package:mobile_app/domain/extensions/string.dart';

import 'value_failure.dart';

Either<ValueFailure<String>, String> validateMaxStringLength(
  String input,
  int maxLength,
) {
  if (input.length <= maxLength) {
    return right(input);
  } else {
    return left(ValueFailure.exceedingLength(
      failedValue: input,
      max: maxLength,
    ));
  }
}

Either<ValueFailure<String>, String> validateMinStringLength(
  String input,
  int minLength,
) {
  if (input.length >= minLength) {
    return right(input);
  } else {
    return left(ValueFailure.deficiencyLength(
      failedValue: input,
      min: minLength,
    ));
  }
}

Either<ValueFailure<String>, String> validateStringNotEmpty(String input) {
  if (input.isEmpty) {
    return left(ValueFailure.empty(failedValue: input));
  } else {
    return right(input);
  }
}

Either<ValueFailure<String>, String> validateStringSingleLine(String input) {
  if (input.isMultiLine) {
    return left(ValueFailure.multilineString(failedValue: input));
  } else {
    return right(input);
  }
}

Either<ValueFailure<Uri>, Uri> validateUrl(String input) {
  if (input.isEmpty) {
    return left(ValueFailure.empty(failedValue: input));
  } else if (input.isMultiLine) {
    return left(ValueFailure.multilineString(failedValue: input));
  } else {
    return right(Uri.parse(input));
  }
}

Either<ValueFailure<int>, int> validateIntPositive(int input) {
  if (input < 0) {
    return left(ValueFailure.numberTooSmall(failedValue: input, min: 0));
  } else {
    return right(input);
  }
}

Either<ValueFailure<int>, int> validateIntRange(
  int input, {
  required int min,
  required int max,
}) {
  if (input < min) {
    return left(ValueFailure.numberTooSmall(failedValue: input, min: min));
  } else {
    if (input > max) {
      return left(ValueFailure.numberTooLarge(failedValue: input, max: max));
    } else {
      return right(input);
    }
  }
}

Either<ValueFailure<double>, double> validateDoublePositive(double input) {
  if (input < 0) {
    return left(ValueFailure.numberTooSmall(failedValue: input, min: 0));
  } else {
    return right(input);
  }
}

Either<ValueFailure<double>, double> validateDoubleRange(
  double input, {
  required double min,
  required double max,
}) {
  if (input < min) {
    return left(ValueFailure.numberTooSmall(failedValue: input, min: min));
  } else {
    if (input > max) {
      return left(ValueFailure.numberTooLarge(failedValue: input, max: max));
    } else {
      return right(input);
    }
  }
}
