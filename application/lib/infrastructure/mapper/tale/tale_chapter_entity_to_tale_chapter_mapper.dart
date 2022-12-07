import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/tale/tale.dart';
import 'package:mobile_app/domain/model/tale/tale_audio.dart';
import 'package:mobile_app/domain/model/tale/tale_text_item.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/value_objects/image_url.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/domain/value_objects/string_not_empty.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/infrastructure/data_source/storage_local/tale/entity/chapter/chapter_entity.dart';
import 'package:mobile_app/infrastructure/helper/audio_cache/audio_cache_helper.dart';
import 'package:mobile_app/infrastructure/helper/url_creator/url_creator.dart';

typedef GetTaleImage = Function(IntPositive chapterIndex);

@LazySingleton(as: Mapper)
class TaleChapterEntityToTaleChapterMapper
    implements Mapper<TaleChapterEntityMapperInput, TaleChapter> {
  final UrlCreator _urlCreator;
  final AudioCacheHelper _cacheHelper;

  TaleChapterEntityToTaleChapterMapper(
    this._urlCreator,
    this._cacheHelper,
  );

  @override
  TaleChapter map(TaleChapterEntityMapperInput input) {
    final entity = input.entity;
    final taleId = input.taleId;
    final chapterIndex = IntPositive(entity.index);

    ImageUrl createImage(IntPositive imageIndex) => _urlCreator.getTaleImageUrl(
          taleId,
          chapterIndex: chapterIndex,
          imageIndex: imageIndex,
        );

    final titleOption = (entity.title == null)
        ? const None<StringSingleLine>()
        : Some(StringSingleLine(entity.title!));

    final textOption = _mapTextOption(
      chapterIndex,
      entity.text,
      taleId,
      createImage,
    );
    final audioOption = _mapAudioOption(
      taleId,
      chapterIndex,
      entity,
      createImage,
    );

    return TaleChapter(
      chapterIndex,
      titleOption,
      textOption,
      audioOption,
    );
  }

  Option<List<TaleTextItem>> _mapTextOption(
    IntPositive chapterIndex,
    List<String>? items,
    TaleId taleId,
    GetTaleImage getTaleImage,
  ) {
    if (items == null || items.isEmpty) {
      return const None();
    }

    final textItems = <TaleTextItem>[
      TaleTextItem.image(getTaleImage(IntPositive.zero)),
    ];

    TaleTextItem mapItem(String item) {
      final photoIndex = int.tryParse(item);

      if (photoIndex != null) {
        final photoUrl = getTaleImage(IntPositive(photoIndex));
        return TaleTextItem.image(photoUrl);
      } else {
        final string = StringNonEmpty(item);
        return TaleTextItem.text(string);
      }
    }

    textItems.addAll(items.map(mapItem));

    return Some(textItems);
  }

  Option<TaleAudio> _mapAudioOption(
    TaleId taleId,
    IntPositive chapterIndex,
    TaleChapterEntity entity,
    GetTaleImage getTaleImage,
  ) {
    final duration = entity.audioDuration;
    if (duration == null || entity.audioSize == null) {
      return const None();
    }
    final url = _urlCreator.getTaleAudioUrl(taleId, chapterIndex);

    final images = <ImageUrl>[];
    for (int i = 0; i < (entity.imageCount ?? 1); i++) {
      images.add(getTaleImage(IntPositive(i)));
    }

    final audio = TaleAudio(
      chapterIndex,
      Duration(milliseconds: duration),
      url,
      images,
      _cacheHelper.getTaleAudioPath(taleId, chapterIndex.get()),
      _cacheHelper.isCached(taleId, entity),
    );
    return Some(audio);
  }
}

@immutable
class TaleChapterEntityMapperInput {
  final TaleId taleId;
  final TaleChapterEntity entity;

  const TaleChapterEntityMapperInput(
    this.taleId,
    this.entity,
  );
}
