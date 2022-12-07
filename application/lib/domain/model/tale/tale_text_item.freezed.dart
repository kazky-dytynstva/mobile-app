// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'tale_text_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TaleTextItem {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StringNonEmpty text) text,
    required TResult Function(ImageUrl url) image,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(StringNonEmpty text)? text,
    TResult? Function(ImageUrl url)? image,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TaleTextParagraph value) text,
    required TResult Function(_TaleTextImage value) image,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TaleTextParagraph value)? text,
    TResult? Function(_TaleTextImage value)? image,
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaleTextItemCopyWith<$Res> {
  factory $TaleTextItemCopyWith(
          TaleTextItem value, $Res Function(TaleTextItem) then) =
      _$TaleTextItemCopyWithImpl<$Res, TaleTextItem>;
}

/// @nodoc
class _$TaleTextItemCopyWithImpl<$Res, $Val extends TaleTextItem>
    implements $TaleTextItemCopyWith<$Res> {
  _$TaleTextItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_TaleTextParagraphCopyWith<$Res> {
  factory _$$_TaleTextParagraphCopyWith(_$_TaleTextParagraph value,
          $Res Function(_$_TaleTextParagraph) then) =
      __$$_TaleTextParagraphCopyWithImpl<$Res>;
  @useResult
  $Res call({StringNonEmpty text});
}

/// @nodoc
class __$$_TaleTextParagraphCopyWithImpl<$Res>
    extends _$TaleTextItemCopyWithImpl<$Res, _$_TaleTextParagraph>
    implements _$$_TaleTextParagraphCopyWith<$Res> {
  __$$_TaleTextParagraphCopyWithImpl(
      _$_TaleTextParagraph _value, $Res Function(_$_TaleTextParagraph) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
  }) {
    return _then(_$_TaleTextParagraph(
      null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as StringNonEmpty,
    ));
  }
}

/// @nodoc

class _$_TaleTextParagraph implements _TaleTextParagraph {
  const _$_TaleTextParagraph(this.text);

  @override
  final StringNonEmpty text;

  @override
  String toString() {
    return 'TaleTextItem.text(text: $text)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TaleTextParagraph &&
            (identical(other.text, text) || other.text == text));
  }

  @override
  int get hashCode => Object.hash(runtimeType, text);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TaleTextParagraphCopyWith<_$_TaleTextParagraph> get copyWith =>
      __$$_TaleTextParagraphCopyWithImpl<_$_TaleTextParagraph>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StringNonEmpty text) text,
    required TResult Function(ImageUrl url) image,
  }) {
    return text(this.text);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(StringNonEmpty text)? text,
    TResult? Function(ImageUrl url)? image,
  }) {
    return text?.call(this.text);
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TaleTextParagraph value) text,
    required TResult Function(_TaleTextImage value) image,
  }) {
    return text(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TaleTextParagraph value)? text,
    TResult? Function(_TaleTextImage value)? image,
  }) {
    return text?.call(this);
  }
}

abstract class _TaleTextParagraph implements TaleTextItem {
  const factory _TaleTextParagraph(final StringNonEmpty text) =
      _$_TaleTextParagraph;

  StringNonEmpty get text;
  @JsonKey(ignore: true)
  _$$_TaleTextParagraphCopyWith<_$_TaleTextParagraph> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_TaleTextImageCopyWith<$Res> {
  factory _$$_TaleTextImageCopyWith(
          _$_TaleTextImage value, $Res Function(_$_TaleTextImage) then) =
      __$$_TaleTextImageCopyWithImpl<$Res>;
  @useResult
  $Res call({ImageUrl url});
}

/// @nodoc
class __$$_TaleTextImageCopyWithImpl<$Res>
    extends _$TaleTextItemCopyWithImpl<$Res, _$_TaleTextImage>
    implements _$$_TaleTextImageCopyWith<$Res> {
  __$$_TaleTextImageCopyWithImpl(
      _$_TaleTextImage _value, $Res Function(_$_TaleTextImage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
  }) {
    return _then(_$_TaleTextImage(
      null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as ImageUrl,
    ));
  }
}

/// @nodoc

class _$_TaleTextImage implements _TaleTextImage {
  const _$_TaleTextImage(this.url);

  @override
  final ImageUrl url;

  @override
  String toString() {
    return 'TaleTextItem.image(url: $url)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TaleTextImage &&
            (identical(other.url, url) || other.url == url));
  }

  @override
  int get hashCode => Object.hash(runtimeType, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TaleTextImageCopyWith<_$_TaleTextImage> get copyWith =>
      __$$_TaleTextImageCopyWithImpl<_$_TaleTextImage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StringNonEmpty text) text,
    required TResult Function(ImageUrl url) image,
  }) {
    return image(url);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(StringNonEmpty text)? text,
    TResult? Function(ImageUrl url)? image,
  }) {
    return image?.call(url);
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TaleTextParagraph value) text,
    required TResult Function(_TaleTextImage value) image,
  }) {
    return image(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TaleTextParagraph value)? text,
    TResult? Function(_TaleTextImage value)? image,
  }) {
    return image?.call(this);
  }
}

abstract class _TaleTextImage implements TaleTextItem {
  const factory _TaleTextImage(final ImageUrl url) = _$_TaleTextImage;

  ImageUrl get url;
  @JsonKey(ignore: true)
  _$$_TaleTextImageCopyWith<_$_TaleTextImage> get copyWith =>
      throw _privateConstructorUsedError;
}
