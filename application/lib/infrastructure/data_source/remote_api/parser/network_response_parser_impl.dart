import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dto/dto.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/failure/network_request_failure.dart';
import 'package:mobile_app/infrastructure/data_source/remote_api/exception/parse_person_response_exception.dart';
import 'package:mobile_app/infrastructure/data_source/remote_api/exception/parse_rating_response_exception.dart';
import 'package:mobile_app/infrastructure/data_source/remote_api/exception/parse_tale_response_exception.dart';
import 'package:mobile_app/infrastructure/data_source/remote_api/parser/network_response_parser.dart';
import 'package:mobile_app/infrastructure/env_config/env_config.dart';
import 'package:mobile_app/infrastructure/helper/analytic/crash_analytic.dart';

@LazySingleton(as: NetworkResponseParser)
class NetworkResponseParserImpl implements NetworkResponseParser {
  final CrashAnalytic _crashAnalytic;

  NetworkResponseParserImpl(
    this._crashAnalytic,
  );

  @override
  Either<ResponseParseError, List<TaleDto>> getTales(String data) {
    final list = json.decode(data) as List<dynamic>;

    final List<TaleDto> results = [];
    for (final element in list) {
      late int taleId;
      try {
        taleId = element['id'] as int;
        final dto = TaleDto.fromJson(element as Map<String, dynamic>);
        if (!dto.ignore || !EnvConfig.isProd) {
          results.add(dto);
        }
      } catch (e, trace) {
        final error = ParseTaleResponseException(taleId, e);
        _crashAnalytic.exception(error, trace);
      }
    }

    if (results.isEmpty && list.isNotEmpty) {
      const error = _ParsedResultsIsEmptyError('Tales');
      return const Left(ResponseParseError(exception: error));
    }

    return right(results);
  }

  @override
  Either<ResponseParseError, List<PersonDto>> getPeople(String data) {
    final list = json.decode(data) as List<dynamic>;

    final List<PersonDto> results = [];
    for (final element in list) {
      late int personId;
      try {
        personId = element['id'] as int;
        final dto = PersonDto.fromJson(element as Map<String, dynamic>);
        results.add(dto);
      } catch (e, trace) {
        final error = ParsePersonResponseException(personId, e);
        _crashAnalytic.exception(error, trace);
      }
    }

    if (results.isEmpty && list.isNotEmpty) {
      const error = _ParsedResultsIsEmptyError('People');
      return const Left(ResponseParseError(exception: error));
    }

    return right(results);
  }

  @override
  Either<ResponseParseError, List<RatingDto>> getRatings(String data) {
    final list = (json.decode(data) as List<dynamic>)
        .where((element) => element != null);

    final List<RatingDto> results = [];
    for (final element in list) {
      late int taleId;
      try {
        taleId = element['id'] as int;
        final dto = RatingDto.fromJson(element as Map<String, dynamic>);
        results.add(dto);
      } catch (e, trace) {
        final error = ParseRatingResponseException(taleId, e);
        _crashAnalytic.exception(error, trace);
      }
    }

    if (results.isEmpty && list.isNotEmpty) {
      const error = _ParsedResultsIsEmptyError('Ratings');
      return const Left(ResponseParseError(exception: error));
    }

    return right(results);
  }

  @override
  Either<ResponseParseError, RatingDto> getRating(String data) {
    late int taleId = -1;
    try {
      final element = json.decode(data);
      taleId = element['id'] as int;
      return right(RatingDto.fromJson(element as Map<String, dynamic>));
    } catch (e, trace) {
      final error = ParseRatingResponseException(taleId, e);
      _crashAnalytic.exception(error, trace);
      return left(ResponseParseError(exception: error));
    }
  }
}

class _ParsedResultsIsEmptyError implements Exception {
  final String forType;

  const _ParsedResultsIsEmptyError(this.forType);

  @override
  String toString() =>
      'Parsed results for $forType are empty, but should not be...';
}
