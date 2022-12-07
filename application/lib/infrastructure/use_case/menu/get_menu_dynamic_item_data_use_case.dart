import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/menu_dynamic_item/menu_dynamic_item_data.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/data_source/remote_configs.dart';
import 'package:mobile_app/infrastructure/data_source/remote_configs/dto/menu_dynamic_item/menu_dynamic_item_dto.dart';
import 'package:mobile_app/infrastructure/helper/logger/logger.dart';

@Injectable(as: UseCase)
class GetMenuDynamicItemDataUseCase
    extends UseCase<Dry, Option<MenuDynamicItemData>> {
  final RemoteConfigs _configs;
  final Mapper<MenuDynamicItemDto, MenuDynamicItemData> _mapper;
  final Logger _logger;

  GetMenuDynamicItemDataUseCase(
    this._configs,
    this._logger,
    this._mapper,
  );

  @override
  Stream<Option<MenuDynamicItemData>> transaction(Dry input) async* {
    _logger.log(
      () => 'Check MenuDynamicItemDto',
      tag: logTag,
    );
    final dto = _configs.getMenuDynamicItem();

    late final Option<MenuDynamicItemData> output;

    if (dto == null) {
      _logger.log(
        () => 'No menu dynamic item found ',
        tag: logTag,
      );
      output = const None<MenuDynamicItemData>();
    } else {
      _logger.log(
        () => 'Menu dynamic item was found',
        tag: logTag,
      );
      output = Some(_mapper.map(dto));
    }

    yield output;
  }
}
