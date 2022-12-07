import 'package:dartz/dartz.dart';

import 'utils/value_failure.dart';
import 'utils/value_object.dart';
import 'utils/value_validators.dart';

class ImageUrl extends ValueObject<String> {
  factory ImageUrl(String input) {
    final singleLineEither = validateStringSingleLine(input);
    return singleLineEither.isLeft()
        ? ImageUrl._(singleLineEither)
        : ImageUrl._(validateStringNotEmpty(input));
  }

  const ImageUrl._(Either<ValueFailure<String>, String> value) : super(value);

  Uri get asUri => Uri.parse(get());
}
