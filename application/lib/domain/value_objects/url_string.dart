import 'utils/value_object.dart';
import 'utils/value_validators.dart';

class UrlString extends ValueObject<String> {
  factory UrlString(String input) {
    final singleLineEither = validateStringSingleLine(input);
    return singleLineEither.isLeft()
        ? UrlString._(singleLineEither)
        : UrlString._(validateStringNotEmpty(input));
  }

  const UrlString._(super.value);

  Uri get asUri => Uri.parse(get());

  UrlString operator +(dynamic other) {
    if (other is String) {
      return UrlString(get() + other);
    } else if (other is UrlString) {
      return UrlString(get() + other.get());
    } else {
      throw UnsupportedError('Can not execute operation');
    }
  }
}
