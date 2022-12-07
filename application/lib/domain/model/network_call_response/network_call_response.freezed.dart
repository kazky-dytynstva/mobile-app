// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'network_call_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NetworkCallResponse<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) successful,
    required TResult Function(NetworkRequestFailure failure) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? successful,
    TResult? Function(NetworkRequestFailure failure)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? successful,
    TResult Function(NetworkRequestFailure failure)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NetworkCallResponseSuccessful<T> value)
        successful,
    required TResult Function(_NetworkCallResponseFailed<T> value) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NetworkCallResponseSuccessful<T> value)? successful,
    TResult? Function(_NetworkCallResponseFailed<T> value)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NetworkCallResponseSuccessful<T> value)? successful,
    TResult Function(_NetworkCallResponseFailed<T> value)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NetworkCallResponseCopyWith<T, $Res> {
  factory $NetworkCallResponseCopyWith(NetworkCallResponse<T> value,
          $Res Function(NetworkCallResponse<T>) then) =
      _$NetworkCallResponseCopyWithImpl<T, $Res, NetworkCallResponse<T>>;
}

/// @nodoc
class _$NetworkCallResponseCopyWithImpl<T, $Res,
        $Val extends NetworkCallResponse<T>>
    implements $NetworkCallResponseCopyWith<T, $Res> {
  _$NetworkCallResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_NetworkCallResponseSuccessfulCopyWith<T, $Res> {
  factory _$$_NetworkCallResponseSuccessfulCopyWith(
          _$_NetworkCallResponseSuccessful<T> value,
          $Res Function(_$_NetworkCallResponseSuccessful<T>) then) =
      __$$_NetworkCallResponseSuccessfulCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data});
}

/// @nodoc
class __$$_NetworkCallResponseSuccessfulCopyWithImpl<T, $Res>
    extends _$NetworkCallResponseCopyWithImpl<T, $Res,
        _$_NetworkCallResponseSuccessful<T>>
    implements _$$_NetworkCallResponseSuccessfulCopyWith<T, $Res> {
  __$$_NetworkCallResponseSuccessfulCopyWithImpl(
      _$_NetworkCallResponseSuccessful<T> _value,
      $Res Function(_$_NetworkCallResponseSuccessful<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$_NetworkCallResponseSuccessful<T>(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$_NetworkCallResponseSuccessful<T>
    implements _NetworkCallResponseSuccessful<T> {
  const _$_NetworkCallResponseSuccessful({required this.data});

  @override
  final T data;

  @override
  String toString() {
    return 'NetworkCallResponse<$T>.successful(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NetworkCallResponseSuccessful<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NetworkCallResponseSuccessfulCopyWith<T,
          _$_NetworkCallResponseSuccessful<T>>
      get copyWith => __$$_NetworkCallResponseSuccessfulCopyWithImpl<T,
          _$_NetworkCallResponseSuccessful<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) successful,
    required TResult Function(NetworkRequestFailure failure) failed,
  }) {
    return successful(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? successful,
    TResult? Function(NetworkRequestFailure failure)? failed,
  }) {
    return successful?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? successful,
    TResult Function(NetworkRequestFailure failure)? failed,
    required TResult orElse(),
  }) {
    if (successful != null) {
      return successful(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NetworkCallResponseSuccessful<T> value)
        successful,
    required TResult Function(_NetworkCallResponseFailed<T> value) failed,
  }) {
    return successful(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NetworkCallResponseSuccessful<T> value)? successful,
    TResult? Function(_NetworkCallResponseFailed<T> value)? failed,
  }) {
    return successful?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NetworkCallResponseSuccessful<T> value)? successful,
    TResult Function(_NetworkCallResponseFailed<T> value)? failed,
    required TResult orElse(),
  }) {
    if (successful != null) {
      return successful(this);
    }
    return orElse();
  }
}

abstract class _NetworkCallResponseSuccessful<T>
    implements NetworkCallResponse<T> {
  const factory _NetworkCallResponseSuccessful({required final T data}) =
      _$_NetworkCallResponseSuccessful<T>;

  T get data;
  @JsonKey(ignore: true)
  _$$_NetworkCallResponseSuccessfulCopyWith<T,
          _$_NetworkCallResponseSuccessful<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_NetworkCallResponseFailedCopyWith<T, $Res> {
  factory _$$_NetworkCallResponseFailedCopyWith(
          _$_NetworkCallResponseFailed<T> value,
          $Res Function(_$_NetworkCallResponseFailed<T>) then) =
      __$$_NetworkCallResponseFailedCopyWithImpl<T, $Res>;
  @useResult
  $Res call({NetworkRequestFailure failure});

  $NetworkRequestFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$_NetworkCallResponseFailedCopyWithImpl<T, $Res>
    extends _$NetworkCallResponseCopyWithImpl<T, $Res,
        _$_NetworkCallResponseFailed<T>>
    implements _$$_NetworkCallResponseFailedCopyWith<T, $Res> {
  __$$_NetworkCallResponseFailedCopyWithImpl(
      _$_NetworkCallResponseFailed<T> _value,
      $Res Function(_$_NetworkCallResponseFailed<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$_NetworkCallResponseFailed<T>(
      failure: null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as NetworkRequestFailure,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $NetworkRequestFailureCopyWith<$Res> get failure {
    return $NetworkRequestFailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc

class _$_NetworkCallResponseFailed<T> implements _NetworkCallResponseFailed<T> {
  const _$_NetworkCallResponseFailed({required this.failure});

  @override
  final NetworkRequestFailure failure;

  @override
  String toString() {
    return 'NetworkCallResponse<$T>.failed(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NetworkCallResponseFailed<T> &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NetworkCallResponseFailedCopyWith<T, _$_NetworkCallResponseFailed<T>>
      get copyWith => __$$_NetworkCallResponseFailedCopyWithImpl<T,
          _$_NetworkCallResponseFailed<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) successful,
    required TResult Function(NetworkRequestFailure failure) failed,
  }) {
    return failed(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? successful,
    TResult? Function(NetworkRequestFailure failure)? failed,
  }) {
    return failed?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? successful,
    TResult Function(NetworkRequestFailure failure)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NetworkCallResponseSuccessful<T> value)
        successful,
    required TResult Function(_NetworkCallResponseFailed<T> value) failed,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NetworkCallResponseSuccessful<T> value)? successful,
    TResult? Function(_NetworkCallResponseFailed<T> value)? failed,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NetworkCallResponseSuccessful<T> value)? successful,
    TResult Function(_NetworkCallResponseFailed<T> value)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class _NetworkCallResponseFailed<T> implements NetworkCallResponse<T> {
  const factory _NetworkCallResponseFailed(
          {required final NetworkRequestFailure failure}) =
      _$_NetworkCallResponseFailed<T>;

  NetworkRequestFailure get failure;
  @JsonKey(ignore: true)
  _$$_NetworkCallResponseFailedCopyWith<T, _$_NetworkCallResponseFailed<T>>
      get copyWith => throw _privateConstructorUsedError;
}
