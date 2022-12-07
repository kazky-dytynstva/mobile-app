import 'package:dartz/dartz.dart';

import 'utils/value_failure.dart';
import 'utils/value_object.dart';
import 'utils/value_validators.dart';

class AssetFilePath extends ValueObject<String> {
  factory AssetFilePath(String input) {
    assert(input.startsWith("assets/"));
    final singleLineEither = validateStringSingleLine(input);
    if (singleLineEither.isLeft()) {
      return AssetFilePath._(singleLineEither);
    }
    return AssetFilePath._(validateStringNotEmpty(input));
  }

  const AssetFilePath._(Either<ValueFailure<String>, String> value)
      : super(value);
}
