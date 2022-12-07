import 'package:json_annotation/json_annotation.dart';

part 'menu_dynamic_item_dto.g.dart';

@JsonSerializable(createToJson: false)
class MenuDynamicItemDto {
  final String title;
  final String? subTitle;
  final List<String>? points;
  final String cta;
  final String url;

  MenuDynamicItemDto({
    required this.title,
    required this.subTitle,
    required this.points,
    required this.cta,
    required this.url,
  });

  factory MenuDynamicItemDto.fromJson(Map<String, dynamic> json) =>
      _$MenuDynamicItemDtoFromJson(json);
}
