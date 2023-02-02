// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'person_screen_manager.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PersonScreenState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Person person,
            List<PersonTalesTabData> tabDataList, DateTime? timestamp)
        ready,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(Person person, List<PersonTalesTabData> tabDataList,
            DateTime? timestamp)?
        ready,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Person person, List<PersonTalesTabData> tabDataList,
            DateTime? timestamp)?
        ready,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(PersonScreenStateReady value) ready,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(PersonScreenStateReady value)? ready,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(PersonScreenStateReady value)? ready,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PersonScreenStateCopyWith<$Res> {
  factory $PersonScreenStateCopyWith(
          PersonScreenState value, $Res Function(PersonScreenState) then) =
      _$PersonScreenStateCopyWithImpl<$Res, PersonScreenState>;
}

/// @nodoc
class _$PersonScreenStateCopyWithImpl<$Res, $Val extends PersonScreenState>
    implements $PersonScreenStateCopyWith<$Res> {
  _$PersonScreenStateCopyWithImpl(this._value, this._then);

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
    extends _$PersonScreenStateCopyWithImpl<$Res, _$_Initial>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial();

  @override
  String toString() {
    return 'PersonScreenState.initial()';
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
    required TResult Function(Person person,
            List<PersonTalesTabData> tabDataList, DateTime? timestamp)
        ready,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(Person person, List<PersonTalesTabData> tabDataList,
            DateTime? timestamp)?
        ready,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Person person, List<PersonTalesTabData> tabDataList,
            DateTime? timestamp)?
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
    required TResult Function(PersonScreenStateReady value) ready,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(PersonScreenStateReady value)? ready,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(PersonScreenStateReady value)? ready,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements PersonScreenState {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$$PersonScreenStateReadyCopyWith<$Res> {
  factory _$$PersonScreenStateReadyCopyWith(_$PersonScreenStateReady value,
          $Res Function(_$PersonScreenStateReady) then) =
      __$$PersonScreenStateReadyCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {Person person,
      List<PersonTalesTabData> tabDataList,
      DateTime? timestamp});
}

/// @nodoc
class __$$PersonScreenStateReadyCopyWithImpl<$Res>
    extends _$PersonScreenStateCopyWithImpl<$Res, _$PersonScreenStateReady>
    implements _$$PersonScreenStateReadyCopyWith<$Res> {
  __$$PersonScreenStateReadyCopyWithImpl(_$PersonScreenStateReady _value,
      $Res Function(_$PersonScreenStateReady) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? person = null,
    Object? tabDataList = null,
    Object? timestamp = freezed,
  }) {
    return _then(_$PersonScreenStateReady(
      person: null == person
          ? _value.person
          : person // ignore: cast_nullable_to_non_nullable
              as Person,
      tabDataList: null == tabDataList
          ? _value._tabDataList
          : tabDataList // ignore: cast_nullable_to_non_nullable
              as List<PersonTalesTabData>,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$PersonScreenStateReady implements PersonScreenStateReady {
  const _$PersonScreenStateReady(
      {required this.person,
      required final List<PersonTalesTabData> tabDataList,
      this.timestamp})
      : _tabDataList = tabDataList;

  @override
  final Person person;
  final List<PersonTalesTabData> _tabDataList;
  @override
  List<PersonTalesTabData> get tabDataList {
    if (_tabDataList is EqualUnmodifiableListView) return _tabDataList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tabDataList);
  }

  @override
  final DateTime? timestamp;

  @override
  String toString() {
    return 'PersonScreenState.ready(person: $person, tabDataList: $tabDataList, timestamp: $timestamp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PersonScreenStateReady &&
            (identical(other.person, person) || other.person == person) &&
            const DeepCollectionEquality()
                .equals(other._tabDataList, _tabDataList) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @override
  int get hashCode => Object.hash(runtimeType, person,
      const DeepCollectionEquality().hash(_tabDataList), timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PersonScreenStateReadyCopyWith<_$PersonScreenStateReady> get copyWith =>
      __$$PersonScreenStateReadyCopyWithImpl<_$PersonScreenStateReady>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Person person,
            List<PersonTalesTabData> tabDataList, DateTime? timestamp)
        ready,
  }) {
    return ready(person, tabDataList, timestamp);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(Person person, List<PersonTalesTabData> tabDataList,
            DateTime? timestamp)?
        ready,
  }) {
    return ready?.call(person, tabDataList, timestamp);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Person person, List<PersonTalesTabData> tabDataList,
            DateTime? timestamp)?
        ready,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(person, tabDataList, timestamp);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(PersonScreenStateReady value) ready,
  }) {
    return ready(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(PersonScreenStateReady value)? ready,
  }) {
    return ready?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(PersonScreenStateReady value)? ready,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(this);
    }
    return orElse();
  }
}

abstract class PersonScreenStateReady implements PersonScreenState {
  const factory PersonScreenStateReady(
      {required final Person person,
      required final List<PersonTalesTabData> tabDataList,
      final DateTime? timestamp}) = _$PersonScreenStateReady;

  Person get person;
  List<PersonTalesTabData> get tabDataList;
  DateTime? get timestamp;
  @JsonKey(ignore: true)
  _$$PersonScreenStateReadyCopyWith<_$PersonScreenStateReady> get copyWith =>
      throw _privateConstructorUsedError;
}
