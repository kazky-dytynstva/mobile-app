import 'package:dartz/dartz.dart';
import 'package:mobile_app/domain/model/play_audio_action/play_audio_action.dart';
import 'package:mobile_app/domain/model/play_audio_status/play_audio_status.dart';
import 'package:mobile_app/domain/model/player/loop_mode.dart';
import 'package:mobile_app/domain/model/player/playlist_data.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';

abstract class AudioPlayer {
  Future<Unit> release();

  Future<Unit> reset();

  Future<Unit> action(PlayAudioAction action);

  Future<Unit> setPlaylist(
    PlaylistData data,
    PlaylistItemData current,
  );

  PlaylistData? get playlistData;

  PlaylistItemData? getCurrentPlaylistItem();

  PlaylistItemData? getNextPlaylistItem();

  Future<Unit> updatePlaylistItem(PlaylistItemData item);

  Future<Unit> setInitialLoopMode(PlayerLoopMode loopMode);

  Stream<PlayAudioStatus> watchStatus();

  Stream<Duration> watchPosition();

  Stream<PlaylistItemData> watchCurrentPlaylistItem();

  Stream<PlayerLoopMode> watchLoopMode();

  Stream<Option<TaleId>> watchPlayingTaleId();
}
