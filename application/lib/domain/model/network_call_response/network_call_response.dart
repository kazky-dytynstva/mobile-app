import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_app/domain/failure/network_request_failure.dart';

part 'network_call_response.freezed.dart';

@freezed
abstract class NetworkCallResponse<T> with _$NetworkCallResponse<T> {
  const factory NetworkCallResponse.successful({
    required T data,
  }) = _NetworkCallResponseSuccessful;

  const factory NetworkCallResponse.failed({
    required NetworkRequestFailure failure,
  }) = _NetworkCallResponseFailed;
}
