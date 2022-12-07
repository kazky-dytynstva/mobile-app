import 'package:mobile_app/infrastructure/data_source/storage_local/tale/entity/chapter/chapter_entity.dart';
import 'package:mobile_app/infrastructure/data_source/storage_local/tale/entity/crew/crew_entity.dart';
import 'package:mobile_app/infrastructure/data_source/storage_local/tale/entity/rating/rating_entity.dart';
import 'package:mobile_app/infrastructure/data_source/storage_local/tale/entity/tale_entity.dart';
import 'package:mobile_app/infrastructure/di/module/storage.dart';

import '../utils.dart';

TaleEntity getTaleEntity({
  DbKey? id,
  String? name,
  int? createDate,
  int? updateDate,
  Set<String>? tags,
  List<TaleChapterEntity>? content,
  TaleCrewEntity? crew,
  bool? isFavorite,
  bool? isWatched,
  bool? isHidden,
  bool? isRated,
  int? lastReadChapter,
  int? lastReadPosition,
  RatingEntity? rating,
}) =>
    TaleEntity.create(
      id: id ?? 777,
      name: name ?? "TaleName",
      createDate: 0,
      updateDate: updateDate,
      tags: tags ?? {'helloTag'},
      content: content ?? [getTaleChapterEntityWithText()],
      crew: crew,
      isFavorite: isFavorite ?? false,
      isWatched: isWatched ?? false,
      isHidden: isHidden ?? false,
      isRated: isRated ?? false,
      lastReadChapter: lastReadChapter ?? 0,
      lastReadPosition: lastReadPosition ?? 0,
      rating: rating,
    );

TaleChapterEntity getTaleChapterEntity({
  int? index,
  String? title,
  int? imageCount,
  List<String>? text,
  int? audioDuration,
  int? audioSize,
}) =>
    TaleChapterEntity.create(
      index: index ?? 0,
      title: title,
      imageCount: imageCount,
      text: text,
      audioDuration: audioDuration,
      audioSize: audioSize,
    );

TaleChapterEntity getTaleChapterEntityWithText({
  int? index,
  String? title,
  int? imageCount,
  int? audioDuration,
  int? audioSize,
}) =>
    getTaleChapterEntity(
      index: index,
      title: title,
      imageCount: imageCount,
      audioDuration: audioDuration,
      audioSize: audioSize,
      text: ['hello tale text'],
    );

RatingEntity getRatingEntity({
  int? amount,
  double? avg,
}) =>
    RatingEntity.create(
      amount: amount ?? 1,
      avg: avg ?? 5.0,
    );

final List<TaleEntity> listOfIncrementalTales = [
  getTaleEntity(id: 0, crew: crewIncremental),
  getTaleEntity(id: 1, crew: crewIncremental),
  getTaleEntity(id: 2, crew: crewIncremental),
  getTaleEntity(id: 3, crew: crewIncremental),
  getTaleEntity(id: 4, crew: crewIncremental),
  getTaleEntity(id: 5, crew: crewIncremental),
  getTaleEntity(id: 6, crew: crewIncremental),
  getTaleEntity(id: 7, crew: crewIncremental),
  getTaleEntity(id: 8, crew: crewIncremental),
  getTaleEntity(id: 9, crew: crewIncremental),
];

final TaleEntity taleWithCrewNullable = getTaleEntity(
  id: 0,
  crew: crewNullable,
);
final TaleEntity taleWithCrewEmpty = getTaleEntity(
  id: 0,
  crew: crewEmpty,
);
final TaleEntity taleWithCrewIncremental = getTaleEntity(
  id: 0,
  crew: crewIncremental,
);
