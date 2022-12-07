import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/domain/model/player/playlist_data.dart';
import 'package:mobile_app/domain/model/sort_and_filter/filter_type.dart';
import 'package:mobile_app/domain/model/sort_and_filter/sort_type.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/model/tale_sort_and_filter/tale_filter_item_data.dart';
import 'package:mobile_app/domain/model/tale_sort_and_filter/tale_sort_item_data.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_graphic.dart';

import '../../../utils/utils.dart';

void main() {
  final filterData = TaleFilterItemData(
    TaleFilterType.all,
    StringSingleLine('filter'),
    const SvgAssetGraphic(name: 'graphic'),
    IntPositive(0),
  );
  final sortData = TaleSortItemData(
    TaleSortType.byAuthor,
    StringSingleLine('sort'),
  );
  final taleId = TaleId(0);
  final taleAudio = getTaleAudio();
  late PlaylistItemData item;
  late PlaylistData playlist;

  setUp(() {
    item = PlaylistItemData(
      taleId,
      taleAudio,
    );
    playlist = PlaylistData(filterData, sortData, [item]);
  });
  group('playlistData', () {
    test(
      'GIVEN playlist THEN verify its Equatable',
      () {
        expect(playlist, isA<Equatable>());
      },
    );
    test(
      'GIVEN playlist THEN verify props are correct',
      () {
        expect(playlist.props, [
          filterData,
          sortData,
          [item.id]
        ]);
      },
    );
    test(
      'GIVEN playlist THEN items are correct',
      () {
        expect(playlist.filterData, equals(filterData));
        expect(playlist.sortItemData, equals(sortData));
        expect(playlist.items, [item]);
      },
    );
    test(
      'GIVEN playlist without items WHEN  THEN throw assert error',
      () {
        expect(
          () => PlaylistData(filterData, sortData, const []),
          throwsA(isA<AssertionError>()),
        );
      },
    );
    test(
        "GIVEN playlist with items WHEN search for presented item id THEN return item",
        () async {
      // ACT
      final result = playlist.itemById(taleId);

      // ASSERT
      expect(result, equals(item));
    });
    test(
        "GIVEN playlist with items WHEN search for unPresented item id THEN return item",
        () async {
      // ASSERT
      expect(
        () => playlist.itemById(TaleId(1)),
        throwsA(isA<StateError>()),
      );
    });

    test(
        "GIVEN updated item WHEN updateItem method called  THEN update item in list",
        () async {
      // ARRANGE
      final updatedItem = PlaylistItemData(
        taleId,
        getTaleAudio(chapterIndex: IntPositive(777)),
      );
      // ACT

      playlist.updateItem(updatedItem);
      // ASSERT

      expect(
        playlist.items.first,
        equals(updatedItem),
      );
    });

    test(
        "GIVEN item which is not in list WHEN updateItem method called THEN do nothing",
        () {
      // ARRANGE
      final updatedItem = PlaylistItemData(
        TaleId(taleId.get() + 1),
        getTaleAudio(chapterIndex: item.audio.chapterIndex + 1),
      );
      // ACT

      playlist.updateItem(updatedItem);
      // ASSERT

      expect(playlist.items.first, equals(item));
      expect(playlist.items.contains(updatedItem), isFalse);
    });
  });
  group('playlistItemData', () {
    test(
      'GIVEN playlistItem THEN verify its Equatable',
      () {
        expect(item, isA<Equatable>());
      },
    );
    test(
      'GIVEN playlist THEN verify props are correct',
      () {
        expect(item.props, [
          taleId,
          taleAudio,
        ]);
      },
    );
  });
}
