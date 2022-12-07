import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/player/playlist_data.dart';
import 'package:mobile_app/domain/model/tale/tale.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/model/tale_tag/tale_tag.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/infrastructure/data_source/storage_local/tale/entity/chapter/chapter_entity.dart';
import 'package:mobile_app/infrastructure/data_source/storage_local/tale/entity/tale_entity.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_storage.dart';
import 'package:mobile_app/infrastructure/mapper/tale/tale_chapter_entity_to_tale_chapter_mapper.dart';

@Injectable(as: UseCase)
class CacheAllAudioUseCase extends UseCase<Dry, CacheAllAudioOutput> {
  final UseCase<PlaylistItemData, bool> _cacheAudioUseCase;
  final TaleStorage _storage;
  final Mapper<TaleChapterEntityMapperInput, TaleChapter> _chapterMapper;
  final Mapper<TaleTag, String> _tagToStringMapper;

  CacheAllAudioUseCase(
    this._cacheAudioUseCase,
    this._storage,
    this._tagToStringMapper,
    this._chapterMapper,
  );

  StreamController<CacheAllAudioOutput>? _controller;

  @override
  Stream<CacheAllAudioOutput> transaction(Dry input) {
    final controller = _controller ?? StreamController();
    controller.onCancel = () {
      controller.close();
      _controller = null;
    };
    _getAllAudioTales().then((allTalesWithAudio) async {
      loop:
      for (final tale in allTalesWithAudio) {
        final id = TaleId(tale.id);
        for (final chapter in tale.content) {
          if (controller.isClosed) break loop;
          final result = await _cacheOneAudio(id, chapter);
          if (!result) {
            controller.add(const CacheAllAudioOutput(false));
            controller.close();
          }
        }
      }
      if (!controller.isClosed) {
        controller.add(const CacheAllAudioOutput(true));
      }
    });

    return controller.stream;
  }

  Future<Iterable<TaleEntity>> _getAllAudioTales() async {
    final allTales = await _storage.getAll();
    final tagText = _tagToStringMapper.map(TaleTag.audio);
    return allTales.where((tale) => tale.tags.contains(tagText));
  }

  Future<bool> _cacheOneAudio(TaleId id, TaleChapterEntity entity) async {
    final chapter = _chapterMapper.map(
      TaleChapterEntityMapperInput(id, entity),
    );
    final input = PlaylistItemData(id, chapter.audio);
    return await _cacheAudioUseCase.call(input);
  }
}

@immutable
class CacheAllAudioOutput {
  final bool isSuccessful;

  const CacheAllAudioOutput(this.isSuccessful);
}
