import 'package:meta/meta.dart';
import 'package:mobile_app/domain/value_objects/utils/value_object.dart';
import 'package:mobile_app/domain/value_objects/utils/value_validators.dart';

@immutable
class MenuDynamicItemId extends ValueObject<String> {
  factory MenuDynamicItemId(String input) =>
      MenuDynamicItemId._(validateStringNotEmpty(input));

  const MenuDynamicItemId._(super.value);
}
