import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/player/playlist_data.dart';
import 'package:mobile_app/domain/model/tale/tale.dart';
import 'package:mobile_app/domain/model/tale/tale_audio.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/data/data_source/storage_local/tale/entity/tale_entity.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_storage.dart';
import 'package:mobile_app/data/helper/logger/logger.dart';
import 'package:mobile_app/data/helper/player/audio_player.dart';

@Injectable(as: UseCase)
class ListenPlaylistChangedUseCase
    extends UseCase<Dry, ListenPlaylistChangedOutput> {
  final TaleStorage _storage;
  final AudioPlayer _player;
  final Mapper<TaleEntity, Tale> _mapper;
  final Logger _logger;

  ListenPlaylistChangedUseCase(
    this._storage,
    this._mapper,
    this._player,
    this._logger,
  );

  @override
  Stream<ListenPlaylistChangedOutput> transaction(Dry input) async* {
    var currentItem = _player.getCurrentPlaylistItem();
    final transformer = StreamTransformer.fromHandlers(
      handleData: (
        PlaylistItemData playlistItem,
        EventSink<ListenPlaylistChangedOutput> sink,
      ) async {
        if (currentItem?.id == playlistItem.id) return;
        currentItem = playlistItem;
        final entity = await _storage.find(playlistItem.id);
        if (entity == null) return;
        final tale = _mapper.map(entity);
        final output = ListenPlaylistChangedOutput(tale, playlistItem.audio);
        sink.add(output);

        _logger.log(
          () => 'Tale changed in audioPlaylist. New $playlistItem',
          tag: logTag,
        );
      },
    );
    yield* _player.watchCurrentPlaylistItem().transform(transformer);
  }
}

class ListenPlaylistChangedOutput {
  final Tale tale;
  final TaleAudio audio;

  ListenPlaylistChangedOutput(
    this.tale,
    this.audio,
  );
}
