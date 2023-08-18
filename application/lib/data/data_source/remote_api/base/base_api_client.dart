import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:mobile_app/domain/failure/network_request_failure.dart';
import 'package:mobile_app/domain/model/network_call_response/network_call_response.dart';
import 'package:mobile_app/data/helper/analytic/crash_analytic.dart';

abstract class BaseApiClient {
  @protected
  final CrashAnalytic crashAnalytic;

  BaseApiClient(this.crashAnalytic);

  @protected
  Future<NetworkCallResponse<T>> call<T>(
    Future<Response<T>> request,
  ) async {
    try {
      final data = (await request).data as T;
      return NetworkCallResponse.successful(data: data);
    } on DioException catch (error) {
      final response = error.response;
      if (response != null) {
        return _mapErrorResponse(response);
      } else {
        return _mapError(error);
      }
    } catch (e, trace) {
      crashAnalytic.exception(
        Exception("Unexpected api error happened: $e"),
        trace,
        fatal: true,
      );
      final failure = NetworkRequestFailure.unknownError(e.toString());
      return NetworkCallResponse.failed(failure: failure);
    }
  }

  NetworkCallResponse<T> _mapError<T>(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionError:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        const failure = NetworkRequestFailure.noInternet();
        return const NetworkCallResponse.failed(failure: failure);
      case DioExceptionType.badResponse:
        throw Exception("CANCELING API CALL SHOULD NOT HAPPENED");
      case DioExceptionType.cancel:
        throw Exception("CANCELING API CALL SHOULD NOT HAPPENED");
      case DioExceptionType.unknown:
      case DioExceptionType.badCertificate:
        if (error.error is TimeoutException ||
            error.error is SocketException ||
            error.error is HttpException ||
            error.error is HandshakeException ||
            error.error is WebSocketException) {
          const failure = NetworkRequestFailure.noInternet();
          return const NetworkCallResponse.failed(failure: failure);
        } else {
          final exception = _DefaultApiException(error);
          crashAnalytic.exception(exception, StackTrace.current, fatal: true);
          final failure =
              NetworkRequestFailure.unknownError(exception.toString());
          return NetworkCallResponse.failed(failure: failure);
        }
    }
  }

  NetworkCallResponse<T> _mapErrorResponse<T>(Response<dynamic> response) {
    final statusCode = response.statusCode ?? -1;
    final statusMsg = response.statusMessage ?? '';

    final NetworkRequestFailure failure = (statusCode >= 500)
        ? NetworkRequestFailure.serverError(
            statusCode: statusCode,
            statusMsg: statusMsg,
          )
        : (statusCode == 401)
            ? const NetworkRequestFailure.notAuthorized()
            : NetworkRequestFailure.unknownError(
                'Status code: $statusCode,\nStatus msg: $statusMsg');

    crashAnalytic.exception(
      _ResponseException(response),
      StackTrace.current,
      fatal: true,
    );
    return NetworkCallResponse.failed(failure: failure);
  }
}

class _ResponseException implements Exception {
  final Response _response;

  _ResponseException(this._response);

  @override
  String toString() {
    final request = _response.requestOptions;
    final response = _response;
    final url = "${request.baseUrl}${request.path}";
    final code = response.statusCode;
    final msg = response.statusMessage;
    return "Response error:\n"
        "url: $url\n"
        "code: $code\n"
        "msg: $msg";
  }
}

class _DefaultApiException implements Exception {
  final DioException _error;

  const _DefaultApiException(this._error);

  @override
  String toString() => "Response error:\n"
      "url: ${_error.requestOptions.baseUrl}${_error.requestOptions.path}\n"
      "code: ${_error.response?.statusCode}\n"
      "msg: ${_error.response?.statusMessage}\n"
      "error: ${_error.error}";
}
