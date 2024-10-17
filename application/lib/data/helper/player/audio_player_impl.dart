import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart' as j;
import 'package:just_audio_background/just_audio_background.dart';
import 'package:meta/meta.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';

import 'package:mobile_app/domain/model/play_audio_action/play_audio_action.dart';
import 'package:mobile_app/domain/model/play_audio_status/play_audio_status.dart';
import 'package:mobile_app/domain/model/player/loop_mode.dart';
import 'package:mobile_app/domain/model/player/playlist_data.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/data/helper/analytic/crash_analytic.dart';
import 'package:mobile_app/data/helper/logger/logger.dart';
import 'package:mobile_app/data/helper/player/audio_player.dart';

const _tag = 'AudioPlayer';

@LazySingleton(as: AudioPlayer)
class AudioPlayerImpl implements AudioPlayer {
  final j.AudioPlayer _player;
  final Mapper<PlaylistItemData, Future<j.IndexedAudioSource>> _playlistMapper;

  final Logger _logger;
  final CrashAnalytic _crashAnalytic;
  @visibleForTesting
  final playingTaleIdController = StreamController<Option<TaleId>>();
  @visibleForTesting
  final currentItemController = StreamController<PlaylistItemData>.broadcast();
  @visibleForTesting
  PlaylistData? internalPlaylistData;
  @visibleForTesting
  final updatedPlaylistItems = <TaleId, PlaylistItemData>{};

  AudioPlayerImpl(
    this._player,
    this._logger,
    this._crashAnalytic,
    this._playlistMapper,
  ) {
    _init();
  }

  @override
  Future<Unit> release() async {
    await _player.dispose();
    await playingTaleIdController.close();
    await currentItemController.close();
    return unit;
  }

  @override
  Future<Unit> reset() async {
    await _player.stop();
    internalPlaylistData = null;
    return unit;
  }

  @override
  Future<Unit> action(PlayAudioAction action) async {
    _logger.log(
      () => 'New action arrived: $action',
      tag: _tag,
    );
    await action
        .map(
      play: (_) => _player.play(),
      pause: (_) => _player.pause(),
      stop: (_) => _player.stop(),
      seekTo: (e) => _player.seek(e.position),
      toggleLoopMode: (_) => _player.setLoopMode(_player.loopMode.next),
      next: (_) => _player.seekToNext(),
      prev: (_) => _player.seekToPrevious(),
      countdownTime: (_) async =>
          Future.error(const CountdownTimeActionNotHandled()),
    )
        .catchError((error, trace) async {
      // todo emit error stream value from here
      _crashAnalytic.exception(error, trace, fatal: true);
    });

    return unit;
  }

  @override
  PlaylistData? get playlistData => internalPlaylistData;

  @override
  Stream<PlayAudioStatus> watchStatus() {
    final transformer = StreamTransformer.fromHandlers(
        handleData: (j.PlayerState state, EventSink<PlayAudioStatus> sink) {
      late final PlayAudioStatus status;
      switch (state.processingState) {
        case j.ProcessingState.idle:
          status = PlayAudioStatus.idle;
          break;
        case j.ProcessingState.loading:
        case j.ProcessingState.buffering:
          status = PlayAudioStatus.loading;
          break;
        case j.ProcessingState.ready:
          status =
              state.playing ? PlayAudioStatus.playing : PlayAudioStatus.paused;
          break;
        case j.ProcessingState.completed:
          status = PlayAudioStatus.completed;
          break;
      }
      sink.add(status);
    });

    return _player.playerStateStream.transform(transformer);
  }

  @override
  Stream<Duration> watchPosition() => _player.positionStream;

  @override
  PlaylistItemData? getCurrentPlaylistItem() {
    final index = _player.currentIndex;
    if (index == null) return null;
    return getItemByIndex(index);
  }

  @override
  PlaylistItemData? getNextPlaylistItem() {
    if (_player.currentIndex == null) return null;
    return getItemByIndex(_player.currentIndex! + 1);
  }

  @override
  Future<Unit> setInitialLoopMode(PlayerLoopMode loopMode) async {
    await _player.setLoopMode(loopMode.converted);
    return unit;
  }

  @override
  Future<Unit> setPlaylist(
    PlaylistData data,
    PlaylistItemData current,
  ) async {
    internalPlaylistData = data;
    final source = j.ConcatenatingAudioSource(children: []);
    for (var item in data.items) {
      final playlistItem = await _playlistMapper.map(item);
      source.add(playlistItem);
    }
    await _player.setAudioSource(
      source,
      initialIndex: source.children.getIndexOf(current),
      preload: false,
    );
    return unit;
  }

  @override
  Stream<Option<TaleId>> watchPlayingTaleId() => playingTaleIdController.stream;

  @override
  Stream<PlayerLoopMode> watchLoopMode() {
    final transformer = StreamTransformer.fromHandlers(
      handleData: (j.LoopMode mode, EventSink<PlayerLoopMode> sink) {
        sink.add(mode.converted);
      },
    );

    return _player.loopModeStream.distinct().transform(transformer);
  }

  @override
  Future<Unit> updatePlaylistItem(PlaylistItemData item) async {
    final playerSource = _player.audioSource as j.ConcatenatingAudioSource?;
    if (playerSource == null) {
      updatedPlaylistItems[item.id] = item;
      return unit;
    }
    final index = playerSource.sequence.getIndexOf(item);
    playlistData?.updateItem(item);

    if (index == _player.currentIndex) {
      updatedPlaylistItems[item.id] = item;
    } else {
      updatedPlaylistItems.remove(item.id);
      final itemSource = await _playlistMapper.map(item);
      await playerSource.insert(index + 1, itemSource);
      if (index >= 0) await playerSource.removeAt(index);
    }
    return unit;
  }

  void _init() {
    _player.playingStream.listen((isPlaying) {
      if (isPlaying) {
        _notifyIfCurrentPlayingChanged(_player.currentIndex!);
      } else {
        playingTaleIdController.add(const None());
        _updateItemsIfNeeded();
      }
    });
    _player.currentIndexStream.listen((int? index) {
      if (index == null) return;
      _notifyIfCurrentPlayingChanged(index);
      _updateItemsIfNeeded();
    });
  }

  void _notifyIfCurrentPlayingChanged(int currentIndex) {
    final current = getItemByIndex(currentIndex);
    if (current == null) return;
    playingTaleIdController.add(Some(current.id));
    currentItemController.add(current);
  }

  void _updateItemsIfNeeded() async {
    if (updatedPlaylistItems.values.isEmpty) return;
    final copy = List.from(updatedPlaylistItems.values);
    for (final item in copy) {
      await updatePlaylistItem(item);
    }
  }

  @override
  Stream<PlaylistItemData> watchCurrentPlaylistItem() =>
      currentItemController.stream;

  @visibleForTesting
  PlaylistItemData? getItemByIndex(int index) {
    final source = _player.audioSource;
    if (source == null) return null;
    if (index >= source.sequence.length) index = 0;
    final id = source.sequence[index].taleId;
    return playlistData?.itemById(id);
  }
}

extension _AudioSourceX on j.AudioSource {
  TaleId get taleId {
    final mediaData = (this as j.IndexedAudioSource).tag as MediaItem;
    return TaleId(int.parse(mediaData.id));
  }
}

extension on List<j.AudioSource> {
  int getIndexOf(PlaylistItemData item) =>
      indexWhere((e) => e.taleId == item.id);
}

extension on j.LoopMode {
  j.LoopMode get next {
    switch (this) {
      case j.LoopMode.off:
        return j.LoopMode.all;
      case j.LoopMode.all:
        return j.LoopMode.one;
      case j.LoopMode.one:
        return j.LoopMode.off;
    }
  }

  PlayerLoopMode get converted {
    switch (this) {
      case j.LoopMode.off:
        return PlayerLoopMode.off;
      case j.LoopMode.all:
        return PlayerLoopMode.all;
      case j.LoopMode.one:
        return PlayerLoopMode.one;
    }
  }
}

extension on PlayerLoopMode {
  j.LoopMode get converted {
    switch (this) {
      case PlayerLoopMode.off:
        return j.LoopMode.off;
      case PlayerLoopMode.all:
        return j.LoopMode.all;
      case PlayerLoopMode.one:
        return j.LoopMode.one;
    }
  }
}

class CountdownTimeActionNotHandled implements Exception {
  const CountdownTimeActionNotHandled();

  @override
  String toString() => 'This action should not be handled by player!';
}
