part of 'tale_sort_and_filter_manager.dart';

@freezed
abstract class TaleSortAndFilterState with _$TaleSortAndFilterState {
  const factory TaleSortAndFilterState.initial() = _Initial;

  const factory TaleSortAndFilterState.ready({
    required List<TaleFilterItemData> filterItems,
    required TaleFilterType selectedFilterType,
    required List<TaleSortItemData> sortItems,
    required TaleSortType selectedSortType,
    required bool showApplyButton,
  }) = TaleSortAndFilterStateReady;
}
