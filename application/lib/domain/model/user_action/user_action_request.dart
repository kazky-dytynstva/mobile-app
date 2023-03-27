import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_app/domain/model/menu_dynamic_item/menu_dynamic_item_data.dart';

part 'user_action_request.freezed.dart';

@Freezed()
abstract class UserActionRequest with _$UserActionRequest {
  const factory UserActionRequest.rate() = _Rate;

  const factory UserActionRequest.share() = _Share;

  const factory UserActionRequest.support() = _Support;

  const factory UserActionRequest.dynamic({
    required MenuDynamicItemData itemData,
  }) = _Dynamic;
}
