import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/rating/rating_data.dart';
import 'package:mobile_app/domain/model/tale/tale.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_name.dart';
import 'package:mobile_app/domain/model/tale_crew/tale_crew.dart';
import 'package:mobile_app/domain/model/tale_tag/tale_tag.dart';
import 'package:mobile_app/data/data_source/storage_local/tale/entity/chapter/chapter_entity.dart';
import 'package:mobile_app/data/data_source/storage_local/tale/entity/crew/crew_entity.dart';
import 'package:mobile_app/data/data_source/storage_local/tale/entity/rating/rating_entity.dart';
import 'package:mobile_app/data/data_source/storage_local/tale/entity/tale_entity.dart';
import 'package:mobile_app/data/env_config/env_config.dart';
import 'package:mobile_app/data/mapper/tale/tale_chapter_entity_to_tale_chapter_mapper.dart';

@LazySingleton(as: Mapper)
class TaleEntityToTaleMapper implements Mapper<TaleEntity, Tale> {
  final Mapper<String, TaleTag> _taleCategoryMapper;
  final Mapper<TaleCrewEntity?, TaleCrew?> _crewMapper;
  final Mapper<TaleChapterEntityMapperInput, TaleChapter> _chapterMapper;
  final Mapper<RatingEntity, RatingData> _ratingMapper;

  TaleEntityToTaleMapper(
    this._taleCategoryMapper,
    this._crewMapper,
    this._chapterMapper,
    this._ratingMapper,
  );

  @override
  Tale map(TaleEntity input) {
    final id = TaleId(input.id);
    final taleName = TaleName(
      input.name + (EnvConfig.isProd ? '' : ' (${input.id})'),
    );

    return Tale(
      id: id,
      name: taleName,
      chapters: _mapChapters(input.content, id),
      tags: _mapTags(input.tags),
      crewOption: _mapCrew(input.crew),
      isFavorite: input.isFavorite,
      isHidden: input.isHidden,
      isRated: input.isRated,
      lastReadChapter: input.lastReadChapter,
      lastReadPosition: input.lastReadPosition,
      ratingOption: _getRatingOption(input.rating),
    );
  }

  List<TaleTag> _mapTags(Set<String> tags) =>
      tags.map(_taleCategoryMapper.map).toList();

  Option<TaleCrew> _mapCrew(TaleCrewEntity? entity) {
    final crew = _crewMapper.map(entity);
    return (crew == null) ? const None() : Some(crew);
  }

  List<TaleChapter> _mapChapters(
    List<TaleChapterEntity> content,
    TaleId taleId,
  ) {
    final result = <TaleChapter>[];
    for (int i = 0; i < content.length; i++) {
      final input = TaleChapterEntityMapperInput(taleId, content[i]);
      result.add(_chapterMapper.map(input));
    }

    return result;
  }

  Option<RatingData> _getRatingOption(RatingEntity? rating) {
    if (rating == null) {
      return const None();
    }
    if (rating.amount < minNumberOfRatingsToShow) {
      return const None();
    }
    return Some(_ratingMapper.map(rating));
  }
}
