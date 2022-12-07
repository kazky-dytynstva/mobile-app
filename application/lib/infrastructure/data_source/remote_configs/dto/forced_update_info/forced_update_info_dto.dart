import 'package:json_annotation/json_annotation.dart';

part 'forced_update_info_dto.g.dart';

@JsonSerializable(createToJson: false)
class ForcedUpdateInfoDto {
  final String title;
  final String msg;
  final List<String>? points;
  final bool canSkip;

  /// Application with this or lower version of build number should be
  /// forced to update
  final int buildNumber;

  ForcedUpdateInfoDto({
    required this.title,
    required this.msg,
    required this.points,
    required this.canSkip,
    required this.buildNumber,
  });

  factory ForcedUpdateInfoDto.fromJson(Map<String, dynamic> json) =>
      _$ForcedUpdateInfoDtoFromJson(json);
}
