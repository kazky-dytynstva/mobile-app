import 'utils/value_object.dart';
import 'utils/value_validators.dart';

class StringNonEmpty extends ValueObject<String> {
  factory StringNonEmpty(String input) =>
      StringNonEmpty._(validateStringNotEmpty(input));

  const StringNonEmpty._(super.value);
}
