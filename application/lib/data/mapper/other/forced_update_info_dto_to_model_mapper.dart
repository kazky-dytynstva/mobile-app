import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/forced_update_info/forced_update_info.dart';
import 'package:mobile_app/domain/value_objects/string_not_empty.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/data/data_source/remote_configs/dto/forced_update_info/forced_update_info_dto.dart';

@Injectable(as: Mapper)
class ForcedUpdateInfoDtoToModelMapper
    implements Mapper<ForcedUpdateInfoDto, ForcedUpdateInfo> {
  @override
  ForcedUpdateInfo map(ForcedUpdateInfoDto input) {
    final points = input.points;
    final pointsOption = points == null
        ? const None<List<StringSingleLine>>()
        : Some(points.map((e) => StringSingleLine(e)).toList());

    return ForcedUpdateInfo(
      title: StringSingleLine(input.title),
      msg: StringNonEmpty(input.msg),
      pointsOption: pointsOption,
      canSkip: input.canSkip,
    );
  }
}
