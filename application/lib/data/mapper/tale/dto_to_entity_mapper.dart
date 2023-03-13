import 'package:dto/dto.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/data/data_source/storage_local/tale/entity/chapter/chapter_entity.dart';
import 'package:mobile_app/data/data_source/storage_local/tale/entity/crew/crew_entity.dart';
import 'package:mobile_app/data/data_source/storage_local/tale/entity/tale_entity.dart';

@LazySingleton(as: Mapper)
class TaleDtoToEntityMapper implements Mapper<TaleDto, TaleEntity> {
  @override
  TaleEntity map(TaleDto input) {
    final content = <TaleChapterEntity>[];

    var index = 0;
    for (final dto in input.content) {
      final int? audioSize = dto.audio?.size;
      final int? audioDuration = dto.audio?.duration;

      final chapter = TaleChapterEntity.create(
        index: index,
        title: dto.title,
        imageCount: dto.imageCount,
        text: dto.text,
        audioDuration: audioDuration,
        audioSize: audioSize,
      );

      content.add(chapter);
      index++;
    }

    final crew = input.crew == null
        ? null
        : TaleCrewEntity.create(
            authors: input.crew!.authors,
            readers: input.crew!.readers,
            musicians: input.crew!.musicians,
            translators: input.crew!.translators,
            graphics: input.crew!.graphics,
          );

    return TaleEntity.create(
      id: input.id,
      name: input.name,
      createDate: input.createDate,
      updateDate: input.updateDate,
      tags: input.tags.map((e) => e.name).toSet(),
      content: content,
      crew: crew,
      isFavorite: false,
      isWatched: false,
      isHidden: false,
      isRated: false,
      lastReadChapter: 0,
      lastReadPosition: 0,
      rating: null,
    );
  }
}
