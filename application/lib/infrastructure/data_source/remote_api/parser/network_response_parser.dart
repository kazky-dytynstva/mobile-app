import 'package:dartz/dartz.dart';
import 'package:dto/dto.dart';
import 'package:mobile_app/domain/failure/network_request_failure.dart';

abstract class NetworkResponseParser {
  Either<ResponseParseError, List<TaleDto>> getTales(String data);

  Either<ResponseParseError, List<PersonDto>> getPeople(String data);

  Either<ResponseParseError, List<RatingDto>> getRatings(String data);

  Either<ResponseParseError, RatingDto> getRating(String data);
}
