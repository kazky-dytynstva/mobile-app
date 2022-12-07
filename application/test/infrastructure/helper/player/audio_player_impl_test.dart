import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mobile_app/domain/model/play_audio_action/play_audio_action.dart';
import 'package:mobile_app/domain/model/play_audio_status/play_audio_status.dart';
import 'package:mobile_app/domain/model/player/countdown_time.dart';
import 'package:mobile_app/domain/model/player/loop_mode.dart';
import 'package:mobile_app/domain/model/player/playlist_data.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/infrastructure/helper/player/audio_player_impl.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/utils.dart';

void main() {
  late MockJustAudioPlayer justAudioPlayer;
  late MockLogger logger;
  late MockCrashAnalytic crashAnalytic;
  late MockTaleAudioToAudioSourceMapper audioSourceMapper;
  late AudioPlayerImpl player;

  setUp(() {
    justAudioPlayer = MockJustAudioPlayer();
    logger = MockLogger();
    crashAnalytic = MockCrashAnalytic();
    audioSourceMapper = MockTaleAudioToAudioSourceMapper();
    registerFallbackValue(LoopMode.values.first);
    registerFallbackValue(Duration.zero);
    registerFallbackValue(getConcatenatingAudioSource());
    registerFallbackValue(1);

    when(() => justAudioPlayer.playingStream).thenAnswer(
      (_) => const Stream.empty(),
    );
    when(() => justAudioPlayer.currentIndexStream).thenAnswer(
      (_) => const Stream.empty(),
    );
    when(() => justAudioPlayer.play()).thenAnswer((_) async => () {});
    when(() => justAudioPlayer.pause()).thenAnswer((_) async => () {});
    when(() => justAudioPlayer.stop()).thenAnswer((_) async => () {});
    when(() => justAudioPlayer.dispose()).thenAnswer((_) async => () {});
    when(() => justAudioPlayer.seek(any())).thenAnswer((_) async => () {});
    when(() => justAudioPlayer.setLoopMode(any()))
        .thenAnswer((_) async => () {});
    when(() => justAudioPlayer.seekToNext()).thenAnswer((_) async => () {});
    when(() => justAudioPlayer.seekToPrevious()).thenAnswer((_) async => () {});

    for (int j = 0; j < listOfPlaylitItemsFrom0to8.length; j++) {
      final input = listOfPlaylitItemsFrom0to8[j];
      final output = listOfSourcesFrom0to8[j];

      when(() => audioSourceMapper.map(input)).thenAnswer(
        (_) => Future.value(output),
      );
    }

    player = AudioPlayerImpl(
      justAudioPlayer,
      logger,
      crashAnalytic,
      audioSourceMapper,
    );
  });

  group('release method', () {
    test(
        "GIVEN player and current playing controller THEN both of them disposed",
        () async {
      // ARRANGE
      expect(player.playingTaleIdController.isClosed, isFalse);
      expect(player.currentItemController.isClosed, isFalse);
      // needed, so we can verify player.currentPlayingController.isClosed
      player.watchPlayingTaleId().listen((event) {});
      player.watchCurrentPlaylistItem().listen((event) {});

      // ACT
      await player.release();

      // ASSERT
      verifyInOrder([
        //region called with player._init()
        () => justAudioPlayer.playingStream,
        () => justAudioPlayer.currentIndexStream,
        //endregion

        () => justAudioPlayer.dispose(),
      ]);
      verifyNoMoreInteractions(justAudioPlayer);
      expect(player.playingTaleIdController.isClosed, isTrue);
      expect(player.currentItemController.isClosed, isTrue);
    });
  });

  group('reset method', () {
    test(
      'GIVEN nonEmpty playlist THEN player stops and playlist is null',
      () async {
        // ARRANGE
        player.internalPlaylistData = getPlaylistData([playlistItem0]);

        // ACT
        await player.reset();

        // ASSERT
        verifyInOrder([
          //region called with player._init()
          () => justAudioPlayer.playingStream,
          () => justAudioPlayer.currentIndexStream,
          //endregion

          () => justAudioPlayer.stop(),
        ]);
        verifyNoMoreInteractions(justAudioPlayer);
        expect(player.playlistData, isNull);
      },
    );
  });

  group('action method', () {
    test("GIVEN action.play THEN player.play called", () async {
      // ACT
      await player.action(const PlayAudioAction.play());

      // ASSERT
      verifyInOrder([
        //region called with player._init()
        () => justAudioPlayer.playingStream,
        () => justAudioPlayer.currentIndexStream,
        //endregion

        () => justAudioPlayer.play(),
      ]);
      verifyNoMoreInteractions(justAudioPlayer);
    });

    test("GIVEN action.pause THEN player.pause called", () async {
      // ACT
      await player.action(const PlayAudioAction.pause());

      // ASSERT
      verifyInOrder([
        //region called with player._init()
        () => justAudioPlayer.playingStream,
        () => justAudioPlayer.currentIndexStream,
        //endregion

        () => justAudioPlayer.pause(),
      ]);
      verifyNoMoreInteractions(justAudioPlayer);
    });
    test("GIVEN action.stop THEN player.stop called", () async {
      // ACT
      await player.action(const PlayAudioAction.stop());

      // ASSERT
      verifyInOrder([
        //region called with player._init()
        () => justAudioPlayer.playingStream,
        () => justAudioPlayer.currentIndexStream,
        //endregion

        () => justAudioPlayer.stop(),
      ]);
      verifyNoMoreInteractions(justAudioPlayer);
    });
    test("GIVEN action.seek THEN player.seek called", () async {
      // ARRANGE
      const duration = Duration(minutes: 1);

      // ACT
      await player.action(const PlayAudioAction.seekTo(duration));

      // ASSERT
      verifyInOrder([
        //region called with player._init()
        () => justAudioPlayer.playingStream,
        () => justAudioPlayer.currentIndexStream,
        //endregion

        () => justAudioPlayer.seek(duration),
      ]);
      verifyNoMoreInteractions(justAudioPlayer);
    });
    test("GIVEN action.toggleLoopMode THEN player.loopMode next applied",
        () async {
      // ARRANGE
      when(() => justAudioPlayer.loopMode).thenReturn(LoopMode.off);

      // ACT
      await player.action(const PlayAudioAction.toggleLoopMode());

      // ASSERT
      verifyInOrder([
        //region called with player._init()
        () => justAudioPlayer.playingStream,
        () => justAudioPlayer.currentIndexStream,
        //endregion

        () => justAudioPlayer.loopMode,
        () => justAudioPlayer.setLoopMode(LoopMode.all),
      ]);
      verifyNoMoreInteractions(justAudioPlayer);
    });
    test("GIVEN action.next THEN player.seekToNext called", () async {
      // ACT
      await player.action(const PlayAudioAction.next());

      // ASSERT
      verifyInOrder([
        //region called with player._init()
        () => justAudioPlayer.playingStream,
        () => justAudioPlayer.currentIndexStream,
        //endregion

        () => justAudioPlayer.seekToNext(),
      ]);
      verifyNoMoreInteractions(justAudioPlayer);
    });
    test("GIVEN action.prev THEN player.seekToPrevious() called", () async {
      // ACT
      await player.action(const PlayAudioAction.prev());

      // ASSERT
      verifyInOrder([
        //region called with player._init()
        () => justAudioPlayer.playingStream,
        () => justAudioPlayer.currentIndexStream,
        //endregion

        () => justAudioPlayer.seekToPrevious(),
      ]);
      verifyNoMoreInteractions(justAudioPlayer);
    });
    test("GIVEN action.countdownTime THEN throw exception", () async {
      registerFallbackValue(StackTrace.current);
      // ACT
      await player
          .action(const PlayAudioAction.countdownTime(CountdownTime.off));

      // ASSERT
      verifyInOrder([
        //region called with player._init()
        () => justAudioPlayer.playingStream,
        () => justAudioPlayer.currentIndexStream,
        //endregion

        () => crashAnalytic.exception(
              const CountdownTimeActionNotHandled(),
              any(),
              fatal: true,
            ),
      ]);
      verifyNoMoreInteractions(justAudioPlayer);
      verifyNoMoreInteractions(crashAnalytic);
    });
  });

  group('setPlaylist method', () {
    test("GIVEN data THEN map it and set to player", () async {
      // ARRANGE
      when(() => justAudioPlayer.setAudioSource(
            any(that: isA<ConcatenatingAudioSource>()),
            initialIndex: 2,
            preload: false,
          )).thenAnswer(
        (_) async => Duration.zero,
      );
      final playlist = getPlaylistData([
        playlistItem0,
        playlistItem1,
        playlistItem2,
        playlistItem3,
        playlistItem4,
      ]);
      final sources = [
        source0,
        source1,
        source2,
        source3,
        source4,
      ];
      for (int i = 0; i < playlist.items.length; i++) {
        when(() => audioSourceMapper.map(playlist.items[i])).thenAnswer(
          (_) => Future.value(sources[i]),
        );
      }
      final current = playlistItem2;
      assert(player.playlistData == null);

      // ACT
      await player.setPlaylist(playlist, current);

      // ASSERT
      expect(player.playlistData, equals(playlist));

      verifyInOrder([
        //region called with player._init()
        () => justAudioPlayer.playingStream,
        () => justAudioPlayer.currentIndexStream,
        //endregion

        () => audioSourceMapper.map(playlistItem0),
        () => audioSourceMapper.map(playlistItem1),
        () => audioSourceMapper.map(playlistItem2),
        () => audioSourceMapper.map(playlistItem3),
        () => audioSourceMapper.map(playlistItem4),
        () => justAudioPlayer.setAudioSource(
              any(that: isA<ConcatenatingAudioSource>()),
              initialIndex: 2,
              preload: false,
            ),
      ]);
      verifyNoMoreInteractions(audioSourceMapper);
      verifyNoMoreInteractions(justAudioPlayer);
    });
  });

  group('updatePlaylistItem method', () {
    final data = getPlaylistData([playlistItem0, playlistItem1, playlistItem2]);
    final updatedItem = PlaylistItemData(
      playlistItem0.id,
      getTaleAudio(chapterIndex: playlistItem0.audio.chapterIndex + 1),
    );
    late ConcatenatingAudioSource playlistSource;

    setUp(() {
      playlistSource = getConcatenatingAudioSource(
        children: [source0, source1, source2],
      );
      when(() => justAudioPlayer.audioSource).thenReturn(playlistSource);
      player.internalPlaylistData = data;
    });
    test(
        "GIVEN null WHEN player.audioSource called THEN add item to updatedPlaylistItems",
        () async {
      // ARRANGE
      when(() => justAudioPlayer.audioSource).thenReturn(null);
      assert(player.updatedPlaylistItems.isEmpty);

      // ACT
      await player.updatePlaylistItem(updatedItem);

      // ASSERT
      expect(player.updatedPlaylistItems[updatedItem.id], equals(updatedItem));
      expect(player.playlistData?.items.contains(updatedItem), isFalse);
      verifyInOrder([
        //region called with player._init()
        () => justAudioPlayer.playingStream,
        () => justAudioPlayer.currentIndexStream,
        //endregion

        () => justAudioPlayer.audioSource,
      ]);
      verifyNoMoreInteractions(justAudioPlayer);
      verifyZeroInteractions(audioSourceMapper);
    });

    test(
        "GIVEN same currentIndex WHEN player.currentIndex THEN add item to updatedPlaylistItems",
        () async {
      // ARRANGE
      when(() => justAudioPlayer.currentIndex).thenReturn(0);
      assert(player.updatedPlaylistItems.isEmpty);

      // ACT
      await player.updatePlaylistItem(updatedItem);

      // ASSERT
      expect(player.updatedPlaylistItems[updatedItem.id], equals(updatedItem));
      expect(player.playlistData?.items.contains(updatedItem), isTrue);
      expect(player.playlistData?.items.contains(playlistItem0), isFalse);
      verifyInOrder([
        //region called with player._init()
        () => justAudioPlayer.playingStream,
        () => justAudioPlayer.currentIndexStream,
        //endregion

        () => justAudioPlayer.audioSource,
        () => justAudioPlayer.currentIndex,
      ]);
      verifyNoMoreInteractions(justAudioPlayer);
      verifyZeroInteractions(audioSourceMapper);
    });
    test(
        "GIVEN another currentIndex WHEN player.currentIndex THEN add item to updatedPlaylistItems and update source at player",
        () async {
      // ARRANGE
      final updatedSource = getIndexedAudioSource(
        uri: Uri.file('path/0'),
        tag: getMediaItemFromPlaylistItem(updatedItem),
      );
      player.updatedPlaylistItems[updatedItem.id] = updatedItem;
      when(() => justAudioPlayer.currentIndex).thenReturn(1);
      when(() => audioSourceMapper.map(updatedItem)).thenAnswer(
        (_) => Future.value(updatedSource),
      );
      assert(player.updatedPlaylistItems.isNotEmpty);

      // ACT
      await player.updatePlaylistItem(updatedItem);

      // ASSERT
      expect(player.updatedPlaylistItems[updatedItem.id], isNull);
      expect(player.playlistData?.items.contains(updatedItem), isTrue);
      expect(player.playlistData?.items.contains(playlistItem0), isFalse);
      expect(playlistSource.sequence.contains(source0), isFalse);
      expect(playlistSource.sequence[0], equals(updatedSource));
      verifyInOrder([
        //region called with player._init()
        () => justAudioPlayer.playingStream,
        () => justAudioPlayer.currentIndexStream,
        //endregion

        () => justAudioPlayer.audioSource,
        () => justAudioPlayer.currentIndex,
        () => audioSourceMapper.map(updatedItem),
      ]);
      verifyNoMoreInteractions(justAudioPlayer);
      verifyNoMoreInteractions(audioSourceMapper);
    });
  });

  group('watchStatus method', () {
    late StreamController<PlayerState> controller;
    setUp(() {
      controller = StreamController<PlayerState>();
      when(() => justAudioPlayer.playerStateStream).thenAnswer(
        (_) => controller.stream,
      );
    });

    test(
        "GIVEN combination of all PlayerStates with play(true/false) THEN emit correct sequence of the PlayAudioStatus items",
        () async {
      // ARRANGE
      final values = [
        PlayerState(true, ProcessingState.completed),
        PlayerState(false, ProcessingState.completed),
        PlayerState(false, ProcessingState.ready),
        PlayerState(true, ProcessingState.ready),
        PlayerState(false, ProcessingState.buffering),
        PlayerState(true, ProcessingState.buffering),
        PlayerState(false, ProcessingState.loading),
        PlayerState(true, ProcessingState.loading),
        PlayerState(false, ProcessingState.idle),
        PlayerState(true, ProcessingState.idle),
      ];

      // ASSERT
      final stream = player.watchStatus();
      expectLater(
        stream,
        emitsInOrder([
          PlayAudioStatus.completed,
          PlayAudioStatus.completed,
          PlayAudioStatus.paused,
          PlayAudioStatus.playing,
          PlayAudioStatus.loading,
          PlayAudioStatus.loading,
          PlayAudioStatus.loading,
          PlayAudioStatus.loading,
          PlayAudioStatus.idle,
          PlayAudioStatus.idle,
        ]),
      );

      // ACT
      for (final element in values) {
        controller.add(element);
      }
    });
  });

  group('watchPosition method', () {
    late StreamController<Duration> controller;
    setUp(() {
      controller = StreamController<Duration>();
      when(() => justAudioPlayer.positionStream).thenAnswer(
        (_) => controller.stream,
      );
    });

    test("GIVEN list of positions THEN emit same list in correct order",
        () async {
      // ARRANGE
      const values = [
        Duration.zero,
        Duration(seconds: 2),
        Duration(minutes: 3),
        Duration(hours: 4),
        Duration(days: 5),
      ];

      // ASSERT
      final stream = player.watchPosition();
      expectLater(
        stream,
        emitsInOrder(values),
      );

      // ACT
      for (final element in values) {
        controller.add(element);
      }
    });
  });
  group('watchLoopMode method', () {
    late StreamController<LoopMode> controller;
    setUp(() {
      controller = StreamController<LoopMode>();
      when(() => justAudioPlayer.loopModeStream).thenAnswer(
        (_) => controller.stream,
      );
    });

    test("GIVEN list of loopModes THEN emit same list in correct order",
        () async {
      // ARRANGE
      final values = LoopMode.values.reversed;
      final expected = [
        PlayerLoopMode.all,
        PlayerLoopMode.one,
        PlayerLoopMode.off,
      ];

      // ASSERT
      final stream = player.watchLoopMode();
      expectLater(
        stream,
        emitsInOrder(expected),
      );

      // ACT
      for (final element in values) {
        controller.add(element);
      }
    });
  });
  group('watchCurrentPlaylistItem method', () {
    test("GIVEN list of items THEN emit same list in correct order", () async {
      // ARRANGE
      final values = [
        playlistItem0,
        playlistItem3,
        playlistItem4,
      ];

      // ASSERT
      final stream = player.watchCurrentPlaylistItem();
      expectLater(
        stream,
        emitsInOrder(values),
      );

      // ACT
      for (final element in values) {
        player.currentItemController.add(element);
      }
    });
  });
  group('watchPlayingTaleId method', () {
    test("GIVEN list of items THEN emit same list in correct order", () async {
      // ARRANGE
      final values = <Option<TaleId>>[
        const None(),
        Some(TaleId(0)),
        const None(),
        Some(TaleId(2)),
        Some(TaleId(3)),
      ];

      // ASSERT
      final stream = player.watchPlayingTaleId();
      expectLater(
        stream,
        emitsInOrder(values),
      );

      // ACT
      for (final element in values) {
        player.playingTaleIdController.add(element);
      }
    });
  });

  group('get playlist item methods', () {
    setUp(() {
      final source = getConcatenatingAudioSource(children: [
        source0,
        source1,
        source2,
      ]);
      when(() => justAudioPlayer.currentIndex).thenReturn(0);
      when(() => justAudioPlayer.audioSource).thenReturn(source);
      player.internalPlaylistData = getPlaylistData([
        playlistItem0,
        playlistItem1,
        playlistItem2,
      ]);
    });

    group('getItemByIndex', () {
      test("GIVEN null WHEN player.audioSource called THEN return null", () {
        // ARRANGE
        when(() => justAudioPlayer.audioSource).thenReturn(null);

        // ASSERT
        expect(player.getItemByIndex(0), isNull);
      });
      test("GIVEN playlistData is null THEN return null", () {
        // ARRANGE
        player.internalPlaylistData = null;

        // ASSERT
        expect(player.getItemByIndex(0), isNull);
      });

      test(
          "GIVEN index equal than audioSource sequence length THEN take first item",
          () {
        // ARRANGE
        final index = justAudioPlayer.audioSource!.sequence.length;

        // ASSERT
        expect(player.getItemByIndex(index), playlistItem0);
      });

      test(
          "GIVEN index greater than audioSource sequence length THEN take first item",
          () {
        // ARRANGE
        final index = justAudioPlayer.audioSource!.sequence.length + 1;

        // ASSERT
        expect(player.getItemByIndex(index), playlistItem0);
      });
    });

    group('getCurrentPlaylistItem method', () {
      test("GIVEN null WHEN player.currentIndex called THEN return null", () {
        // ARRANGE
        when(() => justAudioPlayer.currentIndex).thenReturn(null);
        // ASSERT
        expect(player.getCurrentPlaylistItem(), isNull);
      });

      test("GIVEN playlistData with item THEN return correct item", () {
        // ASSERT
        expect(player.getCurrentPlaylistItem(), equals(playlistItem0));
      });
    });

    group('getNextPlaylistItem method', () {
      test("GIVEN null WHEN player.currentIndex called THEN return null", () {
        // ARRANGE
        when(() => justAudioPlayer.currentIndex).thenReturn(null);
        // ASSERT
        expect(player.getNextPlaylistItem(), isNull);
      });

      test("GIVEN playlistData with item THEN return next item", () {
        // ASSERT
        expect(player.getNextPlaylistItem(), equals(playlistItem1));
      });
    });
  });

  group('setInitialLoopMode method', () {
    final expected = {
      PlayerLoopMode.off: LoopMode.off,
      PlayerLoopMode.one: LoopMode.one,
      PlayerLoopMode.all: LoopMode.all,
    };
    for (var loopMode in PlayerLoopMode.values.reversed) {
      test("GIVEN $loopMode THEN verify the correct internal loopMode set",
          () async {
        // ACT
        await player.setInitialLoopMode(loopMode);

        // ASSERT
        verifyInOrder([
          //region called with player._init()
          () => justAudioPlayer.playingStream,
          () => justAudioPlayer.currentIndexStream,
          //endregion
          () => justAudioPlayer.setLoopMode(expected[loopMode]!)
        ]);
      });
    }
  });
}
