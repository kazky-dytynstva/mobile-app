import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/domain/model/user_action/user_action_request.dart';

part 'home_list_item_data.freezed.dart';

@freezed
abstract class HomeListItemData with _$HomeListItemData {
  @Assert('tales.length > 0')
  const factory HomeListItemData.random({
    required List<TalesPageItemData> tales,
  }) = _Random;

  @Assert('tales.length > 0')
  const factory HomeListItemData.latest({
    required List<TalesPageItemData> tales,
  }) = _Latest;

  @Assert('tales.length > 0')
  const factory HomeListItemData.bestRating({
    required List<TalesPageItemData> tales,
  }) = _BestRating;

  const factory HomeListItemData.userActionRequest({
    required UserActionRequest actionRequest,
  }) = _ActionRequest;
}
