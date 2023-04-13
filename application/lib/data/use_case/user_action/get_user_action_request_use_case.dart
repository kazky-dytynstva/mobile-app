import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:mobile_app/data/data_source/remote_configs/dto/menu_dynamic_item/menu_dynamic_item_dto.dart';
import 'package:mobile_app/domain/data_source/remote_configs.dart';
import 'package:mobile_app/domain/data_source/storage_local/app_state_storage.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/forced_update_info/forced_update_info.dart';
import 'package:mobile_app/domain/model/menu_dynamic_item/menu_dynamic_item_data.dart';
import 'package:mobile_app/domain/model/show_dot/show_dot_type.dart';
import 'package:mobile_app/domain/model/user_action/user_action_request.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';

const _minAppStartsCount = 3;

@Injectable(as: UseCase)
class GetUserActionRequestUseCase extends UseCase<Dry, UserActionRequest?> {
  final AppStateStorage _stateStorage;
  final RemoteConfigs _remoteConfigs;
  final Mapper<MenuDynamicItemDto, MenuDynamicItemData> _dynamicItemMapper;
  final UseCase<Dry, ForcedUpdateInfo?> _getForcedUpdateInfoUseCase;

  GetUserActionRequestUseCase(
    this._stateStorage,
    this._remoteConfigs,
    this._dynamicItemMapper,
    this._getForcedUpdateInfoUseCase,
  );

  @override
  Stream<UserActionRequest?> transaction(Dry input) async* {
    final appUpdateInfo = await _getForcedUpdateInfoUseCase.call(dry);
    if (appUpdateInfo != null) {
      yield UserActionRequest.appUpdate(updateInfo: appUpdateInfo);
      return;
    }

    final showWhatsNew =
        await _stateStorage.showDotForType(ShowDotType.whatsNew);
    if (true) {
      yield const UserActionRequest.whatsNew();
      return;
    }

    final dynamicItemDto = _remoteConfigs.getMenuDynamicItem();
    final lastSeenItemId = await _stateStorage.getLastSeenMenuDynamicDataId();
    if (dynamicItemDto != null && lastSeenItemId.get() != dynamicItemDto.id) {
      final dynamicItem = _dynamicItemMapper.map(dynamicItemDto);
      yield UserActionRequest.dynamic(itemData: dynamicItem);
      return;
    }

    final appStartsCount = await _stateStorage.getAppStartsCount();
    if (appStartsCount < _minAppStartsCount || appStartsCount.get() % 3 != 0) {
      yield null;
      return;
    }

    final userRequest = await _getRandom();

    yield userRequest;
  }

  Future<UserActionRequest?> _getRateApp() async {
    final rateAppClicked = await _stateStorage.isRateAppClicked();

    if (rateAppClicked) return null;

    return const UserActionRequest.rate();
  }

  Future<UserActionRequest?> _getShareApp() async {
    final shareAppClicked = await _stateStorage.isShareAppClicked();

    if (shareAppClicked) return null;

    return const UserActionRequest.share();
  }

  Future<UserActionRequest?> _getSupportApp() async {
    final supportAppClicked = await _stateStorage.isSupportAppClicked();

    if (supportAppClicked) return null;

    return const UserActionRequest.support();
  }

  Future<UserActionRequest?> _getByRandomType(_RandomRequestType type) {
    switch (type) {
      case _RandomRequestType.support:
        return _getSupportApp();
      case _RandomRequestType.share:
        return _getShareApp();
      case _RandomRequestType.rate:
        return _getRateApp();
    }
  }

  Future<UserActionRequest?> _getRandom() async {
    final list = List.from(_RandomRequestType.values);
    final random = Random();

    while (list.isNotEmpty) {
      final index = random.nextInt(list.length);
      final type = list[index];
      final userRequest = await _getByRandomType(type);

      if (userRequest != null) return userRequest;

      list.remove(type);
    }

    return null;
  }
}

enum _RandomRequestType {
  support,
  share,
  rate,
}
