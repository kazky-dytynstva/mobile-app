import 'package:dartz/dartz.dart';
import 'package:mobile_app/domain/failure/network_request_failure.dart';
import 'package:mobile_app/domain/model/rating/rating_type.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/value_objects/file_path.dart';
import 'package:mobile_app/domain/value_objects/url_string.dart';
import 'package:dto/dto.dart';

abstract class ApiClient {
  Future<Either<NetworkRequestFailure, Iterable<TaleDto>>> getTales();

  Future<Either<NetworkRequestFailure, Iterable<PersonDto>>> getPeople();

  Future<Either<NetworkRequestFailure, Unit>> downloadAudio({
    required UrlString url,
    required FilePath filePath,
  });

  Future<Either<NetworkRequestFailure, Iterable<RatingDto>>> getRatings();

  Future<Either<NetworkRequestFailure, RatingDto>> rateTale({
    required TaleId taleId,
    required RatingType type,
  });
}
