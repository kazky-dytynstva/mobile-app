import 'utils/value_object.dart';
import 'utils/value_validators.dart';

class SvgString extends ValueObject<String> {
  factory SvgString(String input) => SvgString._(validateStringNotEmpty(input));

  const SvgString._(super.value);
}
