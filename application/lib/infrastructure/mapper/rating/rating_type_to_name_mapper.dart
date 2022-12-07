import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/rating/rating_type.dart';
import 'package:mobile_app/presentation/resource/r.dart';

@LazySingleton(as: Mapper)
class RatingTypeToNameMapper implements Mapper<RatingType, String> {
  @override
  String map(RatingType input) {
    switch (input) {
      case RatingType.awesome:
        return R.strings.ratingNames.awesome;
      case RatingType.like:
        return R.strings.ratingNames.like;
      case RatingType.moderate:
        return R.strings.ratingNames.moderate;
      case RatingType.dislike:
        return R.strings.ratingNames.dislike;
      case RatingType.terrible:
        return R.strings.ratingNames.terrible;
    }
  }
}
