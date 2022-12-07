import 'package:dartz/dartz.dart';

import 'utils/value_failure.dart';
import 'utils/value_object.dart';
import 'utils/value_validators.dart';

class FilePath extends ValueObject<String> {
  factory FilePath(String input) {
    final singleLineEither = validateStringSingleLine(input);
    return singleLineEither.isLeft()
        ? FilePath._(singleLineEither)
        : FilePath._(validateStringNotEmpty(input));
  }

  const FilePath._(Either<ValueFailure<String>, String> value) : super(value);

  Uri get asUri => Uri.parse(get());
}
