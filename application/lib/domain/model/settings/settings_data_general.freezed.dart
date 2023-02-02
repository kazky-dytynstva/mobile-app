// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_data_general.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SettingsDataGeneral {
  AppTheme get appTheme => throw _privateConstructorUsedError;
  bool get isCrashLoggingEnabled => throw _privateConstructorUsedError;
  bool get isTrackingEnabled => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SettingsDataGeneralCopyWith<SettingsDataGeneral> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsDataGeneralCopyWith<$Res> {
  factory $SettingsDataGeneralCopyWith(
          SettingsDataGeneral value, $Res Function(SettingsDataGeneral) then) =
      _$SettingsDataGeneralCopyWithImpl<$Res, SettingsDataGeneral>;
  @useResult
  $Res call(
      {AppTheme appTheme, bool isCrashLoggingEnabled, bool isTrackingEnabled});
}

/// @nodoc
class _$SettingsDataGeneralCopyWithImpl<$Res, $Val extends SettingsDataGeneral>
    implements $SettingsDataGeneralCopyWith<$Res> {
  _$SettingsDataGeneralCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appTheme = null,
    Object? isCrashLoggingEnabled = null,
    Object? isTrackingEnabled = null,
  }) {
    return _then(_value.copyWith(
      appTheme: null == appTheme
          ? _value.appTheme
          : appTheme // ignore: cast_nullable_to_non_nullable
              as AppTheme,
      isCrashLoggingEnabled: null == isCrashLoggingEnabled
          ? _value.isCrashLoggingEnabled
          : isCrashLoggingEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isTrackingEnabled: null == isTrackingEnabled
          ? _value.isTrackingEnabled
          : isTrackingEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SettingsDataGeneralCopyWith<$Res>
    implements $SettingsDataGeneralCopyWith<$Res> {
  factory _$$_SettingsDataGeneralCopyWith(_$_SettingsDataGeneral value,
          $Res Function(_$_SettingsDataGeneral) then) =
      __$$_SettingsDataGeneralCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AppTheme appTheme, bool isCrashLoggingEnabled, bool isTrackingEnabled});
}

/// @nodoc
class __$$_SettingsDataGeneralCopyWithImpl<$Res>
    extends _$SettingsDataGeneralCopyWithImpl<$Res, _$_SettingsDataGeneral>
    implements _$$_SettingsDataGeneralCopyWith<$Res> {
  __$$_SettingsDataGeneralCopyWithImpl(_$_SettingsDataGeneral _value,
      $Res Function(_$_SettingsDataGeneral) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appTheme = null,
    Object? isCrashLoggingEnabled = null,
    Object? isTrackingEnabled = null,
  }) {
    return _then(_$_SettingsDataGeneral(
      appTheme: null == appTheme
          ? _value.appTheme
          : appTheme // ignore: cast_nullable_to_non_nullable
              as AppTheme,
      isCrashLoggingEnabled: null == isCrashLoggingEnabled
          ? _value.isCrashLoggingEnabled
          : isCrashLoggingEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isTrackingEnabled: null == isTrackingEnabled
          ? _value.isTrackingEnabled
          : isTrackingEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_SettingsDataGeneral implements _SettingsDataGeneral {
  const _$_SettingsDataGeneral(
      {this.appTheme = AppTheme.system,
      this.isCrashLoggingEnabled = false,
      this.isTrackingEnabled = false});

  @override
  @JsonKey()
  final AppTheme appTheme;
  @override
  @JsonKey()
  final bool isCrashLoggingEnabled;
  @override
  @JsonKey()
  final bool isTrackingEnabled;

  @override
  String toString() {
    return 'SettingsDataGeneral(appTheme: $appTheme, isCrashLoggingEnabled: $isCrashLoggingEnabled, isTrackingEnabled: $isTrackingEnabled)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SettingsDataGeneral &&
            (identical(other.appTheme, appTheme) ||
                other.appTheme == appTheme) &&
            (identical(other.isCrashLoggingEnabled, isCrashLoggingEnabled) ||
                other.isCrashLoggingEnabled == isCrashLoggingEnabled) &&
            (identical(other.isTrackingEnabled, isTrackingEnabled) ||
                other.isTrackingEnabled == isTrackingEnabled));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, appTheme, isCrashLoggingEnabled, isTrackingEnabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SettingsDataGeneralCopyWith<_$_SettingsDataGeneral> get copyWith =>
      __$$_SettingsDataGeneralCopyWithImpl<_$_SettingsDataGeneral>(
          this, _$identity);
}

abstract class _SettingsDataGeneral implements SettingsDataGeneral {
  const factory _SettingsDataGeneral(
      {final AppTheme appTheme,
      final bool isCrashLoggingEnabled,
      final bool isTrackingEnabled}) = _$_SettingsDataGeneral;

  @override
  AppTheme get appTheme;
  @override
  bool get isCrashLoggingEnabled;
  @override
  bool get isTrackingEnabled;
  @override
  @JsonKey(ignore: true)
  _$$_SettingsDataGeneralCopyWith<_$_SettingsDataGeneral> get copyWith =>
      throw _privateConstructorUsedError;
}
