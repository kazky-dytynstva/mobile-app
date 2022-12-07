import 'package:mobile_app/domain/value_objects/string_not_empty.dart';

abstract class ShareHelper {
  Future<void> text({
    required StringNonEmpty text,
  });
}
