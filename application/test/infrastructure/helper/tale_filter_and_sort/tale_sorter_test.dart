import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/domain/constant/alphabet.dart';
import 'package:mobile_app/domain/model/rating/rating_data.dart';
import 'package:mobile_app/domain/model/sort_and_filter/sort_type.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_name.dart';
import 'package:mobile_app/domain/model/tale_tag/tale_tag.dart';
import 'package:mobile_app/domain/value_objects/image_url.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/infrastructure/helper/tale_filter_and_sort/tale_sorter.dart';

part 'tale_sorter_test.util.dart';

void main() {
  late TaleSorterImpl sorter;

  setUp(() {
    sorter = TaleSorterImpl();
  });

  group(
    'by name',
    () {
      const sortType = TaleSortType.byName;

      test(
        'GIVEN random by unique name THEN return sorted alphabetically by name',
        () {
          final randomTales = orderedByNameRandom();
          expect(randomTales, isNot(equals(orderedByName)));

          final result = sorter.sort(type: sortType, tales: randomTales);

          expect(result, equals(orderedByName));
        },
      );

      test(
        'GIVEN list with same Name but different Provider THEN return sorted alphabetically by Provider',
        () {
          final randomTales = orderedByProviderRandom();
          expect(randomTales, isNot(equals(orderedByProvider)));

          final result = sorter.sort(type: sortType, tales: randomTales);

          expect(result, equals(orderedByProvider));
        },
      );

      test(
        'GIVEN list with same Name and same Provider THEN return sorted by hashCode',
        () {
          final expectedResult = idListOrderedByHashCode();
          final randomTales = List<TalesPageItemData>.from(expectedResult);
          randomTales.shuffle();
          expect(randomTales, isNot(equals(expectedResult)));

          final result = sorter.sort(type: sortType, tales: randomTales);

          expect(result, equals(expectedResult));
        },
      );
    },
  );

  group(
    'by author',
    () {
      const sortType = TaleSortType.byAuthor;

      test(
        'GIVEN random by unique provider THEN return sorted alphabetically by provider',
        () {
          final randomTales = orderedByProviderRandom();
          expect(randomTales, isNot(equals(orderedByProvider)));

          final result = sorter.sort(type: sortType, tales: randomTales);

          expect(result, equals(orderedByProvider));
        },
      );

      test(
        'GIVEN list with same Provider but different name THEN return sorted alphabetically by Name',
        () {
          final randomTales = orderedByNameRandom();
          expect(randomTales, isNot(equals(orderedByName)));

          final result = sorter.sort(type: sortType, tales: randomTales);

          expect(result, equals(orderedByName));
        },
      );

      test(
        'GIVEN list with same Name and same Provider THEN return sorted by hashCode',
        () {
          final expectedResult = idListOrderedByHashCode();

          final randomTales = List<TalesPageItemData>.from(expectedResult);
          randomTales.shuffle();
          expect(randomTales, isNot(equals(expectedResult)));

          final result = sorter.sort(type: sortType, tales: randomTales);

          expect(result, equals(expectedResult));
        },
      );
    },
  );

  group(
    'by Rating',
    () {
      // This sorting is not ready
      const sortType = TaleSortType.byRating;
      test(
        'GIVEN list with random rating THEN return same list',
        () {
          final randomTales = orderedByNameRandom();
          expect(randomTales, isNot(equals(orderedByName)));

          final result = sorter.sort(type: sortType, tales: randomTales);

          expect(result, equals(randomTales));
        },
      );
    },
  );

  group(
    'by RatingAmount',
    () {
      // This sorting is not ready
      const sortType = TaleSortType.byRatingAmount;
      test(
        'GIVEN list with random rating THEN return same list',
        () {
          final randomTales = orderedByNameRandom();
          expect(randomTales, isNot(equals(orderedByName)));

          final result = sorter.sort(type: sortType, tales: randomTales);

          expect(result, equals(randomTales));
        },
      );
    },
  );

  group(
    'by random',
    () {
      const sortType = TaleSortType.random;
      test(
        'GIVEN empty randomList and randomMap BEFORE starting map',
        () {
          expect(sorter.randomIdList, isEmpty);
        },
      );

      test(
        'GIVEN randomIdList THEN sort by randomIdList',
        () {
          sorter.randomIdList.addAll(orderedById.map((e) => e.id));
          final talesToSort = List<TalesPageItemData>.from(orderedById);
          talesToSort.shuffle();
          expect(orderedById, isNot(equals(talesToSort)));

          final result = sorter.sort(type: sortType, tales: talesToSort);
          expect(result, equals(orderedById));
        },
      );
      group(
        'verify randomIdList is NOT empty when the sort type not random',
        () {
          final listToSort = orderedIdMap.values.toList();
          setUp(() {
            sorter.randomIdList.addAll(orderedIdList);
          });
          TaleSortType.values
              .where((element) => element != TaleSortType.random)
              .forEach(
            (sortType) {
              test(
                'GIVEN nonEmpty random list and map WHEN $sortType THEN list and map after sort are NOT empty',
                () {
                  expect(sorter.randomIdList, isNotEmpty);
                  sorter.sort(type: sortType, tales: listToSort);
                  expect(sorter.randomIdList, isNotEmpty);
                },
              );
            },
          );
          test(
            'GIVEN nonEmpty random list and map WHEN ${TaleSortType.random} THEN list and map after sort are NOT empty and the same',
            () {
              sorter.sort(type: TaleSortType.random, tales: listToSort);

              expect(sorter.randomIdList, equals(orderedIdList));
            },
          );
        },
      );

      group(
        'verify randomIdList are set correctly',
        () {
          setUp(() {
            expect(sorter.randomIdList, isEmpty);
          });

          test(
            'GIVEN sorted tales THEN receive randomized one',
            () {
              // ARRANGE
              final listToSort = List<TalesPageItemData>.from(orderedById);
              final expectedRandomIdList = orderedById.map((e) => e.id);

              // ACT
              sorter.updateRandomIdList(listToSort);

              // ASSERT
              expect(sorter.randomIdList, isNot(equals(expectedRandomIdList)));
              // here we need to make sure that the content of those 2 list
              // is the same, so we will sort them in same way
              sorter.randomIdList.sort((a, b) => a.get().compareTo(b.get()));
              expect(sorter.randomIdList, equals(orderedById.map((e) => e.id)));
            },
          );

          test(
            'GIVEN randomIdList with 1 item WHEN new list contains 2 more new items THEN randomIdList will contain all 3 items',
            () {
              // ARRANGE
              final item0 = createItem(id: 0);
              final item1 = createItem(id: 1);
              final item2 = createItem(id: 2);
              sorter.randomIdList.add(item0.id);

              // ACT
              sorter.updateRandomIdList([item0, item1, item2]);

              // ASSERT
              expect(sorter.randomIdList.length, equals(3));

              expect(sorter.randomIdList.contains(item0.id), isTrue);
              expect(sorter.randomIdList.contains(item1.id), isTrue);
              expect(sorter.randomIdList.contains(item2.id), isTrue);
            },
          );

          test(
            'GIVEN randomIdList with 3 items WHEN new list contains 2 less items THEN randomIdList will contain only 1 item',
            () {
              // ARRANGE
              final item0 = createItem(id: 0);
              final item1 = createItem(id: 1);
              final item2 = createItem(id: 2);
              sorter.randomIdList.addAll([item0.id, item1.id, item2.id]);

              // ACT
              sorter.updateRandomIdList([item0]);

              // ASSERT
              expect(sorter.randomIdList.length, equals(1));

              expect(sorter.randomIdList.contains(item0.id), isTrue);
            },
          );

          test(
            'GIVEN randomIdList with 3 items WHEN new list contains 1 less items and 1 new item THEN randomIdList will contain correct 3 items',
            () {
              // ARRANGE
              final item0 = createItem(id: 0);
              final item1 = createItem(id: 1);
              final item2 = createItem(id: 2);
              final item3 = createItem(id: 3);
              sorter.randomIdList.addAll([item0.id, item1.id, item2.id]);

              // ACT
              sorter.updateRandomIdList([item1, item2, item3]);

              // ASSERT
              expect(sorter.randomIdList.length, equals(3));

              expect(sorter.randomIdList.contains(item1.id), isTrue);
              expect(sorter.randomIdList.contains(item2.id), isTrue);
              expect(sorter.randomIdList.contains(item3.id), isTrue);
            },
          );
        },
      );
    },
  );

  test(
    'GIVEN non empty randomIdList WHEN clearRandomness called THEN list is empty',
    () {
      sorter.randomIdList.addAll(orderedIdList);

      sorter.clearRandomness();

      expect(sorter.randomIdList, isEmpty);
    },
  );
}
