import 'dart:async';
import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/player/playlist_data.dart';
import 'package:mobile_app/domain/model/tale/tale.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/infrastructure/data_source/remote_api/base/api_client.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_storage.dart';
import 'package:mobile_app/infrastructure/helper/audio_cache/audio_cache_helper.dart';
import 'package:mobile_app/infrastructure/helper/player/audio_player.dart';
import 'package:mobile_app/infrastructure/helper/url_creator/url_creator.dart';
import 'package:mobile_app/infrastructure/mapper/tale/tale_chapter_entity_to_tale_chapter_mapper.dart';

@Injectable(as: UseCase)
class CacheAudioUseCase extends UseCase<PlaylistItemData, bool> {
  final ApiClient _apiClient;
  final AudioCacheHelper _cacheHelper;
  final Mapper<TaleChapterEntityMapperInput, TaleChapter> _mapper;
  final UrlCreator _urlCreator;
  final TaleStorage _storage;
  final AudioPlayer _player;

  CacheAudioUseCase(
    this._urlCreator,
    this._apiClient,
    this._cacheHelper,
    this._storage,
    this._player,
    this._mapper,
  );

  final Map<PlaylistItemData, Completer<bool>> _cachingWIP = {};

  @override
  Stream<bool> transaction(PlaylistItemData input) async* {
    final entity = await _storage.find(input.id);
    if (entity == null) {
      yield false;
      return;
    }

    final index = input.audio.chapterIndex.get();
    final chapter = entity.content[index];
    if (chapter.audioDuration == null) return;

    final isCached = await _cacheHelper.isCached(input.id, chapter);

    if (isCached) {
      yield true;
      return;
    }

    final url = _urlCreator.getTaleAudioUrl(input.id, input.audio.chapterIndex);
    final filePath = _cacheHelper.getTaleAudioPath(input.id, index);
    final file = File(filePath.get());
    if (file.existsSync()) {
      file.deleteSync();
    }
    if (_cachingWIP.containsKey(input)) {
      yield (await _cachingWIP[input]!.future);
      return;
    }
    final completer = Completer<bool>();
    _cachingWIP[input] = completer;
    final result = await _apiClient.downloadAudio(url: url, filePath: filePath);
    final successful = result.fold((l) => false, (r) {
      _notifyAudioCached(input.id, index);
      return true;
    });
    completer.complete(successful);
    _cachingWIP.remove(input);
    yield successful;
  }

  void _notifyAudioCached(TaleId id, int index) async {
    final entity = (await _storage.find(id))!;
    final updated = entity.copyWith(updateDate: (entity.updateDate ?? 0) + 1);
    await _storage.update(updated);
    final taleChapter = _mapper.map(
      TaleChapterEntityMapperInput(id, updated.content[index]),
    );
    final item = PlaylistItemData(id, taleChapter.audio);
    _player.updatePlaylistItem(item);
  }
}
