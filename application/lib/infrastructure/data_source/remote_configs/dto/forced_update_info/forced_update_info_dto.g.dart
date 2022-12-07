// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forced_update_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForcedUpdateInfoDto _$ForcedUpdateInfoDtoFromJson(Map<String, dynamic> json) =>
    ForcedUpdateInfoDto(
      title: json['title'] as String,
      msg: json['msg'] as String,
      points:
          (json['points'] as List<dynamic>?)?.map((e) => e as String).toList(),
      canSkip: json['can_skip'] as bool,
      buildNumber: json['build_number'] as int,
    );
