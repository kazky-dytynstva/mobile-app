import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/domain/model/sort_and_filter/filter_type.dart';
import 'package:mobile_app/domain/model/sort_and_filter/sort_type.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/data/use_case/tale_sort_and_filter/save_sort_and_filter_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/mocks/mocks.dart';

void main() {
  late MockTaleSorter sorter;
  late MockTaleListStorage storage;
  late SaveSortAndFilterUseCase useCase;
  const defaultFilterType = TaleFilterType.all;
  const defaultSortType = TaleSortType.byAuthor;

  setUp(() {
    sorter = MockTaleSorter();
    storage = MockTaleListStorage();
    useCase = SaveSortAndFilterUseCase(storage, sorter);

    registerFallbackValue(defaultFilterType);
    registerFallbackValue(defaultSortType);

    when(() => storage.getFilterType())
        .thenAnswer((_) async => defaultFilterType);
    when(() => storage.setFilterType(any())).thenAnswer((_) async => unit);
    when(() => storage.setSortType(any())).thenAnswer((_) async => unit);
  });

  test(
    'GIVEN input with same filterType and unique sortType THEN save types and DO NOT reset randomness',
    () async {
      // ARRANGE
      final input = SaveSortAndFilterInput(
        defaultFilterType,
        defaultSortType,
      );

      // ACT
      final result = await useCase.call(input);

      // ASSERT
      expect(result, equals(dry));
      verifyInOrder([
        () => storage.getFilterType(),
        () => storage.setFilterType(defaultFilterType),
        () => storage.setSortType(defaultSortType),
      ]);
      verifyNoMoreInteractions(storage);
      verifyZeroInteractions(sorter);
    },
  );

  test(
    'GIVEN input with another filterType and any sortType THEN save types and reset randomness',
    () async {
      // ARRANGE
      final input = SaveSortAndFilterInput(
        TaleFilterType.favorite,
        defaultSortType,
      );
      expect(input.filterType, isNot(equals(defaultFilterType)));

      // ACT
      final result = await useCase.call(input);

      // ASSERT
      expect(result, equals(dry));
      verifyInOrder([
        () => storage.getFilterType(),
        () => sorter.clearRandomness(),
        () => storage.setFilterType(input.filterType),
        () => storage.setSortType(defaultSortType),
      ]);
      verifyNoMoreInteractions(storage);
      verifyNoMoreInteractions(sorter);
    },
  );
}
