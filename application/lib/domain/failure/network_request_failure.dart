import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_request_failure.freezed.dart';

@freezed
class NetworkRequestFailure with _$NetworkRequestFailure {
  const factory NetworkRequestFailure.noInternet() = _NoInternet;

  const factory NetworkRequestFailure.notAuthorized() = _NotAuthorized;

  const factory NetworkRequestFailure.serverError({
    required int statusCode,
    required String statusMsg,
  }) = _ServerError;

  const factory NetworkRequestFailure.responseParseError({
    required dynamic exception,
  }) = ResponseParseError;

  const factory NetworkRequestFailure.unknownError(String msg) = _Unknown;
}
