import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/rating/rating_data.dart';
import 'package:mobile_app/domain/model/rating/rating_type.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/infrastructure/data_source/storage_local/tale/entity/rating/rating_entity.dart';

const _borderAwesome = 4.3;

const _borderLike = 3.9;

const _borderModerate = 3.0;

const _borderDislike = 2.0;

@LazySingleton(as: Mapper)
class RatingEntityToDataMapper implements Mapper<RatingEntity, RatingData> {
  @override
  RatingData map(RatingEntity input) {
    late final RatingType type;
    if (input.avg >= _borderAwesome) {
      type = RatingType.awesome;
    } else if (input.avg >= _borderLike) {
      type = RatingType.like;
    } else if (input.avg >= _borderModerate) {
      type = RatingType.moderate;
    } else if (input.avg >= _borderDislike) {
      type = RatingType.dislike;
    } else {
      type = RatingType.terrible;
    }
    return RatingData(
      type,
      IntPositive(input.amount),
      input.avg,
    );
  }
}
