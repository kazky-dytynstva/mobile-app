import 'package:dto/dto.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/data/data_source/storage_local/tale/entity/rating/rating_entity.dart';

@LazySingleton(as: Mapper)
class RatingDtoToEntityMapper implements Mapper<RatingDto, RatingEntity> {
  @override
  RatingEntity map(RatingDto input) => RatingEntity.create(
        amount: input.amount,
        avg: input.averageRating,
      );
}
