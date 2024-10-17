import 'utils/value_object.dart';
import 'utils/value_validators.dart';

class FilePath extends ValueObject<String> {
  factory FilePath(String input) {
    final singleLineEither = validateStringSingleLine(input);
    return singleLineEither.isLeft()
        ? FilePath._(singleLineEither)
        : FilePath._(validateStringNotEmpty(input));
  }

  const FilePath._(super.value);

  Uri get asUri => Uri.parse(get());
}
