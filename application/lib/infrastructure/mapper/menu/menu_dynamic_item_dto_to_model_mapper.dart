import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/menu_dynamic_item/menu_dynamic_item_data.dart';
import 'package:mobile_app/domain/value_objects/string_not_empty.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/domain/value_objects/url_string.dart';
import 'package:mobile_app/infrastructure/data_source/remote_configs/dto/menu_dynamic_item/menu_dynamic_item_dto.dart';

@Injectable(as: Mapper)
class MenuDynamicItemDtoToModelMapper
    implements Mapper<MenuDynamicItemDto, MenuDynamicItemData> {
  @override
  MenuDynamicItemData map(MenuDynamicItemDto input) {
    final subtitle = input.subTitle;
    final subTitleOption = subtitle == null
        ? const None<StringSingleLine>()
        : Some(StringSingleLine(subtitle));

    final points = input.points;
    final pointsOption = points == null
        ? const None<List<StringNonEmpty>>()
        : Some(points.map((e) => StringNonEmpty(e)).toList());

    return MenuDynamicItemData(
      title: StringSingleLine(input.title),
      subTitleOption: subTitleOption,
      pointsOption: pointsOption,
      cta: StringSingleLine(input.cta),
      url: UrlString(input.url),
    );
  }
}
