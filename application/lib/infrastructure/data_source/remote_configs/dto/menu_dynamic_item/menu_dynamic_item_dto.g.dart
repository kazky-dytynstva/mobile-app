// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_dynamic_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuDynamicItemDto _$MenuDynamicItemDtoFromJson(Map<String, dynamic> json) =>
    MenuDynamicItemDto(
      title: json['title'] as String,
      subTitle: json['sub_title'] as String?,
      points:
          (json['points'] as List<dynamic>?)?.map((e) => e as String).toList(),
      cta: json['cta'] as String,
      url: json['url'] as String,
    );
