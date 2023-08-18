import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dto/dto.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/failure/network_request_failure.dart';
import 'package:mobile_app/domain/model/network_call_response/network_call_response.dart';
import 'package:mobile_app/domain/model/rating/rating_type.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/value_objects/file_path.dart';
import 'package:mobile_app/domain/value_objects/url_string.dart';
import 'package:mobile_app/data/data_source/remote_api/base/api_client.dart';
import 'package:mobile_app/data/data_source/remote_api/base/base_api_client.dart';
import 'package:mobile_app/data/data_source/remote_api/parser/network_response_parser.dart';
import 'package:mobile_app/data/helper/analytic/crash_analytic.dart';
import 'package:mobile_app/data/helper/url_creator/url_creator.dart';

const String _tableRating = "rating_2";

abstract class ApiUrls {
  const ApiUrls._();

  static const baseUrl = 'https://github.com/';
  static const pathTales = 'https://github.com/';
}

@LazySingleton(as: ApiClient)
class ApiClientImpl extends BaseApiClient implements ApiClient {
  final Dio _dio;
  final UrlCreator _urlCreator;
  final NetworkResponseParser _parser;
  final FirebaseDatabase _firebaseDatabase;

  late final _ratingHelper = _RatingHelper();

  ApiClientImpl(
    this._dio,
    this._firebaseDatabase,
    this._urlCreator,
    this._parser,
    CrashAnalytic crashAnalytic,
  ) : super(crashAnalytic);

  @override
  Future<Either<NetworkRequestFailure, Iterable<PersonDto>>> getPeople() async {
    final path = _urlCreator.urlPathPeopleList.get();

    final NetworkCallResponse<String> networkResponse =
        await call(_dio.get(path));

    return networkResponse.when(
      successful: _parser.getPeople,
      failed: (NetworkRequestFailure failure) => left(failure),
    );
  }

  @override
  Future<Either<NetworkRequestFailure, Iterable<TaleDto>>> getTales() async {
    final path = _urlCreator.urlPathTalesList.get();

    final NetworkCallResponse<String> networkResponse =
        await call(_dio.get(path));

    return networkResponse.when(
      successful: _parser.getTales,
      failed: (NetworkRequestFailure failure) => left(failure),
    );
  }

  @override
  Future<Either<NetworkRequestFailure, Unit>> downloadAudio({
    required UrlString url,
    required FilePath filePath,
  }) async {
    final Future<Response> future = _dio.download(
      url.get(),
      filePath.get(),
      deleteOnError: false,
      options: Options(receiveTimeout: const Duration(seconds: 60)),
    );
    final NetworkCallResponse networkResponse = await call(future);
    return networkResponse.when(
      successful: (_) => right(unit),
      failed: (NetworkRequestFailure failure) => left(failure),
    );
  }

  @override
  Future<Either<NetworkRequestFailure, Iterable<RatingDto>>>
      getRatings() async {
    try {
      final snapshot = await _firebaseDatabase.ref(_tableRating).get();
      return _parser.getRatings(json.encode(snapshot.value));
    } catch (e) {
      return left(const NetworkRequestFailure.noInternet());
    }
  }

  @override
  Future<Either<NetworkRequestFailure, RatingDto>> rateTale({
    required TaleId taleId,
    required RatingType type,
  }) async {
    try {
      final reference =
          _firebaseDatabase.ref(_tableRating).child(taleId.get().toString());

      Future<void> save(RatingDto updatedDto) async {
        final map = updatedDto.toJson();
        await reference.set(map);
        return;
      }

      final data =
          (await reference.get().timeout(const Duration(seconds: 5))).value;
      if (data == null) {
        final dto = _ratingHelper.getNew(taleId, type);
        await save(dto);
        return right(dto);
      }

      final dtoEither = _parser.getRating(json.encode(data));
      return await dtoEither.fold(
        (l) async => left(l),
        (dto) async {
          final updatedDto = _ratingHelper.getUpdated(dto, type);
          await save(updatedDto);
          return right(updatedDto);
        },
      );
    } catch (e) {
      return left(const NetworkRequestFailure.noInternet());
    }
  }
}

class _RatingHelper {
  RatingDto getNew(TaleId id, RatingType type) => RatingDto(
        id.get(),
        1,
        type.mark.toDouble(),
      );

  RatingDto getUpdated(RatingDto dto, RatingType type) {
    final newAmount = dto.amount + 1;
    final newAvg = ((dto.amount * dto.averageRating) + type.mark) / newAmount;
    return RatingDto(
      dto.taleId,
      newAmount,
      newAvg,
    );
  }
}
