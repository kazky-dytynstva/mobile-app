import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/helper/tale_filter.dart';
import 'package:mobile_app/domain/helper/tale_sorter.dart';
import 'package:mobile_app/domain/model/sort_and_filter/filter_type.dart';
import 'package:mobile_app/domain/model/sort_and_filter/sort_type.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';

@Injectable(as: UseCase)
class FilterAndSortTalesUseCase
    extends UseCase<FilterAndSortTalesInput, List<TalesPageItemData>> {
  final TaleFilter _filter;
  final TaleSorter _sorter;

  FilterAndSortTalesUseCase(
    this._filter,
    this._sorter,
  );

  @override
  Stream<List<TalesPageItemData>> transaction(
    FilterAndSortTalesInput input,
  ) async* {
    final filtered = _filter.filter(
      type: input.filterType,
      tales: input.tales,
    );

    final sorted = _sorter.sort(
      type: input.sortType,
      tales: filtered,
    );

    yield sorted;
  }
}

@immutable
class FilterAndSortTalesInput {
  final TaleFilterType filterType;
  final TaleSortType sortType;
  final List<TalesPageItemData> tales;

  const FilterAndSortTalesInput(
    this.filterType,
    this.sortType,
    this.tales,
  );
}
