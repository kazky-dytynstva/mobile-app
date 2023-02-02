// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'value_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ValueFailure<T> {
  Object? get failedValue => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T failedValue, int max) exceedingLength,
    required TResult Function(T failedValue, int min) deficiencyLength,
    required TResult Function(String failedValue) empty,
    required TResult Function(String failedValue) multilineString,
    required TResult Function(T failedValue, num min) numberTooSmall,
    required TResult Function(T failedValue, num max) numberTooLarge,
    required TResult Function(String failedValue) invalidEmail,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T failedValue, int max)? exceedingLength,
    TResult? Function(T failedValue, int min)? deficiencyLength,
    TResult? Function(String failedValue)? empty,
    TResult? Function(String failedValue)? multilineString,
    TResult? Function(T failedValue, num min)? numberTooSmall,
    TResult? Function(T failedValue, num max)? numberTooLarge,
    TResult? Function(String failedValue)? invalidEmail,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T failedValue, int max)? exceedingLength,
    TResult Function(T failedValue, int min)? deficiencyLength,
    TResult Function(String failedValue)? empty,
    TResult Function(String failedValue)? multilineString,
    TResult Function(T failedValue, num min)? numberTooSmall,
    TResult Function(T failedValue, num max)? numberTooLarge,
    TResult Function(String failedValue)? invalidEmail,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValueFailureExceedingLength<T> value)
        exceedingLength,
    required TResult Function(ValueFailureDeficiencyLength<T> value)
        deficiencyLength,
    required TResult Function(ValueFailureEmptyString<T> value) empty,
    required TResult Function(ValueFailureMultilineString<T> value)
        multilineString,
    required TResult Function(ValueFailureNumberTooSmall<T> value)
        numberTooSmall,
    required TResult Function(ValueFailureNumberTooLarge<T> value)
        numberTooLarge,
    required TResult Function(ValueFailureInvalidEmail<T> value) invalidEmail,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValueFailureExceedingLength<T> value)? exceedingLength,
    TResult? Function(ValueFailureDeficiencyLength<T> value)? deficiencyLength,
    TResult? Function(ValueFailureEmptyString<T> value)? empty,
    TResult? Function(ValueFailureMultilineString<T> value)? multilineString,
    TResult? Function(ValueFailureNumberTooSmall<T> value)? numberTooSmall,
    TResult? Function(ValueFailureNumberTooLarge<T> value)? numberTooLarge,
    TResult? Function(ValueFailureInvalidEmail<T> value)? invalidEmail,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValueFailureExceedingLength<T> value)? exceedingLength,
    TResult Function(ValueFailureDeficiencyLength<T> value)? deficiencyLength,
    TResult Function(ValueFailureEmptyString<T> value)? empty,
    TResult Function(ValueFailureMultilineString<T> value)? multilineString,
    TResult Function(ValueFailureNumberTooSmall<T> value)? numberTooSmall,
    TResult Function(ValueFailureNumberTooLarge<T> value)? numberTooLarge,
    TResult Function(ValueFailureInvalidEmail<T> value)? invalidEmail,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ValueFailureCopyWith<T, $Res> {
  factory $ValueFailureCopyWith(
          ValueFailure<T> value, $Res Function(ValueFailure<T>) then) =
      _$ValueFailureCopyWithImpl<T, $Res, ValueFailure<T>>;
}

/// @nodoc
class _$ValueFailureCopyWithImpl<T, $Res, $Val extends ValueFailure<T>>
    implements $ValueFailureCopyWith<T, $Res> {
  _$ValueFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ValueFailureExceedingLengthCopyWith<T, $Res> {
  factory _$$ValueFailureExceedingLengthCopyWith(
          _$ValueFailureExceedingLength<T> value,
          $Res Function(_$ValueFailureExceedingLength<T>) then) =
      __$$ValueFailureExceedingLengthCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T failedValue, int max});
}

/// @nodoc
class __$$ValueFailureExceedingLengthCopyWithImpl<T, $Res>
    extends _$ValueFailureCopyWithImpl<T, $Res,
        _$ValueFailureExceedingLength<T>>
    implements _$$ValueFailureExceedingLengthCopyWith<T, $Res> {
  __$$ValueFailureExceedingLengthCopyWithImpl(
      _$ValueFailureExceedingLength<T> _value,
      $Res Function(_$ValueFailureExceedingLength<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failedValue = freezed,
    Object? max = null,
  }) {
    return _then(_$ValueFailureExceedingLength<T>(
      failedValue: freezed == failedValue
          ? _value.failedValue
          : failedValue // ignore: cast_nullable_to_non_nullable
              as T,
      max: null == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ValueFailureExceedingLength<T>
    implements ValueFailureExceedingLength<T> {
  const _$ValueFailureExceedingLength(
      {required this.failedValue, required this.max});

  @override
  final T failedValue;
  @override
  final int max;

  @override
  String toString() {
    return 'ValueFailure<$T>.exceedingLength(failedValue: $failedValue, max: $max)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValueFailureExceedingLength<T> &&
            const DeepCollectionEquality()
                .equals(other.failedValue, failedValue) &&
            (identical(other.max, max) || other.max == max));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(failedValue), max);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ValueFailureExceedingLengthCopyWith<T, _$ValueFailureExceedingLength<T>>
      get copyWith => __$$ValueFailureExceedingLengthCopyWithImpl<T,
          _$ValueFailureExceedingLength<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T failedValue, int max) exceedingLength,
    required TResult Function(T failedValue, int min) deficiencyLength,
    required TResult Function(String failedValue) empty,
    required TResult Function(String failedValue) multilineString,
    required TResult Function(T failedValue, num min) numberTooSmall,
    required TResult Function(T failedValue, num max) numberTooLarge,
    required TResult Function(String failedValue) invalidEmail,
  }) {
    return exceedingLength(failedValue, max);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T failedValue, int max)? exceedingLength,
    TResult? Function(T failedValue, int min)? deficiencyLength,
    TResult? Function(String failedValue)? empty,
    TResult? Function(String failedValue)? multilineString,
    TResult? Function(T failedValue, num min)? numberTooSmall,
    TResult? Function(T failedValue, num max)? numberTooLarge,
    TResult? Function(String failedValue)? invalidEmail,
  }) {
    return exceedingLength?.call(failedValue, max);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T failedValue, int max)? exceedingLength,
    TResult Function(T failedValue, int min)? deficiencyLength,
    TResult Function(String failedValue)? empty,
    TResult Function(String failedValue)? multilineString,
    TResult Function(T failedValue, num min)? numberTooSmall,
    TResult Function(T failedValue, num max)? numberTooLarge,
    TResult Function(String failedValue)? invalidEmail,
    required TResult orElse(),
  }) {
    if (exceedingLength != null) {
      return exceedingLength(failedValue, max);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValueFailureExceedingLength<T> value)
        exceedingLength,
    required TResult Function(ValueFailureDeficiencyLength<T> value)
        deficiencyLength,
    required TResult Function(ValueFailureEmptyString<T> value) empty,
    required TResult Function(ValueFailureMultilineString<T> value)
        multilineString,
    required TResult Function(ValueFailureNumberTooSmall<T> value)
        numberTooSmall,
    required TResult Function(ValueFailureNumberTooLarge<T> value)
        numberTooLarge,
    required TResult Function(ValueFailureInvalidEmail<T> value) invalidEmail,
  }) {
    return exceedingLength(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValueFailureExceedingLength<T> value)? exceedingLength,
    TResult? Function(ValueFailureDeficiencyLength<T> value)? deficiencyLength,
    TResult? Function(ValueFailureEmptyString<T> value)? empty,
    TResult? Function(ValueFailureMultilineString<T> value)? multilineString,
    TResult? Function(ValueFailureNumberTooSmall<T> value)? numberTooSmall,
    TResult? Function(ValueFailureNumberTooLarge<T> value)? numberTooLarge,
    TResult? Function(ValueFailureInvalidEmail<T> value)? invalidEmail,
  }) {
    return exceedingLength?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValueFailureExceedingLength<T> value)? exceedingLength,
    TResult Function(ValueFailureDeficiencyLength<T> value)? deficiencyLength,
    TResult Function(ValueFailureEmptyString<T> value)? empty,
    TResult Function(ValueFailureMultilineString<T> value)? multilineString,
    TResult Function(ValueFailureNumberTooSmall<T> value)? numberTooSmall,
    TResult Function(ValueFailureNumberTooLarge<T> value)? numberTooLarge,
    TResult Function(ValueFailureInvalidEmail<T> value)? invalidEmail,
    required TResult orElse(),
  }) {
    if (exceedingLength != null) {
      return exceedingLength(this);
    }
    return orElse();
  }
}

abstract class ValueFailureExceedingLength<T> implements ValueFailure<T> {
  const factory ValueFailureExceedingLength(
      {required final T failedValue,
      required final int max}) = _$ValueFailureExceedingLength<T>;

  @override
  T get failedValue;
  int get max;
  @JsonKey(ignore: true)
  _$$ValueFailureExceedingLengthCopyWith<T, _$ValueFailureExceedingLength<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValueFailureDeficiencyLengthCopyWith<T, $Res> {
  factory _$$ValueFailureDeficiencyLengthCopyWith(
          _$ValueFailureDeficiencyLength<T> value,
          $Res Function(_$ValueFailureDeficiencyLength<T>) then) =
      __$$ValueFailureDeficiencyLengthCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T failedValue, int min});
}

/// @nodoc
class __$$ValueFailureDeficiencyLengthCopyWithImpl<T, $Res>
    extends _$ValueFailureCopyWithImpl<T, $Res,
        _$ValueFailureDeficiencyLength<T>>
    implements _$$ValueFailureDeficiencyLengthCopyWith<T, $Res> {
  __$$ValueFailureDeficiencyLengthCopyWithImpl(
      _$ValueFailureDeficiencyLength<T> _value,
      $Res Function(_$ValueFailureDeficiencyLength<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failedValue = freezed,
    Object? min = null,
  }) {
    return _then(_$ValueFailureDeficiencyLength<T>(
      failedValue: freezed == failedValue
          ? _value.failedValue
          : failedValue // ignore: cast_nullable_to_non_nullable
              as T,
      min: null == min
          ? _value.min
          : min // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ValueFailureDeficiencyLength<T>
    implements ValueFailureDeficiencyLength<T> {
  const _$ValueFailureDeficiencyLength(
      {required this.failedValue, required this.min});

  @override
  final T failedValue;
  @override
  final int min;

  @override
  String toString() {
    return 'ValueFailure<$T>.deficiencyLength(failedValue: $failedValue, min: $min)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValueFailureDeficiencyLength<T> &&
            const DeepCollectionEquality()
                .equals(other.failedValue, failedValue) &&
            (identical(other.min, min) || other.min == min));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(failedValue), min);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ValueFailureDeficiencyLengthCopyWith<T, _$ValueFailureDeficiencyLength<T>>
      get copyWith => __$$ValueFailureDeficiencyLengthCopyWithImpl<T,
          _$ValueFailureDeficiencyLength<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T failedValue, int max) exceedingLength,
    required TResult Function(T failedValue, int min) deficiencyLength,
    required TResult Function(String failedValue) empty,
    required TResult Function(String failedValue) multilineString,
    required TResult Function(T failedValue, num min) numberTooSmall,
    required TResult Function(T failedValue, num max) numberTooLarge,
    required TResult Function(String failedValue) invalidEmail,
  }) {
    return deficiencyLength(failedValue, min);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T failedValue, int max)? exceedingLength,
    TResult? Function(T failedValue, int min)? deficiencyLength,
    TResult? Function(String failedValue)? empty,
    TResult? Function(String failedValue)? multilineString,
    TResult? Function(T failedValue, num min)? numberTooSmall,
    TResult? Function(T failedValue, num max)? numberTooLarge,
    TResult? Function(String failedValue)? invalidEmail,
  }) {
    return deficiencyLength?.call(failedValue, min);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T failedValue, int max)? exceedingLength,
    TResult Function(T failedValue, int min)? deficiencyLength,
    TResult Function(String failedValue)? empty,
    TResult Function(String failedValue)? multilineString,
    TResult Function(T failedValue, num min)? numberTooSmall,
    TResult Function(T failedValue, num max)? numberTooLarge,
    TResult Function(String failedValue)? invalidEmail,
    required TResult orElse(),
  }) {
    if (deficiencyLength != null) {
      return deficiencyLength(failedValue, min);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValueFailureExceedingLength<T> value)
        exceedingLength,
    required TResult Function(ValueFailureDeficiencyLength<T> value)
        deficiencyLength,
    required TResult Function(ValueFailureEmptyString<T> value) empty,
    required TResult Function(ValueFailureMultilineString<T> value)
        multilineString,
    required TResult Function(ValueFailureNumberTooSmall<T> value)
        numberTooSmall,
    required TResult Function(ValueFailureNumberTooLarge<T> value)
        numberTooLarge,
    required TResult Function(ValueFailureInvalidEmail<T> value) invalidEmail,
  }) {
    return deficiencyLength(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValueFailureExceedingLength<T> value)? exceedingLength,
    TResult? Function(ValueFailureDeficiencyLength<T> value)? deficiencyLength,
    TResult? Function(ValueFailureEmptyString<T> value)? empty,
    TResult? Function(ValueFailureMultilineString<T> value)? multilineString,
    TResult? Function(ValueFailureNumberTooSmall<T> value)? numberTooSmall,
    TResult? Function(ValueFailureNumberTooLarge<T> value)? numberTooLarge,
    TResult? Function(ValueFailureInvalidEmail<T> value)? invalidEmail,
  }) {
    return deficiencyLength?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValueFailureExceedingLength<T> value)? exceedingLength,
    TResult Function(ValueFailureDeficiencyLength<T> value)? deficiencyLength,
    TResult Function(ValueFailureEmptyString<T> value)? empty,
    TResult Function(ValueFailureMultilineString<T> value)? multilineString,
    TResult Function(ValueFailureNumberTooSmall<T> value)? numberTooSmall,
    TResult Function(ValueFailureNumberTooLarge<T> value)? numberTooLarge,
    TResult Function(ValueFailureInvalidEmail<T> value)? invalidEmail,
    required TResult orElse(),
  }) {
    if (deficiencyLength != null) {
      return deficiencyLength(this);
    }
    return orElse();
  }
}

abstract class ValueFailureDeficiencyLength<T> implements ValueFailure<T> {
  const factory ValueFailureDeficiencyLength(
      {required final T failedValue,
      required final int min}) = _$ValueFailureDeficiencyLength<T>;

  @override
  T get failedValue;
  int get min;
  @JsonKey(ignore: true)
  _$$ValueFailureDeficiencyLengthCopyWith<T, _$ValueFailureDeficiencyLength<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValueFailureEmptyStringCopyWith<T, $Res> {
  factory _$$ValueFailureEmptyStringCopyWith(_$ValueFailureEmptyString<T> value,
          $Res Function(_$ValueFailureEmptyString<T>) then) =
      __$$ValueFailureEmptyStringCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String failedValue});
}

/// @nodoc
class __$$ValueFailureEmptyStringCopyWithImpl<T, $Res>
    extends _$ValueFailureCopyWithImpl<T, $Res, _$ValueFailureEmptyString<T>>
    implements _$$ValueFailureEmptyStringCopyWith<T, $Res> {
  __$$ValueFailureEmptyStringCopyWithImpl(_$ValueFailureEmptyString<T> _value,
      $Res Function(_$ValueFailureEmptyString<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failedValue = null,
  }) {
    return _then(_$ValueFailureEmptyString<T>(
      failedValue: null == failedValue
          ? _value.failedValue
          : failedValue // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ValueFailureEmptyString<T> implements ValueFailureEmptyString<T> {
  const _$ValueFailureEmptyString({required this.failedValue});

  @override
  final String failedValue;

  @override
  String toString() {
    return 'ValueFailure<$T>.empty(failedValue: $failedValue)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValueFailureEmptyString<T> &&
            (identical(other.failedValue, failedValue) ||
                other.failedValue == failedValue));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failedValue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ValueFailureEmptyStringCopyWith<T, _$ValueFailureEmptyString<T>>
      get copyWith => __$$ValueFailureEmptyStringCopyWithImpl<T,
          _$ValueFailureEmptyString<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T failedValue, int max) exceedingLength,
    required TResult Function(T failedValue, int min) deficiencyLength,
    required TResult Function(String failedValue) empty,
    required TResult Function(String failedValue) multilineString,
    required TResult Function(T failedValue, num min) numberTooSmall,
    required TResult Function(T failedValue, num max) numberTooLarge,
    required TResult Function(String failedValue) invalidEmail,
  }) {
    return empty(failedValue);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T failedValue, int max)? exceedingLength,
    TResult? Function(T failedValue, int min)? deficiencyLength,
    TResult? Function(String failedValue)? empty,
    TResult? Function(String failedValue)? multilineString,
    TResult? Function(T failedValue, num min)? numberTooSmall,
    TResult? Function(T failedValue, num max)? numberTooLarge,
    TResult? Function(String failedValue)? invalidEmail,
  }) {
    return empty?.call(failedValue);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T failedValue, int max)? exceedingLength,
    TResult Function(T failedValue, int min)? deficiencyLength,
    TResult Function(String failedValue)? empty,
    TResult Function(String failedValue)? multilineString,
    TResult Function(T failedValue, num min)? numberTooSmall,
    TResult Function(T failedValue, num max)? numberTooLarge,
    TResult Function(String failedValue)? invalidEmail,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(failedValue);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValueFailureExceedingLength<T> value)
        exceedingLength,
    required TResult Function(ValueFailureDeficiencyLength<T> value)
        deficiencyLength,
    required TResult Function(ValueFailureEmptyString<T> value) empty,
    required TResult Function(ValueFailureMultilineString<T> value)
        multilineString,
    required TResult Function(ValueFailureNumberTooSmall<T> value)
        numberTooSmall,
    required TResult Function(ValueFailureNumberTooLarge<T> value)
        numberTooLarge,
    required TResult Function(ValueFailureInvalidEmail<T> value) invalidEmail,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValueFailureExceedingLength<T> value)? exceedingLength,
    TResult? Function(ValueFailureDeficiencyLength<T> value)? deficiencyLength,
    TResult? Function(ValueFailureEmptyString<T> value)? empty,
    TResult? Function(ValueFailureMultilineString<T> value)? multilineString,
    TResult? Function(ValueFailureNumberTooSmall<T> value)? numberTooSmall,
    TResult? Function(ValueFailureNumberTooLarge<T> value)? numberTooLarge,
    TResult? Function(ValueFailureInvalidEmail<T> value)? invalidEmail,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValueFailureExceedingLength<T> value)? exceedingLength,
    TResult Function(ValueFailureDeficiencyLength<T> value)? deficiencyLength,
    TResult Function(ValueFailureEmptyString<T> value)? empty,
    TResult Function(ValueFailureMultilineString<T> value)? multilineString,
    TResult Function(ValueFailureNumberTooSmall<T> value)? numberTooSmall,
    TResult Function(ValueFailureNumberTooLarge<T> value)? numberTooLarge,
    TResult Function(ValueFailureInvalidEmail<T> value)? invalidEmail,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class ValueFailureEmptyString<T> implements ValueFailure<T> {
  const factory ValueFailureEmptyString({required final String failedValue}) =
      _$ValueFailureEmptyString<T>;

  @override
  String get failedValue;
  @JsonKey(ignore: true)
  _$$ValueFailureEmptyStringCopyWith<T, _$ValueFailureEmptyString<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValueFailureMultilineStringCopyWith<T, $Res> {
  factory _$$ValueFailureMultilineStringCopyWith(
          _$ValueFailureMultilineString<T> value,
          $Res Function(_$ValueFailureMultilineString<T>) then) =
      __$$ValueFailureMultilineStringCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String failedValue});
}

/// @nodoc
class __$$ValueFailureMultilineStringCopyWithImpl<T, $Res>
    extends _$ValueFailureCopyWithImpl<T, $Res,
        _$ValueFailureMultilineString<T>>
    implements _$$ValueFailureMultilineStringCopyWith<T, $Res> {
  __$$ValueFailureMultilineStringCopyWithImpl(
      _$ValueFailureMultilineString<T> _value,
      $Res Function(_$ValueFailureMultilineString<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failedValue = null,
  }) {
    return _then(_$ValueFailureMultilineString<T>(
      failedValue: null == failedValue
          ? _value.failedValue
          : failedValue // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ValueFailureMultilineString<T>
    implements ValueFailureMultilineString<T> {
  const _$ValueFailureMultilineString({required this.failedValue});

  @override
  final String failedValue;

  @override
  String toString() {
    return 'ValueFailure<$T>.multilineString(failedValue: $failedValue)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValueFailureMultilineString<T> &&
            (identical(other.failedValue, failedValue) ||
                other.failedValue == failedValue));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failedValue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ValueFailureMultilineStringCopyWith<T, _$ValueFailureMultilineString<T>>
      get copyWith => __$$ValueFailureMultilineStringCopyWithImpl<T,
          _$ValueFailureMultilineString<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T failedValue, int max) exceedingLength,
    required TResult Function(T failedValue, int min) deficiencyLength,
    required TResult Function(String failedValue) empty,
    required TResult Function(String failedValue) multilineString,
    required TResult Function(T failedValue, num min) numberTooSmall,
    required TResult Function(T failedValue, num max) numberTooLarge,
    required TResult Function(String failedValue) invalidEmail,
  }) {
    return multilineString(failedValue);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T failedValue, int max)? exceedingLength,
    TResult? Function(T failedValue, int min)? deficiencyLength,
    TResult? Function(String failedValue)? empty,
    TResult? Function(String failedValue)? multilineString,
    TResult? Function(T failedValue, num min)? numberTooSmall,
    TResult? Function(T failedValue, num max)? numberTooLarge,
    TResult? Function(String failedValue)? invalidEmail,
  }) {
    return multilineString?.call(failedValue);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T failedValue, int max)? exceedingLength,
    TResult Function(T failedValue, int min)? deficiencyLength,
    TResult Function(String failedValue)? empty,
    TResult Function(String failedValue)? multilineString,
    TResult Function(T failedValue, num min)? numberTooSmall,
    TResult Function(T failedValue, num max)? numberTooLarge,
    TResult Function(String failedValue)? invalidEmail,
    required TResult orElse(),
  }) {
    if (multilineString != null) {
      return multilineString(failedValue);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValueFailureExceedingLength<T> value)
        exceedingLength,
    required TResult Function(ValueFailureDeficiencyLength<T> value)
        deficiencyLength,
    required TResult Function(ValueFailureEmptyString<T> value) empty,
    required TResult Function(ValueFailureMultilineString<T> value)
        multilineString,
    required TResult Function(ValueFailureNumberTooSmall<T> value)
        numberTooSmall,
    required TResult Function(ValueFailureNumberTooLarge<T> value)
        numberTooLarge,
    required TResult Function(ValueFailureInvalidEmail<T> value) invalidEmail,
  }) {
    return multilineString(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValueFailureExceedingLength<T> value)? exceedingLength,
    TResult? Function(ValueFailureDeficiencyLength<T> value)? deficiencyLength,
    TResult? Function(ValueFailureEmptyString<T> value)? empty,
    TResult? Function(ValueFailureMultilineString<T> value)? multilineString,
    TResult? Function(ValueFailureNumberTooSmall<T> value)? numberTooSmall,
    TResult? Function(ValueFailureNumberTooLarge<T> value)? numberTooLarge,
    TResult? Function(ValueFailureInvalidEmail<T> value)? invalidEmail,
  }) {
    return multilineString?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValueFailureExceedingLength<T> value)? exceedingLength,
    TResult Function(ValueFailureDeficiencyLength<T> value)? deficiencyLength,
    TResult Function(ValueFailureEmptyString<T> value)? empty,
    TResult Function(ValueFailureMultilineString<T> value)? multilineString,
    TResult Function(ValueFailureNumberTooSmall<T> value)? numberTooSmall,
    TResult Function(ValueFailureNumberTooLarge<T> value)? numberTooLarge,
    TResult Function(ValueFailureInvalidEmail<T> value)? invalidEmail,
    required TResult orElse(),
  }) {
    if (multilineString != null) {
      return multilineString(this);
    }
    return orElse();
  }
}

abstract class ValueFailureMultilineString<T> implements ValueFailure<T> {
  const factory ValueFailureMultilineString(
      {required final String failedValue}) = _$ValueFailureMultilineString<T>;

  @override
  String get failedValue;
  @JsonKey(ignore: true)
  _$$ValueFailureMultilineStringCopyWith<T, _$ValueFailureMultilineString<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValueFailureNumberTooSmallCopyWith<T, $Res> {
  factory _$$ValueFailureNumberTooSmallCopyWith(
          _$ValueFailureNumberTooSmall<T> value,
          $Res Function(_$ValueFailureNumberTooSmall<T>) then) =
      __$$ValueFailureNumberTooSmallCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T failedValue, num min});
}

/// @nodoc
class __$$ValueFailureNumberTooSmallCopyWithImpl<T, $Res>
    extends _$ValueFailureCopyWithImpl<T, $Res, _$ValueFailureNumberTooSmall<T>>
    implements _$$ValueFailureNumberTooSmallCopyWith<T, $Res> {
  __$$ValueFailureNumberTooSmallCopyWithImpl(
      _$ValueFailureNumberTooSmall<T> _value,
      $Res Function(_$ValueFailureNumberTooSmall<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failedValue = freezed,
    Object? min = null,
  }) {
    return _then(_$ValueFailureNumberTooSmall<T>(
      failedValue: freezed == failedValue
          ? _value.failedValue
          : failedValue // ignore: cast_nullable_to_non_nullable
              as T,
      min: null == min
          ? _value.min
          : min // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc

class _$ValueFailureNumberTooSmall<T> implements ValueFailureNumberTooSmall<T> {
  const _$ValueFailureNumberTooSmall(
      {required this.failedValue, required this.min});

  @override
  final T failedValue;
  @override
  final num min;

  @override
  String toString() {
    return 'ValueFailure<$T>.numberTooSmall(failedValue: $failedValue, min: $min)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValueFailureNumberTooSmall<T> &&
            const DeepCollectionEquality()
                .equals(other.failedValue, failedValue) &&
            (identical(other.min, min) || other.min == min));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(failedValue), min);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ValueFailureNumberTooSmallCopyWith<T, _$ValueFailureNumberTooSmall<T>>
      get copyWith => __$$ValueFailureNumberTooSmallCopyWithImpl<T,
          _$ValueFailureNumberTooSmall<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T failedValue, int max) exceedingLength,
    required TResult Function(T failedValue, int min) deficiencyLength,
    required TResult Function(String failedValue) empty,
    required TResult Function(String failedValue) multilineString,
    required TResult Function(T failedValue, num min) numberTooSmall,
    required TResult Function(T failedValue, num max) numberTooLarge,
    required TResult Function(String failedValue) invalidEmail,
  }) {
    return numberTooSmall(failedValue, min);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T failedValue, int max)? exceedingLength,
    TResult? Function(T failedValue, int min)? deficiencyLength,
    TResult? Function(String failedValue)? empty,
    TResult? Function(String failedValue)? multilineString,
    TResult? Function(T failedValue, num min)? numberTooSmall,
    TResult? Function(T failedValue, num max)? numberTooLarge,
    TResult? Function(String failedValue)? invalidEmail,
  }) {
    return numberTooSmall?.call(failedValue, min);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T failedValue, int max)? exceedingLength,
    TResult Function(T failedValue, int min)? deficiencyLength,
    TResult Function(String failedValue)? empty,
    TResult Function(String failedValue)? multilineString,
    TResult Function(T failedValue, num min)? numberTooSmall,
    TResult Function(T failedValue, num max)? numberTooLarge,
    TResult Function(String failedValue)? invalidEmail,
    required TResult orElse(),
  }) {
    if (numberTooSmall != null) {
      return numberTooSmall(failedValue, min);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValueFailureExceedingLength<T> value)
        exceedingLength,
    required TResult Function(ValueFailureDeficiencyLength<T> value)
        deficiencyLength,
    required TResult Function(ValueFailureEmptyString<T> value) empty,
    required TResult Function(ValueFailureMultilineString<T> value)
        multilineString,
    required TResult Function(ValueFailureNumberTooSmall<T> value)
        numberTooSmall,
    required TResult Function(ValueFailureNumberTooLarge<T> value)
        numberTooLarge,
    required TResult Function(ValueFailureInvalidEmail<T> value) invalidEmail,
  }) {
    return numberTooSmall(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValueFailureExceedingLength<T> value)? exceedingLength,
    TResult? Function(ValueFailureDeficiencyLength<T> value)? deficiencyLength,
    TResult? Function(ValueFailureEmptyString<T> value)? empty,
    TResult? Function(ValueFailureMultilineString<T> value)? multilineString,
    TResult? Function(ValueFailureNumberTooSmall<T> value)? numberTooSmall,
    TResult? Function(ValueFailureNumberTooLarge<T> value)? numberTooLarge,
    TResult? Function(ValueFailureInvalidEmail<T> value)? invalidEmail,
  }) {
    return numberTooSmall?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValueFailureExceedingLength<T> value)? exceedingLength,
    TResult Function(ValueFailureDeficiencyLength<T> value)? deficiencyLength,
    TResult Function(ValueFailureEmptyString<T> value)? empty,
    TResult Function(ValueFailureMultilineString<T> value)? multilineString,
    TResult Function(ValueFailureNumberTooSmall<T> value)? numberTooSmall,
    TResult Function(ValueFailureNumberTooLarge<T> value)? numberTooLarge,
    TResult Function(ValueFailureInvalidEmail<T> value)? invalidEmail,
    required TResult orElse(),
  }) {
    if (numberTooSmall != null) {
      return numberTooSmall(this);
    }
    return orElse();
  }
}

abstract class ValueFailureNumberTooSmall<T> implements ValueFailure<T> {
  const factory ValueFailureNumberTooSmall(
      {required final T failedValue,
      required final num min}) = _$ValueFailureNumberTooSmall<T>;

  @override
  T get failedValue;
  num get min;
  @JsonKey(ignore: true)
  _$$ValueFailureNumberTooSmallCopyWith<T, _$ValueFailureNumberTooSmall<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValueFailureNumberTooLargeCopyWith<T, $Res> {
  factory _$$ValueFailureNumberTooLargeCopyWith(
          _$ValueFailureNumberTooLarge<T> value,
          $Res Function(_$ValueFailureNumberTooLarge<T>) then) =
      __$$ValueFailureNumberTooLargeCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T failedValue, num max});
}

/// @nodoc
class __$$ValueFailureNumberTooLargeCopyWithImpl<T, $Res>
    extends _$ValueFailureCopyWithImpl<T, $Res, _$ValueFailureNumberTooLarge<T>>
    implements _$$ValueFailureNumberTooLargeCopyWith<T, $Res> {
  __$$ValueFailureNumberTooLargeCopyWithImpl(
      _$ValueFailureNumberTooLarge<T> _value,
      $Res Function(_$ValueFailureNumberTooLarge<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failedValue = freezed,
    Object? max = null,
  }) {
    return _then(_$ValueFailureNumberTooLarge<T>(
      failedValue: freezed == failedValue
          ? _value.failedValue
          : failedValue // ignore: cast_nullable_to_non_nullable
              as T,
      max: null == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc

class _$ValueFailureNumberTooLarge<T> implements ValueFailureNumberTooLarge<T> {
  const _$ValueFailureNumberTooLarge(
      {required this.failedValue, required this.max});

  @override
  final T failedValue;
  @override
  final num max;

  @override
  String toString() {
    return 'ValueFailure<$T>.numberTooLarge(failedValue: $failedValue, max: $max)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValueFailureNumberTooLarge<T> &&
            const DeepCollectionEquality()
                .equals(other.failedValue, failedValue) &&
            (identical(other.max, max) || other.max == max));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(failedValue), max);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ValueFailureNumberTooLargeCopyWith<T, _$ValueFailureNumberTooLarge<T>>
      get copyWith => __$$ValueFailureNumberTooLargeCopyWithImpl<T,
          _$ValueFailureNumberTooLarge<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T failedValue, int max) exceedingLength,
    required TResult Function(T failedValue, int min) deficiencyLength,
    required TResult Function(String failedValue) empty,
    required TResult Function(String failedValue) multilineString,
    required TResult Function(T failedValue, num min) numberTooSmall,
    required TResult Function(T failedValue, num max) numberTooLarge,
    required TResult Function(String failedValue) invalidEmail,
  }) {
    return numberTooLarge(failedValue, max);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T failedValue, int max)? exceedingLength,
    TResult? Function(T failedValue, int min)? deficiencyLength,
    TResult? Function(String failedValue)? empty,
    TResult? Function(String failedValue)? multilineString,
    TResult? Function(T failedValue, num min)? numberTooSmall,
    TResult? Function(T failedValue, num max)? numberTooLarge,
    TResult? Function(String failedValue)? invalidEmail,
  }) {
    return numberTooLarge?.call(failedValue, max);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T failedValue, int max)? exceedingLength,
    TResult Function(T failedValue, int min)? deficiencyLength,
    TResult Function(String failedValue)? empty,
    TResult Function(String failedValue)? multilineString,
    TResult Function(T failedValue, num min)? numberTooSmall,
    TResult Function(T failedValue, num max)? numberTooLarge,
    TResult Function(String failedValue)? invalidEmail,
    required TResult orElse(),
  }) {
    if (numberTooLarge != null) {
      return numberTooLarge(failedValue, max);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValueFailureExceedingLength<T> value)
        exceedingLength,
    required TResult Function(ValueFailureDeficiencyLength<T> value)
        deficiencyLength,
    required TResult Function(ValueFailureEmptyString<T> value) empty,
    required TResult Function(ValueFailureMultilineString<T> value)
        multilineString,
    required TResult Function(ValueFailureNumberTooSmall<T> value)
        numberTooSmall,
    required TResult Function(ValueFailureNumberTooLarge<T> value)
        numberTooLarge,
    required TResult Function(ValueFailureInvalidEmail<T> value) invalidEmail,
  }) {
    return numberTooLarge(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValueFailureExceedingLength<T> value)? exceedingLength,
    TResult? Function(ValueFailureDeficiencyLength<T> value)? deficiencyLength,
    TResult? Function(ValueFailureEmptyString<T> value)? empty,
    TResult? Function(ValueFailureMultilineString<T> value)? multilineString,
    TResult? Function(ValueFailureNumberTooSmall<T> value)? numberTooSmall,
    TResult? Function(ValueFailureNumberTooLarge<T> value)? numberTooLarge,
    TResult? Function(ValueFailureInvalidEmail<T> value)? invalidEmail,
  }) {
    return numberTooLarge?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValueFailureExceedingLength<T> value)? exceedingLength,
    TResult Function(ValueFailureDeficiencyLength<T> value)? deficiencyLength,
    TResult Function(ValueFailureEmptyString<T> value)? empty,
    TResult Function(ValueFailureMultilineString<T> value)? multilineString,
    TResult Function(ValueFailureNumberTooSmall<T> value)? numberTooSmall,
    TResult Function(ValueFailureNumberTooLarge<T> value)? numberTooLarge,
    TResult Function(ValueFailureInvalidEmail<T> value)? invalidEmail,
    required TResult orElse(),
  }) {
    if (numberTooLarge != null) {
      return numberTooLarge(this);
    }
    return orElse();
  }
}

abstract class ValueFailureNumberTooLarge<T> implements ValueFailure<T> {
  const factory ValueFailureNumberTooLarge(
      {required final T failedValue,
      required final num max}) = _$ValueFailureNumberTooLarge<T>;

  @override
  T get failedValue;
  num get max;
  @JsonKey(ignore: true)
  _$$ValueFailureNumberTooLargeCopyWith<T, _$ValueFailureNumberTooLarge<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValueFailureInvalidEmailCopyWith<T, $Res> {
  factory _$$ValueFailureInvalidEmailCopyWith(
          _$ValueFailureInvalidEmail<T> value,
          $Res Function(_$ValueFailureInvalidEmail<T>) then) =
      __$$ValueFailureInvalidEmailCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String failedValue});
}

/// @nodoc
class __$$ValueFailureInvalidEmailCopyWithImpl<T, $Res>
    extends _$ValueFailureCopyWithImpl<T, $Res, _$ValueFailureInvalidEmail<T>>
    implements _$$ValueFailureInvalidEmailCopyWith<T, $Res> {
  __$$ValueFailureInvalidEmailCopyWithImpl(_$ValueFailureInvalidEmail<T> _value,
      $Res Function(_$ValueFailureInvalidEmail<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failedValue = null,
  }) {
    return _then(_$ValueFailureInvalidEmail<T>(
      failedValue: null == failedValue
          ? _value.failedValue
          : failedValue // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ValueFailureInvalidEmail<T> implements ValueFailureInvalidEmail<T> {
  const _$ValueFailureInvalidEmail({required this.failedValue});

  @override
  final String failedValue;

  @override
  String toString() {
    return 'ValueFailure<$T>.invalidEmail(failedValue: $failedValue)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValueFailureInvalidEmail<T> &&
            (identical(other.failedValue, failedValue) ||
                other.failedValue == failedValue));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failedValue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ValueFailureInvalidEmailCopyWith<T, _$ValueFailureInvalidEmail<T>>
      get copyWith => __$$ValueFailureInvalidEmailCopyWithImpl<T,
          _$ValueFailureInvalidEmail<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T failedValue, int max) exceedingLength,
    required TResult Function(T failedValue, int min) deficiencyLength,
    required TResult Function(String failedValue) empty,
    required TResult Function(String failedValue) multilineString,
    required TResult Function(T failedValue, num min) numberTooSmall,
    required TResult Function(T failedValue, num max) numberTooLarge,
    required TResult Function(String failedValue) invalidEmail,
  }) {
    return invalidEmail(failedValue);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T failedValue, int max)? exceedingLength,
    TResult? Function(T failedValue, int min)? deficiencyLength,
    TResult? Function(String failedValue)? empty,
    TResult? Function(String failedValue)? multilineString,
    TResult? Function(T failedValue, num min)? numberTooSmall,
    TResult? Function(T failedValue, num max)? numberTooLarge,
    TResult? Function(String failedValue)? invalidEmail,
  }) {
    return invalidEmail?.call(failedValue);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T failedValue, int max)? exceedingLength,
    TResult Function(T failedValue, int min)? deficiencyLength,
    TResult Function(String failedValue)? empty,
    TResult Function(String failedValue)? multilineString,
    TResult Function(T failedValue, num min)? numberTooSmall,
    TResult Function(T failedValue, num max)? numberTooLarge,
    TResult Function(String failedValue)? invalidEmail,
    required TResult orElse(),
  }) {
    if (invalidEmail != null) {
      return invalidEmail(failedValue);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValueFailureExceedingLength<T> value)
        exceedingLength,
    required TResult Function(ValueFailureDeficiencyLength<T> value)
        deficiencyLength,
    required TResult Function(ValueFailureEmptyString<T> value) empty,
    required TResult Function(ValueFailureMultilineString<T> value)
        multilineString,
    required TResult Function(ValueFailureNumberTooSmall<T> value)
        numberTooSmall,
    required TResult Function(ValueFailureNumberTooLarge<T> value)
        numberTooLarge,
    required TResult Function(ValueFailureInvalidEmail<T> value) invalidEmail,
  }) {
    return invalidEmail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValueFailureExceedingLength<T> value)? exceedingLength,
    TResult? Function(ValueFailureDeficiencyLength<T> value)? deficiencyLength,
    TResult? Function(ValueFailureEmptyString<T> value)? empty,
    TResult? Function(ValueFailureMultilineString<T> value)? multilineString,
    TResult? Function(ValueFailureNumberTooSmall<T> value)? numberTooSmall,
    TResult? Function(ValueFailureNumberTooLarge<T> value)? numberTooLarge,
    TResult? Function(ValueFailureInvalidEmail<T> value)? invalidEmail,
  }) {
    return invalidEmail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValueFailureExceedingLength<T> value)? exceedingLength,
    TResult Function(ValueFailureDeficiencyLength<T> value)? deficiencyLength,
    TResult Function(ValueFailureEmptyString<T> value)? empty,
    TResult Function(ValueFailureMultilineString<T> value)? multilineString,
    TResult Function(ValueFailureNumberTooSmall<T> value)? numberTooSmall,
    TResult Function(ValueFailureNumberTooLarge<T> value)? numberTooLarge,
    TResult Function(ValueFailureInvalidEmail<T> value)? invalidEmail,
    required TResult orElse(),
  }) {
    if (invalidEmail != null) {
      return invalidEmail(this);
    }
    return orElse();
  }
}

abstract class ValueFailureInvalidEmail<T> implements ValueFailure<T> {
  const factory ValueFailureInvalidEmail({required final String failedValue}) =
      _$ValueFailureInvalidEmail<T>;

  @override
  String get failedValue;
  @JsonKey(ignore: true)
  _$$ValueFailureInvalidEmailCopyWith<T, _$ValueFailureInvalidEmail<T>>
      get copyWith => throw _privateConstructorUsedError;
}
