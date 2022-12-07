import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/constant/alphabet.dart';
import 'package:mobile_app/domain/extensions/string.dart';
import 'package:mobile_app/domain/helper/tale_sorter.dart';
import 'package:mobile_app/domain/model/sort_and_filter/sort_type.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';

@LazySingleton(as: TaleSorter)
class TaleSorterImpl implements TaleSorter {
  late final _random = Random();
  @visibleForTesting
  late final randomIdList = <TaleId>[];

  @override
  void clearRandomness() => randomIdList.clear();

  @override
  List<TalesPageItemData> sort({
    required TaleSortType type,
    required List<TalesPageItemData> tales,
  }) {
    switch (type) {
      case TaleSortType.random:
        return _sortRandom(tales);
      case TaleSortType.byName:
        return _sortByName(tales);
      case TaleSortType.byAuthor:
        return _sortByAuthor(tales);
      case TaleSortType.byRating:
        return _sortByRating(tales);
      case TaleSortType.byRatingAmount:
        return _sortByRatingAmount(tales);
    }
  }

  List<TalesPageItemData> _sortRandom(List<TalesPageItemData> tales) {
    final randomSortedIdList = updateRandomIdList(tales);
    final randomMap = _getRandomMap(tales, randomSortedIdList);
    return randomIdList.map((id) => randomMap[id]!).toList(growable: false);
  }

  @visibleForTesting
  List<TaleId> updateRandomIdList(List<TalesPageItemData> tales) {
    final newIdList = tales.map((e) => e.id);
    if (randomIdList.isEmpty) {
      randomIdList.addAll(newIdList);
      randomIdList.shuffle(_random);
    } else {
      // this can happen, if we already show some list with tales,
      // but then some updates arrives from BE with some added tales.
      for (final id in newIdList) {
        if (!randomIdList.contains(id)) {
          // so we need to add them to the random list and map
          randomIdList.add(id);
        }
      }

      // this can happen, when tales miss some items, which was added before
      // so we need to remove them from the _randomIdList
      if (newIdList.length < randomIdList.length) {
        // we need this copy, cos we can not do forEach in a list
        // and remove items from it in the same loop
        final copiedRandom = List.from(randomIdList);
        for (final id in copiedRandom) {
          if (!newIdList.contains(id)) {
            randomIdList.remove(id);
          }
        }
      }
    }
    return randomIdList;
  }

  Map<TaleId, TalesPageItemData> _getRandomMap(
    List<TalesPageItemData> tales,
    List<TaleId> randomSortedIdList,
  ) {
    final map = <TaleId, TalesPageItemData>{};
    for (int i = 0; i < randomSortedIdList.length; i++) {
      final id = randomSortedIdList[i];
      final tale = tales.firstWhere((element) => element.id == id);
      map[id] = tale;
    }
    return map;
  }

  List<TalesPageItemData> _sortByName(List<TalesPageItemData> tales) {
    int comparator(TalesPageItemData first, TalesPageItemData second) {
      final result0 = _compareName(first, second);
      if (result0 != 0) return result0;

      final result1 = _compareProvider(first, second);
      if (result1 != 0) return result1;

      return first.hashCode.compareTo(second.hashCode);
    }

    tales.sort(comparator);
    return tales;
  }

  List<TalesPageItemData> _sortByAuthor(List<TalesPageItemData> tales) {
    int comparator(TalesPageItemData first, TalesPageItemData second) {
      final result0 = _compareProvider(first, second);
      if (result0 != 0) return result0;

      final result1 = _compareName(first, second);
      if (result1 != 0) return result1;
      return first.hashCode.compareTo(second.hashCode);
    }

    tales.sort(comparator);
    return tales;
  }

  List<TalesPageItemData> _sortByRating(List<TalesPageItemData> tales) {
    int comparator(TalesPageItemData first, TalesPageItemData second) {
      final result0 = _compareRating(first, second);
      if (result0 != 0) return result0;

      final result1 = _compareProvider(first, second);
      if (result1 != 0) return result1;

      final result2 = _compareName(first, second);
      if (result2 != 0) return result2;
      return first.hashCode.compareTo(second.hashCode);
    }

    tales.sort(comparator);
    return tales;
  }

  List<TalesPageItemData> _sortByRatingAmount(List<TalesPageItemData> tales) {
    int comparator(TalesPageItemData first, TalesPageItemData second) {
      final result0 = _compareRatingAmount(first, second);
      if (result0 != 0) return result0;

      final result1 = _compareRating(first, second);
      if (result1 != 0) return result1;

      final result2 = _compareProvider(first, second);
      if (result2 != 0) return result2;

      final result3 = _compareName(first, second);
      if (result3 != 0) return result3;
      return first.hashCode.compareTo(second.hashCode);
    }

    tales.sort(comparator);
    return tales;
  }

  int _compare({
    required String first,
    required String second,
  }) =>
      first.localeCompareTo(second, alphabetUA, ignoreCase: false);

  int _compareName(TalesPageItemData a, TalesPageItemData b) => _compare(
        first: a.name.get(),
        second: b.name.get(),
      );

  int _compareProvider(TalesPageItemData a, TalesPageItemData b) => _compare(
        first: a.provider.get(),
        second: b.provider.get(),
      );

  int _compareRating(TalesPageItemData a, TalesPageItemData b) {
    final ratingA = a.optionRating.fold(
      () => 0.0,
      (rating) => rating.avg,
    );
    final ratingB = b.optionRating.fold(
      () => 0.0,
      (rating) => rating.avg,
    );
    return ratingB.compareTo(ratingA);
  }

  int _compareRatingAmount(TalesPageItemData a, TalesPageItemData b) {
    final ratingA = a.optionRating.fold(
      () => 0.0,
      (rating) => rating.numberOfRatings.get(),
    );
    final ratingB = b.optionRating.fold(
      () => 0.0,
      (rating) => rating.numberOfRatings.get(),
    );
    return ratingB.compareTo(ratingA);
  }
}
