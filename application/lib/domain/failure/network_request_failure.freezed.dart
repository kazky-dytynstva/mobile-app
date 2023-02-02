// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_request_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NetworkRequestFailure {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() noInternet,
    required TResult Function() notAuthorized,
    required TResult Function(int statusCode, String statusMsg) serverError,
    required TResult Function(dynamic exception) responseParseError,
    required TResult Function(String msg) unknownError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? noInternet,
    TResult? Function()? notAuthorized,
    TResult? Function(int statusCode, String statusMsg)? serverError,
    TResult? Function(dynamic exception)? responseParseError,
    TResult? Function(String msg)? unknownError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? noInternet,
    TResult Function()? notAuthorized,
    TResult Function(int statusCode, String statusMsg)? serverError,
    TResult Function(dynamic exception)? responseParseError,
    TResult Function(String msg)? unknownError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_NotAuthorized value) notAuthorized,
    required TResult Function(_ServerError value) serverError,
    required TResult Function(ResponseParseError value) responseParseError,
    required TResult Function(_Unknown value) unknownError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_NotAuthorized value)? notAuthorized,
    TResult? Function(_ServerError value)? serverError,
    TResult? Function(ResponseParseError value)? responseParseError,
    TResult? Function(_Unknown value)? unknownError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_NotAuthorized value)? notAuthorized,
    TResult Function(_ServerError value)? serverError,
    TResult Function(ResponseParseError value)? responseParseError,
    TResult Function(_Unknown value)? unknownError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NetworkRequestFailureCopyWith<$Res> {
  factory $NetworkRequestFailureCopyWith(NetworkRequestFailure value,
          $Res Function(NetworkRequestFailure) then) =
      _$NetworkRequestFailureCopyWithImpl<$Res, NetworkRequestFailure>;
}

/// @nodoc
class _$NetworkRequestFailureCopyWithImpl<$Res,
        $Val extends NetworkRequestFailure>
    implements $NetworkRequestFailureCopyWith<$Res> {
  _$NetworkRequestFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_NoInternetCopyWith<$Res> {
  factory _$$_NoInternetCopyWith(
          _$_NoInternet value, $Res Function(_$_NoInternet) then) =
      __$$_NoInternetCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_NoInternetCopyWithImpl<$Res>
    extends _$NetworkRequestFailureCopyWithImpl<$Res, _$_NoInternet>
    implements _$$_NoInternetCopyWith<$Res> {
  __$$_NoInternetCopyWithImpl(
      _$_NoInternet _value, $Res Function(_$_NoInternet) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_NoInternet implements _NoInternet {
  const _$_NoInternet();

  @override
  String toString() {
    return 'NetworkRequestFailure.noInternet()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_NoInternet);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() noInternet,
    required TResult Function() notAuthorized,
    required TResult Function(int statusCode, String statusMsg) serverError,
    required TResult Function(dynamic exception) responseParseError,
    required TResult Function(String msg) unknownError,
  }) {
    return noInternet();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? noInternet,
    TResult? Function()? notAuthorized,
    TResult? Function(int statusCode, String statusMsg)? serverError,
    TResult? Function(dynamic exception)? responseParseError,
    TResult? Function(String msg)? unknownError,
  }) {
    return noInternet?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? noInternet,
    TResult Function()? notAuthorized,
    TResult Function(int statusCode, String statusMsg)? serverError,
    TResult Function(dynamic exception)? responseParseError,
    TResult Function(String msg)? unknownError,
    required TResult orElse(),
  }) {
    if (noInternet != null) {
      return noInternet();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_NotAuthorized value) notAuthorized,
    required TResult Function(_ServerError value) serverError,
    required TResult Function(ResponseParseError value) responseParseError,
    required TResult Function(_Unknown value) unknownError,
  }) {
    return noInternet(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_NotAuthorized value)? notAuthorized,
    TResult? Function(_ServerError value)? serverError,
    TResult? Function(ResponseParseError value)? responseParseError,
    TResult? Function(_Unknown value)? unknownError,
  }) {
    return noInternet?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_NotAuthorized value)? notAuthorized,
    TResult Function(_ServerError value)? serverError,
    TResult Function(ResponseParseError value)? responseParseError,
    TResult Function(_Unknown value)? unknownError,
    required TResult orElse(),
  }) {
    if (noInternet != null) {
      return noInternet(this);
    }
    return orElse();
  }
}

abstract class _NoInternet implements NetworkRequestFailure {
  const factory _NoInternet() = _$_NoInternet;
}

/// @nodoc
abstract class _$$_NotAuthorizedCopyWith<$Res> {
  factory _$$_NotAuthorizedCopyWith(
          _$_NotAuthorized value, $Res Function(_$_NotAuthorized) then) =
      __$$_NotAuthorizedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_NotAuthorizedCopyWithImpl<$Res>
    extends _$NetworkRequestFailureCopyWithImpl<$Res, _$_NotAuthorized>
    implements _$$_NotAuthorizedCopyWith<$Res> {
  __$$_NotAuthorizedCopyWithImpl(
      _$_NotAuthorized _value, $Res Function(_$_NotAuthorized) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_NotAuthorized implements _NotAuthorized {
  const _$_NotAuthorized();

  @override
  String toString() {
    return 'NetworkRequestFailure.notAuthorized()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_NotAuthorized);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() noInternet,
    required TResult Function() notAuthorized,
    required TResult Function(int statusCode, String statusMsg) serverError,
    required TResult Function(dynamic exception) responseParseError,
    required TResult Function(String msg) unknownError,
  }) {
    return notAuthorized();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? noInternet,
    TResult? Function()? notAuthorized,
    TResult? Function(int statusCode, String statusMsg)? serverError,
    TResult? Function(dynamic exception)? responseParseError,
    TResult? Function(String msg)? unknownError,
  }) {
    return notAuthorized?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? noInternet,
    TResult Function()? notAuthorized,
    TResult Function(int statusCode, String statusMsg)? serverError,
    TResult Function(dynamic exception)? responseParseError,
    TResult Function(String msg)? unknownError,
    required TResult orElse(),
  }) {
    if (notAuthorized != null) {
      return notAuthorized();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_NotAuthorized value) notAuthorized,
    required TResult Function(_ServerError value) serverError,
    required TResult Function(ResponseParseError value) responseParseError,
    required TResult Function(_Unknown value) unknownError,
  }) {
    return notAuthorized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_NotAuthorized value)? notAuthorized,
    TResult? Function(_ServerError value)? serverError,
    TResult? Function(ResponseParseError value)? responseParseError,
    TResult? Function(_Unknown value)? unknownError,
  }) {
    return notAuthorized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_NotAuthorized value)? notAuthorized,
    TResult Function(_ServerError value)? serverError,
    TResult Function(ResponseParseError value)? responseParseError,
    TResult Function(_Unknown value)? unknownError,
    required TResult orElse(),
  }) {
    if (notAuthorized != null) {
      return notAuthorized(this);
    }
    return orElse();
  }
}

abstract class _NotAuthorized implements NetworkRequestFailure {
  const factory _NotAuthorized() = _$_NotAuthorized;
}

/// @nodoc
abstract class _$$_ServerErrorCopyWith<$Res> {
  factory _$$_ServerErrorCopyWith(
          _$_ServerError value, $Res Function(_$_ServerError) then) =
      __$$_ServerErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({int statusCode, String statusMsg});
}

/// @nodoc
class __$$_ServerErrorCopyWithImpl<$Res>
    extends _$NetworkRequestFailureCopyWithImpl<$Res, _$_ServerError>
    implements _$$_ServerErrorCopyWith<$Res> {
  __$$_ServerErrorCopyWithImpl(
      _$_ServerError _value, $Res Function(_$_ServerError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? statusMsg = null,
  }) {
    return _then(_$_ServerError(
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      statusMsg: null == statusMsg
          ? _value.statusMsg
          : statusMsg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ServerError implements _ServerError {
  const _$_ServerError({required this.statusCode, required this.statusMsg});

  @override
  final int statusCode;
  @override
  final String statusMsg;

  @override
  String toString() {
    return 'NetworkRequestFailure.serverError(statusCode: $statusCode, statusMsg: $statusMsg)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ServerError &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.statusMsg, statusMsg) ||
                other.statusMsg == statusMsg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, statusCode, statusMsg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ServerErrorCopyWith<_$_ServerError> get copyWith =>
      __$$_ServerErrorCopyWithImpl<_$_ServerError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() noInternet,
    required TResult Function() notAuthorized,
    required TResult Function(int statusCode, String statusMsg) serverError,
    required TResult Function(dynamic exception) responseParseError,
    required TResult Function(String msg) unknownError,
  }) {
    return serverError(statusCode, statusMsg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? noInternet,
    TResult? Function()? notAuthorized,
    TResult? Function(int statusCode, String statusMsg)? serverError,
    TResult? Function(dynamic exception)? responseParseError,
    TResult? Function(String msg)? unknownError,
  }) {
    return serverError?.call(statusCode, statusMsg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? noInternet,
    TResult Function()? notAuthorized,
    TResult Function(int statusCode, String statusMsg)? serverError,
    TResult Function(dynamic exception)? responseParseError,
    TResult Function(String msg)? unknownError,
    required TResult orElse(),
  }) {
    if (serverError != null) {
      return serverError(statusCode, statusMsg);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_NotAuthorized value) notAuthorized,
    required TResult Function(_ServerError value) serverError,
    required TResult Function(ResponseParseError value) responseParseError,
    required TResult Function(_Unknown value) unknownError,
  }) {
    return serverError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_NotAuthorized value)? notAuthorized,
    TResult? Function(_ServerError value)? serverError,
    TResult? Function(ResponseParseError value)? responseParseError,
    TResult? Function(_Unknown value)? unknownError,
  }) {
    return serverError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_NotAuthorized value)? notAuthorized,
    TResult Function(_ServerError value)? serverError,
    TResult Function(ResponseParseError value)? responseParseError,
    TResult Function(_Unknown value)? unknownError,
    required TResult orElse(),
  }) {
    if (serverError != null) {
      return serverError(this);
    }
    return orElse();
  }
}

abstract class _ServerError implements NetworkRequestFailure {
  const factory _ServerError(
      {required final int statusCode,
      required final String statusMsg}) = _$_ServerError;

  int get statusCode;
  String get statusMsg;
  @JsonKey(ignore: true)
  _$$_ServerErrorCopyWith<_$_ServerError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResponseParseErrorCopyWith<$Res> {
  factory _$$ResponseParseErrorCopyWith(_$ResponseParseError value,
          $Res Function(_$ResponseParseError) then) =
      __$$ResponseParseErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic exception});
}

/// @nodoc
class __$$ResponseParseErrorCopyWithImpl<$Res>
    extends _$NetworkRequestFailureCopyWithImpl<$Res, _$ResponseParseError>
    implements _$$ResponseParseErrorCopyWith<$Res> {
  __$$ResponseParseErrorCopyWithImpl(
      _$ResponseParseError _value, $Res Function(_$ResponseParseError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = freezed,
  }) {
    return _then(_$ResponseParseError(
      exception: freezed == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$ResponseParseError implements ResponseParseError {
  const _$ResponseParseError({required this.exception});

  @override
  final dynamic exception;

  @override
  String toString() {
    return 'NetworkRequestFailure.responseParseError(exception: $exception)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResponseParseError &&
            const DeepCollectionEquality().equals(other.exception, exception));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(exception));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResponseParseErrorCopyWith<_$ResponseParseError> get copyWith =>
      __$$ResponseParseErrorCopyWithImpl<_$ResponseParseError>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() noInternet,
    required TResult Function() notAuthorized,
    required TResult Function(int statusCode, String statusMsg) serverError,
    required TResult Function(dynamic exception) responseParseError,
    required TResult Function(String msg) unknownError,
  }) {
    return responseParseError(exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? noInternet,
    TResult? Function()? notAuthorized,
    TResult? Function(int statusCode, String statusMsg)? serverError,
    TResult? Function(dynamic exception)? responseParseError,
    TResult? Function(String msg)? unknownError,
  }) {
    return responseParseError?.call(exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? noInternet,
    TResult Function()? notAuthorized,
    TResult Function(int statusCode, String statusMsg)? serverError,
    TResult Function(dynamic exception)? responseParseError,
    TResult Function(String msg)? unknownError,
    required TResult orElse(),
  }) {
    if (responseParseError != null) {
      return responseParseError(exception);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_NotAuthorized value) notAuthorized,
    required TResult Function(_ServerError value) serverError,
    required TResult Function(ResponseParseError value) responseParseError,
    required TResult Function(_Unknown value) unknownError,
  }) {
    return responseParseError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_NotAuthorized value)? notAuthorized,
    TResult? Function(_ServerError value)? serverError,
    TResult? Function(ResponseParseError value)? responseParseError,
    TResult? Function(_Unknown value)? unknownError,
  }) {
    return responseParseError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_NotAuthorized value)? notAuthorized,
    TResult Function(_ServerError value)? serverError,
    TResult Function(ResponseParseError value)? responseParseError,
    TResult Function(_Unknown value)? unknownError,
    required TResult orElse(),
  }) {
    if (responseParseError != null) {
      return responseParseError(this);
    }
    return orElse();
  }
}

abstract class ResponseParseError implements NetworkRequestFailure {
  const factory ResponseParseError({required final dynamic exception}) =
      _$ResponseParseError;

  dynamic get exception;
  @JsonKey(ignore: true)
  _$$ResponseParseErrorCopyWith<_$ResponseParseError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_UnknownCopyWith<$Res> {
  factory _$$_UnknownCopyWith(
          _$_Unknown value, $Res Function(_$_Unknown) then) =
      __$$_UnknownCopyWithImpl<$Res>;
  @useResult
  $Res call({String msg});
}

/// @nodoc
class __$$_UnknownCopyWithImpl<$Res>
    extends _$NetworkRequestFailureCopyWithImpl<$Res, _$_Unknown>
    implements _$$_UnknownCopyWith<$Res> {
  __$$_UnknownCopyWithImpl(_$_Unknown _value, $Res Function(_$_Unknown) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? msg = null,
  }) {
    return _then(_$_Unknown(
      null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Unknown implements _Unknown {
  const _$_Unknown(this.msg);

  @override
  final String msg;

  @override
  String toString() {
    return 'NetworkRequestFailure.unknownError(msg: $msg)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Unknown &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, msg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UnknownCopyWith<_$_Unknown> get copyWith =>
      __$$_UnknownCopyWithImpl<_$_Unknown>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() noInternet,
    required TResult Function() notAuthorized,
    required TResult Function(int statusCode, String statusMsg) serverError,
    required TResult Function(dynamic exception) responseParseError,
    required TResult Function(String msg) unknownError,
  }) {
    return unknownError(msg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? noInternet,
    TResult? Function()? notAuthorized,
    TResult? Function(int statusCode, String statusMsg)? serverError,
    TResult? Function(dynamic exception)? responseParseError,
    TResult? Function(String msg)? unknownError,
  }) {
    return unknownError?.call(msg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? noInternet,
    TResult Function()? notAuthorized,
    TResult Function(int statusCode, String statusMsg)? serverError,
    TResult Function(dynamic exception)? responseParseError,
    TResult Function(String msg)? unknownError,
    required TResult orElse(),
  }) {
    if (unknownError != null) {
      return unknownError(msg);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_NotAuthorized value) notAuthorized,
    required TResult Function(_ServerError value) serverError,
    required TResult Function(ResponseParseError value) responseParseError,
    required TResult Function(_Unknown value) unknownError,
  }) {
    return unknownError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_NotAuthorized value)? notAuthorized,
    TResult? Function(_ServerError value)? serverError,
    TResult? Function(ResponseParseError value)? responseParseError,
    TResult? Function(_Unknown value)? unknownError,
  }) {
    return unknownError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_NotAuthorized value)? notAuthorized,
    TResult Function(_ServerError value)? serverError,
    TResult Function(ResponseParseError value)? responseParseError,
    TResult Function(_Unknown value)? unknownError,
    required TResult orElse(),
  }) {
    if (unknownError != null) {
      return unknownError(this);
    }
    return orElse();
  }
}

abstract class _Unknown implements NetworkRequestFailure {
  const factory _Unknown(final String msg) = _$_Unknown;

  String get msg;
  @JsonKey(ignore: true)
  _$$_UnknownCopyWith<_$_Unknown> get copyWith =>
      throw _privateConstructorUsedError;
}
