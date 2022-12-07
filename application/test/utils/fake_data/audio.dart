import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:mobile_app/domain/model/player/playlist_data.dart';
import 'package:mobile_app/domain/model/sort_and_filter/filter_type.dart';
import 'package:mobile_app/domain/model/sort_and_filter/sort_type.dart';
import 'package:mobile_app/domain/model/tale/tale_audio.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/model/tale_sort_and_filter/tale_filter_item_data.dart';
import 'package:mobile_app/domain/model/tale_sort_and_filter/tale_sort_item_data.dart';
import 'package:mobile_app/domain/value_objects/file_path.dart';
import 'package:mobile_app/domain/value_objects/image_url.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_graphic.dart';
import 'package:mobile_app/domain/value_objects/url_string.dart';

TaleAudio getTaleAudio({
  IntPositive? chapterIndex,
  Duration duration = const Duration(minutes: 1),
  UrlString? urlString,
  List<ImageUrl>? images,
  FilePath? filePath,
  Future<bool>? isCachedFuture,
}) =>
    TaleAudio(
      chapterIndex ?? IntPositive.zero,
      duration,
      urlString ?? UrlString('Url'),
      images ?? [ImageUrl('imageUrl')],
      filePath ?? FilePath('path'),
      isCachedFuture ?? Future.value(false),
    );

ConcatenatingAudioSource getConcatenatingAudioSource({
  List<AudioSource>? children,
  bool? useLazyPreparation,
}) {
  return ConcatenatingAudioSource(
    children: children ?? [source0],
    useLazyPreparation: useLazyPreparation ?? true,
  );
}

ProgressiveAudioSource getIndexedAudioSource({
  Uri? uri,
  Map<String, String>? headers,
  dynamic tag,
  Duration? duration,
}) =>
    ProgressiveAudioSource(
      uri ?? Uri.parse('https://google.com'),
      headers: headers,
      tag: tag,
      duration: duration,
    );

MediaItem getMediaItem({
  String? id,
  String? title,
  String? album,
  Uri? artUri,
  Map<String, String>? artHeaders,
}) =>
    MediaItem(
      id: id ?? 'mediaItemId',
      title: 'mediaItemTitle',
      album: album,
      artUri: artUri,
      artHeaders: artHeaders,
    );

final playlistItem0 = PlaylistItemData(TaleId(0), getTaleAudio());
final playlistItem1 = PlaylistItemData(TaleId(1), getTaleAudio());
final playlistItem2 = PlaylistItemData(TaleId(2), getTaleAudio());
final playlistItem3 = PlaylistItemData(TaleId(3), getTaleAudio());
final playlistItem4 = PlaylistItemData(TaleId(4), getTaleAudio());
final playlistItem5 = PlaylistItemData(TaleId(5), getTaleAudio());
final playlistItem6 = PlaylistItemData(TaleId(6), getTaleAudio());
final playlistItem7 = PlaylistItemData(TaleId(7), getTaleAudio());
final playlistItem8 = PlaylistItemData(TaleId(8), getTaleAudio());

final listOfPlaylitItemsFrom0to8 = <PlaylistItemData>[
  playlistItem0,
  playlistItem1,
  playlistItem2,
  playlistItem3,
  playlistItem4,
  playlistItem5,
  playlistItem6,
  playlistItem7,
  playlistItem8,
];

final listOfSourcesFrom0to8 = <IndexedAudioSource>[
  source0,
  source1,
  source2,
  source3,
  source4,
  source5,
  source6,
  source7,
  source8,
];
final source0 = getIndexedAudioSource(
  uri: Uri.file('path/0'),
  tag: getMediaItemFromPlaylistItem(playlistItem0),
);
final source1 = getIndexedAudioSource(
  uri: Uri.file('path/1'),
  tag: getMediaItemFromPlaylistItem(playlistItem1),
);
final source2 = getIndexedAudioSource(
  uri: Uri.file('path/2'),
  tag: getMediaItemFromPlaylistItem(playlistItem2),
);
final source3 = getIndexedAudioSource(
  uri: Uri.file('path/3'),
  tag: getMediaItemFromPlaylistItem(playlistItem3),
);
final source4 = getIndexedAudioSource(
  uri: Uri.file('path/4'),
  tag: getMediaItemFromPlaylistItem(playlistItem4),
);
final source5 = getIndexedAudioSource(
  uri: Uri.file('path/5'),
  tag: getMediaItemFromPlaylistItem(playlistItem5),
);
final source6 = getIndexedAudioSource(
  uri: Uri.file('path/6'),
  tag: getMediaItemFromPlaylistItem(playlistItem6),
);
final source7 = getIndexedAudioSource(
  uri: Uri.file('path/7'),
  tag: getMediaItemFromPlaylistItem(playlistItem7),
);
final source8 = getIndexedAudioSource(
  uri: Uri.file('path/8'),
  tag: getMediaItemFromPlaylistItem(playlistItem8),
);

PlaylistData getPlaylistData(List<PlaylistItemData> items) => PlaylistData(
      TaleFilterItemData(
        TaleFilterType.all,
        StringSingleLine('filter'),
        const SvgAssetGraphic(name: 'graphic'),
        IntPositive(0),
      ),
      TaleSortItemData(
        TaleSortType.byAuthor,
        StringSingleLine('sort'),
      ),
      items,
    );

MediaItem getMediaItemFromPlaylistItem(PlaylistItemData input) => getMediaItem(
      id: input.id.get().toString(),
      album: 'author $input',
      title: 'name $input',
      artUri: input.audio.images.first.asUri,
      artHeaders: {'hey': 'value'},
    );
