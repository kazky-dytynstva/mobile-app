import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_app/domain/value_objects/image_url.dart';
import 'package:mobile_app/domain/value_objects/string_not_empty.dart';

part 'tale_text_item.freezed.dart';

@Freezed(
  map: FreezedMapOptions(maybeMap: false),
  when: FreezedWhenOptions(maybeWhen: false),
)
abstract class TaleTextItem with _$TaleTextItem {
  const factory TaleTextItem.text(StringNonEmpty text) = _TaleTextParagraph;

  const factory TaleTextItem.image(ImageUrl url) = _TaleTextImage;
}
