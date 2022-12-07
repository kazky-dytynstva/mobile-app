import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/helper/tale_filter.dart';
import 'package:mobile_app/domain/model/sort_and_filter/filter_type.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/domain/model/tale_tag/tale_tag.dart';

const _freshTaleDuration = Duration(days: 3);

@LazySingleton(as: TaleFilter)
class TaleFilterImpl implements TaleFilter {
  @override
  List<TalesPageItemData> filter({
    required TaleFilterType type,
    required List<TalesPageItemData> tales,
  }) {
    switch (type) {
      case TaleFilterType.all:
        return tales;
      case TaleFilterType.national:
        return _getNational(tales);
      case TaleFilterType.author:
        return _getAuthor(tales);
      case TaleFilterType.audio:
        return _getAudio(tales);
      case TaleFilterType.lullaby:
        return _getLullaby(tales);
      case TaleFilterType.poem:
        return _getPoem(tales);
      case TaleFilterType.lastAdded:
        return _getLastAdded(tales);
      case TaleFilterType.favorite:
        return _getFavorite(tales);
      case TaleFilterType.unwatched:
        return _getUnWatched(tales);
      case TaleFilterType.hidden:
        return _getHidden(tales);
    }
  }

  List<TalesPageItemData> _getNational(List<TalesPageItemData> tales) => tales
      .where((it) => !it.tags.contains(TaleTag.author))
      .toList(growable: false);

  List<TalesPageItemData> _getAuthor(List<TalesPageItemData> tales) => tales
      .where((it) => it.tags.contains(TaleTag.author))
      .toList(growable: false);

  List<TalesPageItemData> _getAudio(List<TalesPageItemData> tales) => tales
      .where((it) => it.tags.contains(TaleTag.audio))
      .toList(growable: false);

  List<TalesPageItemData> _getLullaby(List<TalesPageItemData> tales) => tales
      .where((it) => it.tags.contains(TaleTag.lullaby))
      .toList(growable: false);

  List<TalesPageItemData> _getPoem(List<TalesPageItemData> tales) => tales
      .where((it) => it.tags.contains(TaleTag.poem))
      .toList(growable: false);

  List<TalesPageItemData> _getLastAdded(List<TalesPageItemData> tales) {
    final today = DateTime.now();
    late DateTime lastAddedDate = DateTime.fromMillisecondsSinceEpoch(0);
    for (final tale in tales) {
      if (tale.createDate.isAfter(lastAddedDate)) {
        lastAddedDate = tale.createDate;
      }
    }
    return tales.where((tale) {
      final stillFresh = tale.createDate.add(_freshTaleDuration).isAfter(today);
      final sameDate = tale.createDate == lastAddedDate;
      return stillFresh || sameDate;
    }).toList(growable: false);
  }

  List<TalesPageItemData> _getUnWatched(List<TalesPageItemData> tales) =>
      tales.where((it) => !it.isWatched).toList(growable: false);

  List<TalesPageItemData> _getHidden(List<TalesPageItemData> tales) =>
      tales.where((it) => it.isHidden).toList(growable: false);

  List<TalesPageItemData> _getFavorite(List<TalesPageItemData> tales) =>
      tales.where((it) => it.isFav).toList(growable: false);
}
