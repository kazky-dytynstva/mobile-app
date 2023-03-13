import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_storage.dart';
import 'package:mobile_app/domain/model/player/playlist_data.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/data/mapper/player/tale_audio_to_audio_source_mapper.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/utils.dart';

void main() {
  final taleId = TaleId(777);
  final playlistItemLocal = PlaylistItemData(
    taleId,
    getTaleAudio(isCachedFuture: Future.value(true)),
  );
  final playlistItemRemote = PlaylistItemData(
    taleId,
    getTaleAudio(isCachedFuture: Future.value(false)),
  );
  final taleEntity = getTaleEntity(id: taleId.get());
  const authorName = 'Author Name';
  final tag = getMediaItem(
    id: taleId.get().toString(),
    title: taleEntity.name,
    album: authorName,
  );

  late TaleAudioToAudioSourceMapper mapper;
  late MockTaleEntityToAuthorMapper authorMapper;
  late TaleStorage taleStorage;
  setUp(() {
    taleStorage = MockTaleStorage();
    authorMapper = MockTaleEntityToAuthorMapper();
    mapper = TaleAudioToAudioSourceMapper(taleStorage, authorMapper);

    when(() => taleStorage.find(taleId)).thenAnswer(
      (_) async => taleEntity,
    );
    when(() => authorMapper.map(taleEntity)).thenReturn(
      StringSingleLine(authorName),
    );
  });

  test(
    'GIVEN local and remote playlistItems THEN verify tag is correct for both',
    () async {
      final localSource = await mapper.map(playlistItemRemote);
      final remoteSource = await mapper.map(playlistItemRemote);

      expect(localSource.tag, equals(tag));
      expect(remoteSource.tag, equals(tag));
    },
  );

  test(
    'GIVEN remote playlist item THEN verify source mapped correctly',
    () async {
      final source = await mapper.map(playlistItemRemote);
      final expected = getIndexedAudioSource(
        uri: playlistItemRemote.audio.url.asUri,
        tag: tag,
      );

      expect(source, equalAudioSource(expected));
    },
  );

  test(
    'GIVEN local playlist item THEN verify source mapped correctly',
    () async {
      final source = await mapper.map(playlistItemLocal);
      final expected = getIndexedAudioSource(
        uri: playlistItemRemote.audio.filePath.asUri,
        tag: tag,
      );

      expect(source, equalAudioSource(expected));
    },
  );
}
