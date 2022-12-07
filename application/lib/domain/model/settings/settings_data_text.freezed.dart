// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'settings_data_text.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SettingsDataText {
  TextScaleFactor get textScaleFactor => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SettingsDataTextCopyWith<SettingsDataText> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsDataTextCopyWith<$Res> {
  factory $SettingsDataTextCopyWith(
          SettingsDataText value, $Res Function(SettingsDataText) then) =
      _$SettingsDataTextCopyWithImpl<$Res, SettingsDataText>;
  @useResult
  $Res call({TextScaleFactor textScaleFactor});
}

/// @nodoc
class _$SettingsDataTextCopyWithImpl<$Res, $Val extends SettingsDataText>
    implements $SettingsDataTextCopyWith<$Res> {
  _$SettingsDataTextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textScaleFactor = null,
  }) {
    return _then(_value.copyWith(
      textScaleFactor: null == textScaleFactor
          ? _value.textScaleFactor
          : textScaleFactor // ignore: cast_nullable_to_non_nullable
              as TextScaleFactor,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SettingsDataTextCopyWith<$Res>
    implements $SettingsDataTextCopyWith<$Res> {
  factory _$$_SettingsDataTextCopyWith(
          _$_SettingsDataText value, $Res Function(_$_SettingsDataText) then) =
      __$$_SettingsDataTextCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TextScaleFactor textScaleFactor});
}

/// @nodoc
class __$$_SettingsDataTextCopyWithImpl<$Res>
    extends _$SettingsDataTextCopyWithImpl<$Res, _$_SettingsDataText>
    implements _$$_SettingsDataTextCopyWith<$Res> {
  __$$_SettingsDataTextCopyWithImpl(
      _$_SettingsDataText _value, $Res Function(_$_SettingsDataText) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textScaleFactor = null,
  }) {
    return _then(_$_SettingsDataText(
      textScaleFactor: null == textScaleFactor
          ? _value.textScaleFactor
          : textScaleFactor // ignore: cast_nullable_to_non_nullable
              as TextScaleFactor,
    ));
  }
}

/// @nodoc

class _$_SettingsDataText implements _SettingsDataText {
  const _$_SettingsDataText({this.textScaleFactor = TextScaleFactor.m});

  @override
  @JsonKey()
  final TextScaleFactor textScaleFactor;

  @override
  String toString() {
    return 'SettingsDataText(textScaleFactor: $textScaleFactor)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SettingsDataText &&
            (identical(other.textScaleFactor, textScaleFactor) ||
                other.textScaleFactor == textScaleFactor));
  }

  @override
  int get hashCode => Object.hash(runtimeType, textScaleFactor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SettingsDataTextCopyWith<_$_SettingsDataText> get copyWith =>
      __$$_SettingsDataTextCopyWithImpl<_$_SettingsDataText>(this, _$identity);
}

abstract class _SettingsDataText implements SettingsDataText {
  const factory _SettingsDataText({final TextScaleFactor textScaleFactor}) =
      _$_SettingsDataText;

  @override
  TextScaleFactor get textScaleFactor;
  @override
  @JsonKey(ignore: true)
  _$$_SettingsDataTextCopyWith<_$_SettingsDataText> get copyWith =>
      throw _privateConstructorUsedError;
}
