// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tale_screen_manager.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TaleScreenState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(TaleSwitchType switchType, TalePageType pageType,
            Tale tale, IntPositive chapterIndex)
        ready,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(TaleSwitchType switchType, TalePageType pageType,
            Tale tale, IntPositive chapterIndex)?
        ready,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(TaleSwitchType switchType, TalePageType pageType,
            Tale tale, IntPositive chapterIndex)?
        ready,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(TaleScreenStateReady value) ready,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(TaleScreenStateReady value)? ready,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(TaleScreenStateReady value)? ready,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaleScreenStateCopyWith<$Res> {
  factory $TaleScreenStateCopyWith(
          TaleScreenState value, $Res Function(TaleScreenState) then) =
      _$TaleScreenStateCopyWithImpl<$Res, TaleScreenState>;
}

/// @nodoc
class _$TaleScreenStateCopyWithImpl<$Res, $Val extends TaleScreenState>
    implements $TaleScreenStateCopyWith<$Res> {
  _$TaleScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res>
    extends _$TaleScreenStateCopyWithImpl<$Res, _$_Initial>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial();

  @override
  String toString() {
    return 'TaleScreenState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(TaleSwitchType switchType, TalePageType pageType,
            Tale tale, IntPositive chapterIndex)
        ready,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(TaleSwitchType switchType, TalePageType pageType,
            Tale tale, IntPositive chapterIndex)?
        ready,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(TaleSwitchType switchType, TalePageType pageType,
            Tale tale, IntPositive chapterIndex)?
        ready,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(TaleScreenStateReady value) ready,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(TaleScreenStateReady value)? ready,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(TaleScreenStateReady value)? ready,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements TaleScreenState {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$$TaleScreenStateReadyCopyWith<$Res> {
  factory _$$TaleScreenStateReadyCopyWith(_$TaleScreenStateReady value,
          $Res Function(_$TaleScreenStateReady) then) =
      __$$TaleScreenStateReadyCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {TaleSwitchType switchType,
      TalePageType pageType,
      Tale tale,
      IntPositive chapterIndex});
}

/// @nodoc
class __$$TaleScreenStateReadyCopyWithImpl<$Res>
    extends _$TaleScreenStateCopyWithImpl<$Res, _$TaleScreenStateReady>
    implements _$$TaleScreenStateReadyCopyWith<$Res> {
  __$$TaleScreenStateReadyCopyWithImpl(_$TaleScreenStateReady _value,
      $Res Function(_$TaleScreenStateReady) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? switchType = null,
    Object? pageType = null,
    Object? tale = null,
    Object? chapterIndex = null,
  }) {
    return _then(_$TaleScreenStateReady(
      switchType: null == switchType
          ? _value.switchType
          : switchType // ignore: cast_nullable_to_non_nullable
              as TaleSwitchType,
      pageType: null == pageType
          ? _value.pageType
          : pageType // ignore: cast_nullable_to_non_nullable
              as TalePageType,
      tale: null == tale
          ? _value.tale
          : tale // ignore: cast_nullable_to_non_nullable
              as Tale,
      chapterIndex: null == chapterIndex
          ? _value.chapterIndex
          : chapterIndex // ignore: cast_nullable_to_non_nullable
              as IntPositive,
    ));
  }
}

/// @nodoc

class _$TaleScreenStateReady implements TaleScreenStateReady {
  const _$TaleScreenStateReady(
      {required this.switchType,
      required this.pageType,
      required this.tale,
      required this.chapterIndex});

  @override
  final TaleSwitchType switchType;
  @override
  final TalePageType pageType;
  @override
  final Tale tale;
  @override
  final IntPositive chapterIndex;

  @override
  String toString() {
    return 'TaleScreenState.ready(switchType: $switchType, pageType: $pageType, tale: $tale, chapterIndex: $chapterIndex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaleScreenStateReady &&
            (identical(other.switchType, switchType) ||
                other.switchType == switchType) &&
            (identical(other.pageType, pageType) ||
                other.pageType == pageType) &&
            (identical(other.tale, tale) || other.tale == tale) &&
            (identical(other.chapterIndex, chapterIndex) ||
                other.chapterIndex == chapterIndex));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, switchType, pageType, tale, chapterIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaleScreenStateReadyCopyWith<_$TaleScreenStateReady> get copyWith =>
      __$$TaleScreenStateReadyCopyWithImpl<_$TaleScreenStateReady>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(TaleSwitchType switchType, TalePageType pageType,
            Tale tale, IntPositive chapterIndex)
        ready,
  }) {
    return ready(switchType, pageType, tale, chapterIndex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(TaleSwitchType switchType, TalePageType pageType,
            Tale tale, IntPositive chapterIndex)?
        ready,
  }) {
    return ready?.call(switchType, pageType, tale, chapterIndex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(TaleSwitchType switchType, TalePageType pageType,
            Tale tale, IntPositive chapterIndex)?
        ready,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(switchType, pageType, tale, chapterIndex);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(TaleScreenStateReady value) ready,
  }) {
    return ready(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(TaleScreenStateReady value)? ready,
  }) {
    return ready?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(TaleScreenStateReady value)? ready,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(this);
    }
    return orElse();
  }
}

abstract class TaleScreenStateReady implements TaleScreenState {
  const factory TaleScreenStateReady(
      {required final TaleSwitchType switchType,
      required final TalePageType pageType,
      required final Tale tale,
      required final IntPositive chapterIndex}) = _$TaleScreenStateReady;

  TaleSwitchType get switchType;
  TalePageType get pageType;
  Tale get tale;
  IntPositive get chapterIndex;
  @JsonKey(ignore: true)
  _$$TaleScreenStateReadyCopyWith<_$TaleScreenStateReady> get copyWith =>
      throw _privateConstructorUsedError;
}
