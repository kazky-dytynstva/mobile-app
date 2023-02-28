import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_app/domain/model/tale/tale.dart';

part 'home_list_item_data.freezed.dart';

@freezed
abstract class HomeListItemData with _$HomeListItemData {
  @Assert('tales.isNotEmpty')
  const factory HomeListItemData.random({
    required List<Tale> tales,
  }) = _Random;

  @Assert('tales.isNotEmpty')
  const factory HomeListItemData.latest({
    required List<Tale> tales,
  }) = _Latest;

  @Assert('tales.isNotEmpty')
  const factory HomeListItemData.bestRating({
    required List<Tale> tales,
  }) = _BestRating;
}
