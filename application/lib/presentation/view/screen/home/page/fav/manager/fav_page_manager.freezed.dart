// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'fav_page_manager.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FavPageState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<TalesPageItemData> tales,
            List<Person> people, DateTime timestamp)
        ready,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<TalesPageItemData> tales, List<Person> people,
            DateTime timestamp)?
        ready,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<TalesPageItemData> tales, List<Person> people,
            DateTime timestamp)?
        ready,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(FavPageStateReady value) ready,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(FavPageStateReady value)? ready,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(FavPageStateReady value)? ready,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavPageStateCopyWith<$Res> {
  factory $FavPageStateCopyWith(
          FavPageState value, $Res Function(FavPageState) then) =
      _$FavPageStateCopyWithImpl<$Res, FavPageState>;
}

/// @nodoc
class _$FavPageStateCopyWithImpl<$Res, $Val extends FavPageState>
    implements $FavPageStateCopyWith<$Res> {
  _$FavPageStateCopyWithImpl(this._value, this._then);

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
    extends _$FavPageStateCopyWithImpl<$Res, _$_Initial>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial();

  @override
  String toString() {
    return 'FavPageState.initial()';
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
    required TResult Function(List<TalesPageItemData> tales,
            List<Person> people, DateTime timestamp)
        ready,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<TalesPageItemData> tales, List<Person> people,
            DateTime timestamp)?
        ready,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<TalesPageItemData> tales, List<Person> people,
            DateTime timestamp)?
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
    required TResult Function(FavPageStateReady value) ready,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(FavPageStateReady value)? ready,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(FavPageStateReady value)? ready,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements FavPageState {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$$FavPageStateReadyCopyWith<$Res> {
  factory _$$FavPageStateReadyCopyWith(
          _$FavPageStateReady value, $Res Function(_$FavPageStateReady) then) =
      __$$FavPageStateReadyCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<TalesPageItemData> tales, List<Person> people, DateTime timestamp});
}

/// @nodoc
class __$$FavPageStateReadyCopyWithImpl<$Res>
    extends _$FavPageStateCopyWithImpl<$Res, _$FavPageStateReady>
    implements _$$FavPageStateReadyCopyWith<$Res> {
  __$$FavPageStateReadyCopyWithImpl(
      _$FavPageStateReady _value, $Res Function(_$FavPageStateReady) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tales = null,
    Object? people = null,
    Object? timestamp = null,
  }) {
    return _then(_$FavPageStateReady(
      tales: null == tales
          ? _value._tales
          : tales // ignore: cast_nullable_to_non_nullable
              as List<TalesPageItemData>,
      people: null == people
          ? _value._people
          : people // ignore: cast_nullable_to_non_nullable
              as List<Person>,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$FavPageStateReady implements FavPageStateReady {
  const _$FavPageStateReady(
      {required final List<TalesPageItemData> tales,
      required final List<Person> people,
      required this.timestamp})
      : _tales = tales,
        _people = people;

  final List<TalesPageItemData> _tales;
  @override
  List<TalesPageItemData> get tales {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tales);
  }

  final List<Person> _people;
  @override
  List<Person> get people {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_people);
  }

  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'FavPageState.ready(tales: $tales, people: $people, timestamp: $timestamp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavPageStateReady &&
            const DeepCollectionEquality().equals(other._tales, _tales) &&
            const DeepCollectionEquality().equals(other._people, _people) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_tales),
      const DeepCollectionEquality().hash(_people),
      timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FavPageStateReadyCopyWith<_$FavPageStateReady> get copyWith =>
      __$$FavPageStateReadyCopyWithImpl<_$FavPageStateReady>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<TalesPageItemData> tales,
            List<Person> people, DateTime timestamp)
        ready,
  }) {
    return ready(tales, people, timestamp);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<TalesPageItemData> tales, List<Person> people,
            DateTime timestamp)?
        ready,
  }) {
    return ready?.call(tales, people, timestamp);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<TalesPageItemData> tales, List<Person> people,
            DateTime timestamp)?
        ready,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(tales, people, timestamp);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(FavPageStateReady value) ready,
  }) {
    return ready(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(FavPageStateReady value)? ready,
  }) {
    return ready?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(FavPageStateReady value)? ready,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(this);
    }
    return orElse();
  }
}

abstract class FavPageStateReady implements FavPageState {
  const factory FavPageStateReady(
      {required final List<TalesPageItemData> tales,
      required final List<Person> people,
      required final DateTime timestamp}) = _$FavPageStateReady;

  List<TalesPageItemData> get tales;
  List<Person> get people;
  DateTime get timestamp;
  @JsonKey(ignore: true)
  _$$FavPageStateReadyCopyWith<_$FavPageStateReady> get copyWith =>
      throw _privateConstructorUsedError;
}
