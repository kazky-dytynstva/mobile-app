import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobile_app/infrastructure/data_source/storage_local/hive_adapter_ids.dart';
import 'package:mobile_app/infrastructure/data_source/storage_local/tale/entity/chapter/chapter_entity.dart';
import 'package:mobile_app/infrastructure/data_source/storage_local/tale/entity/crew/crew_entity.dart';
import 'package:mobile_app/infrastructure/data_source/storage_local/tale/entity/rating/rating_entity.dart';
import 'package:mobile_app/infrastructure/di/module/storage.dart';

const int _keyId = 0;
const int _keyName = 1;
const int _keyCreateDate = 2;
const int _keyUpdateDate = 3;
const int _keyTags = 4;
const int _keyContent = 5;
const int _keyCrew = 6;
const int _keyIsFavorite = 7;
const int _keyIsWatched = 8;
const int _keyIsHidden = 9;
const int _keyLastReadChapter = 10;
const int _keyLastReadPosition = 11;
const int _keyRating = 12;
const int _keyIsRated = 13;

@immutable
class TaleEntity extends Equatable {
  @HiveField(_keyId)
  final DbKey _id;
  @HiveField(_keyName)
  final String _name;

  /// in milliseconds since Epoch
  /// Use [DateTime.fromMicrosecondsSinceEpoch]
  @HiveField(_keyCreateDate)
  final int _createDate;

  /// in milliseconds since Epoch
  /// Use [DateTime.fromMicrosecondsSinceEpoch]
  @HiveField(_keyUpdateDate)
  final int? _updateDate;
  @HiveField(_keyTags)
  final Set<String> _tags;
  @HiveField(_keyContent)
  final List<TaleChapterEntity> _content;

  @HiveField(_keyCrew)
  final TaleCrewEntity? _crew;

  @HiveField(_keyIsFavorite)
  final bool _isFavorite;
  @HiveField(_keyIsWatched)
  final bool _isWatched;
  @HiveField(_keyIsHidden)
  final bool _isHidden;
  @HiveField(_keyIsRated)
  final bool _isRated;

  @HiveField(_keyLastReadChapter)
  final int _lastReadChapter;
  @HiveField(_keyLastReadPosition)
  final int _lastReadPosition;

  @HiveField(_keyRating)
  final RatingEntity? _rating;

  const TaleEntity.create({
    required DbKey id,
    required String name,
    required int createDate,
    required int? updateDate,
    required Set<String> tags,
    required List<TaleChapterEntity> content,
    required TaleCrewEntity? crew,
    required bool isFavorite,
    required bool isWatched,
    required bool isHidden,
    required bool isRated,
    required int lastReadChapter,
    required int lastReadPosition,
    required RatingEntity? rating,
  })  : assert(tags.length > 0),
        assert(content.length > 0),
        _id = id,
        _name = name,
        _createDate = createDate,
        _updateDate = updateDate,
        _tags = tags,
        _content = content,
        _crew = crew,
        _isFavorite = isFavorite,
        _isHidden = isHidden,
        _isWatched = isWatched,
        _isRated = isRated,
        _lastReadChapter = lastReadChapter,
        _rating = rating,
        _lastReadPosition = lastReadPosition;

  DbKey get id => _id;

  String get name => _name;

  int get createDate => _createDate;

  int? get updateDate => _updateDate;

  Set<String> get tags => _tags;

  List<TaleChapterEntity> get content => _content;

  TaleCrewEntity? get crew => _crew;

  bool get isFavorite => _isFavorite;

  bool get isWatched => _isWatched;

  bool get isHidden => _isHidden;

  bool get isRated => _isRated;

  int get lastReadChapter => _lastReadChapter;

  int get lastReadPosition => _lastReadPosition;

  RatingEntity? get rating => _rating;

  @override
  List<Object?> get props => [
        _id,
        _name,
        _createDate,
        _updateDate,
        _tags,
        _content,
        _crew,
        _isFavorite,
        _isWatched,
        _isHidden,
        _isRated,
        _lastReadChapter,
        _lastReadPosition,
      ];

  TaleEntity copyWith({
    bool? isFavorite,
    bool? isWatched,
    bool? isHidden,
    bool? isRated,
    int? lastReadChapter,
    int? lastReadPosition,
    int? updateDate,
    RatingEntity? rating,
  }) =>
      TaleEntity.create(
        id: id,
        name: name,
        createDate: createDate,
        updateDate: updateDate ?? this.updateDate,
        tags: tags,
        content: content,
        crew: crew,
        isFavorite: isFavorite ?? this.isFavorite,
        isWatched: isWatched ?? this.isWatched,
        isHidden: isHidden ?? this.isHidden,
        isRated: isRated ?? this.isRated,
        lastReadChapter: lastReadChapter ?? this.lastReadChapter,
        lastReadPosition: lastReadPosition ?? this.lastReadPosition,
        rating: rating ?? this.rating,
      );
}

class TaleEntityAdapter extends TypeAdapter<TaleEntity> {
  @override
  final int typeId = HiveAdapterIds.tales;

  @override
  TaleEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    final content = (fields[_keyContent] as List)
        .map((map) => TaleChapterEntity(Map<String, dynamic>.from(map as Map)))
        .toList();

    final crewFields = (fields[_keyCrew]);
    final crew = crewFields == null
        ? null
        : TaleCrewEntity(Map<String, dynamic>.from(crewFields as Map));

    final ratingFields = (fields[_keyRating]);
    final rating = ratingFields == null
        ? null
        : RatingEntity(Map<String, dynamic>.from(ratingFields as Map));

    return TaleEntity.create(
      id: fields[_keyId] as DbKey,
      name: fields[_keyName] as String,
      createDate: fields[_keyCreateDate] as int,
      updateDate: fields[_keyUpdateDate] as int?,
      tags: (fields[_keyTags] as List<String>).toSet(),
      content: content,
      crew: crew,
      isFavorite: fields[_keyIsFavorite] as bool,
      isWatched: fields[_keyIsWatched] as bool,
      isHidden: fields[_keyIsHidden] as bool,
      isRated: fields[_keyIsRated] as bool? ?? false,
      lastReadChapter: fields[_keyLastReadChapter] as int,
      lastReadPosition: fields[_keyLastReadPosition] as int,
      rating: rating,
    );
  }

  @override
  void write(BinaryWriter writer, TaleEntity obj) {
    writer
      ..writeByte(14)
      ..writeByte(_keyId)
      ..write(obj._id)
      ..writeByte(_keyName)
      ..write(obj._name)
      ..writeByte(_keyCreateDate)
      ..write(obj._createDate)
      ..writeByte(_keyUpdateDate)
      ..write(obj._updateDate)
      ..writeByte(_keyTags)
      ..write(obj._tags.toList())
      ..writeByte(_keyContent)
      ..write(obj._content.map((e) => e.toMap()).toList())
      ..writeByte(_keyCrew)
      ..write(obj._crew?.toMap())
      ..writeByte(_keyIsFavorite)
      ..write(obj._isFavorite)
      ..writeByte(_keyIsWatched)
      ..write(obj._isWatched)
      ..writeByte(_keyIsHidden)
      ..write(obj._isHidden)
      ..writeByte(_keyIsRated)
      ..write(obj._isRated)
      ..writeByte(_keyLastReadChapter)
      ..write(obj._lastReadChapter)
      ..writeByte(_keyLastReadPosition)
      ..write(obj._lastReadPosition)
      ..writeByte(_keyRating)
      ..write(obj._rating?.toMap());
  }
}
