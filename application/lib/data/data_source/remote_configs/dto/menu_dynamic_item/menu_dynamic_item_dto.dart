import 'package:json_annotation/json_annotation.dart';

part 'menu_dynamic_item_dto.g.dart';

@JsonSerializable(createToJson: false)
class MenuDynamicItemDto {
  final String title;
  final String? subTitle;
  final List<String>? points;
  final String cta;
  final String url;
  /// Seconds since epoch
  ///
  /// Take from https://www.unixtimestamp.com/
  final String id;

  MenuDynamicItemDto({
    required this.title,
    required this.subTitle,
    required this.points,
    required this.cta,
    required this.url,
    required this.id,
  });

  factory MenuDynamicItemDto.fromJson(Map<String, dynamic> json) =>
      _$MenuDynamicItemDtoFromJson(json);
}
