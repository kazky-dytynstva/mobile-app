import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/player/playlist_data.dart';
import 'package:mobile_app/domain/model/sort_and_filter/filter_type.dart';
import 'package:mobile_app/domain/model/sort_and_filter/sort_type.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/domain/model/tale/tale.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/model/tale_sort_and_filter/tale_filter_item_data.dart';
import 'package:mobile_app/domain/model/tale_sort_and_filter/tale_sort_item_data.dart';
import 'package:mobile_app/domain/model/tale_tag/tale_tag.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_graphic.dart';
import 'package:mobile_app/data/data_source/storage_local/tale/entity/chapter/chapter_entity.dart';
import 'package:mobile_app/data/data_source/storage_local/tale/entity/tale_entity.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_storage.dart';
import 'package:mobile_app/data/helper/player/audio_player.dart';
import 'package:mobile_app/data/mapper/tale/tale_chapter_entity_to_tale_chapter_mapper.dart';
import 'package:mobile_app/data/use_case/tale_sort_and_filter/filter_and_sort_tales_use_case.dart';
import 'package:mobile_app/data/use_case/tale_sort_and_filter/get_tale_sort_and_filter_type.dart';

@Injectable(as: UseCase)
class SetAudioPlaylistUseCase extends UseCase<SetAudioPlaylistInput, Dry> {
  final TaleStorage _storage;
  final Mapper<TaleChapterEntityMapperInput, TaleChapter> _chapterMapper;
  final AudioPlayer _audioPlayer;
  final Mapper<String, TaleTag> _taleTagMapper;
  final Mapper<TaleEntity, TalesPageItemData> _taleEntityMapper;
  final UseCase<FilterAndSortTalesInput, FilterAndSortTalesOutput>
      _filterAndSortTalesUseCase;
  final UseCase<Dry, GetTaleSortAndFilterTypesOutput>
      _getFilterAndSortTypesUseCase;
  final Mapper<TaleFilterType, StringSingleLine> _filterTypeToNameMapper;
  final Mapper<TaleFilterType, SvgAssetGraphic> _filterTypeToIconMapper;
  final Mapper<TaleSortType, StringSingleLine> _sortTypeToNameMapper;

  SetAudioPlaylistUseCase(
    this._storage,
    this._chapterMapper,
    this._taleEntityMapper,
    this._audioPlayer,
    this._taleTagMapper,
    this._filterAndSortTalesUseCase,
    this._getFilterAndSortTypesUseCase,
    this._filterTypeToNameMapper,
    this._filterTypeToIconMapper,
    this._sortTypeToNameMapper,
  );

  @override
  Stream<Dry> transaction(SetAudioPlaylistInput input) async* {
    final playlistData = await _createPlaylistData(input.filterType);
    if (playlistData == null) {
      yield dry;
      return;
    }
    final currentItem = playlistData.items.firstWhere(
      (element) => element.id == input.currentId,
      orElse: () => playlistData.items.first,
    );
    final anotherPlaylist = playlistData != _audioPlayer.playlistData ||
        currentItem.id != _audioPlayer.getCurrentPlaylistItem()?.id;
    if (anotherPlaylist) {
      await _audioPlayer.reset();
      await _audioPlayer.setPlaylist(
        playlistData,
        currentItem,
      );
    }
    yield dry;
  }

  Future<PlaylistData?> _createPlaylistData(
    TaleFilterType? defaultFilterType,
  ) async {
    final filterAndSortOutput = await _getFilterAndSortTypesUseCase.call(dry);
    final filterType = defaultFilterType ?? filterAndSortOutput.filterType;
    final sortType = filterAndSortOutput.sortType;
    final taleIdList = await _getAllTaleAudioIds(filterType, sortType);
    if (taleIdList.isEmpty) return null;
    final playlistItems = await _mapTalesToPlaylistItemData(taleIdList);

    final filterData = TaleFilterItemData(
      filterType,
      _filterTypeToNameMapper.map(filterType),
      _filterTypeToIconMapper.map(filterType),
      IntPositive(playlistItems.length),
    );
    final sortData = TaleSortItemData(
      sortType,
      _sortTypeToNameMapper.map(sortType),
    );
    return PlaylistData(filterData, sortData, playlistItems);
  }

  Future<List<PlaylistItemData>> _mapTalesToPlaylistItemData(
    List<TaleId> taleIdList,
  ) async {
    final playlist = <PlaylistItemData>[];

    for (int i = 0; i < taleIdList.length; i++) {
      final id = taleIdList[i];
      final entity = await _storage.find(id);
      if (entity != null) {
        /// todo fix me when tale multiChapter is enabled:
        /// we need to add to playlist all audio from each tale, but not just first
        /// ping Andrii for this :)
        final item = _mapChapterToAudio(id, entity.content.first);
        if (item != null) playlist.add(item);
      }
    }
    return playlist;
  }

  PlaylistItemData? _mapChapterToAudio(TaleId id, TaleChapterEntity entity) {
    final input = TaleChapterEntityMapperInput(id, entity);
    final chapter = _chapterMapper.map(input);
    return chapter.audioOption.fold(
      () => null,
      (audio) => PlaylistItemData(id, audio),
    );
  }

  Future<List<TaleId>> _getAllTaleAudioIds(
    TaleFilterType filterType,
    TaleSortType sortType,
  ) async {
    final all = await _storage.getAll();
    bool hasAudio(TaleEntity entity) {
      final tags = entity.tags.map(_taleTagMapper.map).toList();
      return tags.contains(TaleTag.audio);
    }

    final audioTales = all.where(hasAudio).map(_taleEntityMapper.map);

    final input = FilterAndSortTalesInput(
      filterType,
      sortType,
      audioTales.toList(),
    );

    final filteredAndSorted = await _filterAndSortTalesUseCase.call(input);

    return filteredAndSorted.map((e) => e.id).toList(growable: false);
  }
}

class SetAudioPlaylistInput {
  final TaleId currentId;
  final TaleFilterType? filterType;

  const SetAudioPlaylistInput(
    this.currentId,
    this.filterType,
  );
}
