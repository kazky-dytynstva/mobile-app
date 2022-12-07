import 'package:equatable/equatable.dart';
import 'package:mobile_app/domain/model/tale/tale_audio.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/model/tale_sort_and_filter/tale_filter_item_data.dart';
import 'package:mobile_app/domain/model/tale_sort_and_filter/tale_sort_item_data.dart';

class PlaylistData extends Equatable {
  final TaleFilterItemData filterData;
  final TaleSortItemData sortItemData;
  final List<PlaylistItemData> items;

  const PlaylistData(
    this.filterData,
    this.sortItemData,
    this.items,
  ) : assert(items.length > 0);

  @override
  List<Object> get props => [
        filterData,
        sortItemData,
        items.map((e) => e.id),
      ];

  /// If [id] not found in [items] - will throw [StateError]
  PlaylistItemData itemById(TaleId id) =>
      items.firstWhere((element) => element.id == id);

  void updateItem(PlaylistItemData updated) {
    for (var i = 0; i < items.length; i++) {
      final item = items[i];
      if (item.id == updated.id) {
        items.removeAt(i);
        items.insert(i, updated);
        return;
      }
    }
  }
}

class PlaylistItemData extends Equatable {
  final TaleId id;
  final TaleAudio audio;

  const PlaylistItemData(
    this.id,
    this.audio,
  );

  @override
  List<Object> get props => [
        id,
        audio,
      ];
}
