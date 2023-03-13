import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/rating/rating_data.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_name.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/domain/model/tale_tag/tale_tag.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/data/data_source/storage_local/tale/entity/rating/rating_entity.dart';
import 'package:mobile_app/data/data_source/storage_local/tale/entity/tale_entity.dart';
import 'package:mobile_app/data/env_config/env_config.dart';
import 'package:mobile_app/data/helper/audio_cache/audio_cache_helper.dart';
import 'package:mobile_app/data/helper/url_creator/url_creator.dart';

@Singleton(as: Mapper)
class TaleEntityToTaleListItemMapper
    implements Mapper<TaleEntity, TalesPageItemData> {
  final Mapper<String, TaleTag> _taleTagMapper;
  final Mapper<TaleEntity, StringSingleLine> _taleProviderMapper;
  final Mapper<RatingEntity, RatingData> _ratingMapper;
  final UrlCreator _urlCreator;
  final AudioCacheHelper _cacheHelper;

  TaleEntityToTaleListItemMapper(
    this._taleTagMapper,
    this._taleProviderMapper,
    this._urlCreator,
    this._cacheHelper,
    this._ratingMapper,
  );

  @override
  TalesPageItemData map(TaleEntity input) {
    final taleId = TaleId(input.id);
    final author = _taleProviderMapper.map(input);
    final imageUrl = _urlCreator.getTaleImageUrl(
      taleId,
      chapterIndex: IntPositive.zero,
      imageIndex: IntPositive.zero,
    );
    final tags = input.tags.map(_taleTagMapper.map);
    final taleName = TaleName(
      input.name + (EnvConfig.isProd ? '' : ' (${input.id})'),
    );
    return TalesPageItemData(
      id: taleId,
      createDate: DateTime.fromMillisecondsSinceEpoch(input.createDate),
      updatedDate: DateTime.fromMillisecondsSinceEpoch(input.updateDate ?? 0),
      name: taleName,
      provider: author,
      imageUrl: imageUrl,
      isFav: input.isFavorite,
      isHidden: input.isHidden,
      isWatched: input.isWatched,
      tags: tags,
      hasWriter: input.crew?.authors?.isNotEmpty ?? false,
      isCached: _cacheHelper.isCached(taleId, input.content.first),
      optionRating: _getRatingOption(input.rating),
    );
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
