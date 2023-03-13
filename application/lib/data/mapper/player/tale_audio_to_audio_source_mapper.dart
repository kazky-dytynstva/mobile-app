import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/player/playlist_data.dart';
import 'package:mobile_app/domain/value_objects/file_path.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/data/data_source/storage_local/tale/entity/tale_entity.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_storage.dart';

@LazySingleton(as: Mapper)
class TaleAudioToAudioSourceMapper
    implements Mapper<PlaylistItemData, Future<IndexedAudioSource>> {
  final TaleStorage _taleStorage;
  final Mapper<TaleEntity, StringSingleLine> _authorMapper;

  TaleAudioToAudioSourceMapper(
    this._taleStorage,
    this._authorMapper,
  );

  @override
  Future<IndexedAudioSource> map(PlaylistItemData input) async {
    final tag = await _getTag(input);
    IndexedAudioSource foldRemote() => AudioSource.uri(
          Uri.parse(input.audio.url.get()),
          tag: tag,
        );

    IndexedAudioSource foldLocal(FilePath filePath) {
      final uri = Uri.file(filePath.get());
      return AudioSource.uri(uri, tag: tag);
    }

    final isCached = await input.audio.isCachedFuture;
    return isCached ? foldLocal(input.audio.filePath) : foldRemote();
  }

  Future<MediaItem> _getTag(PlaylistItemData input) async {
    final entity = (await _taleStorage.find(input.id))!;
    final chapter = entity.content[input.audio.chapterIndex.get()];
    final name = chapter.title ?? entity.name;
    final author = _authorMapper.map(entity);
    return MediaItem(
      id: input.id.get().toString(),
      album: author.get(),
      title: name,
      artUri: input.audio.images.first.asUri,
    );
  }
}
