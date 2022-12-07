import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/sort_and_filter/filter_type.dart';
import 'package:mobile_app/domain/model/sort_and_filter/sort_type.dart';
import 'package:mobile_app/domain/model/tale_sort_and_filter/tale_filter_item_data.dart';
import 'package:mobile_app/domain/model/tale_sort_and_filter/tale_sort_item_data.dart';
import 'package:mobile_app/domain/tracking/tracker.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/infrastructure/use_case/tale_sort_and_filter/get_sort_and_filter_items_use_case.dart';
import 'package:mobile_app/infrastructure/use_case/tale_sort_and_filter/save_sort_and_filter_use_case.dart';
import 'package:mobile_app/presentation/navigation/screen/screen_controller.dart';

part 'tale_sort_and_filter_manager.freezed.dart';

part 'tale_sort_and_filter_state.dart';

@injectable
class TaleSortAndFilterManager extends Cubit<TaleSortAndFilterState> {
  final ScreenController _screenController;
  final UseCase<SaveSortAndFilterInput, Dry> _saveSortAndFilterUseCase;
  final UseCase<Dry, GetSortAndFilterItemsOutput> _getSortAndFilterItemsUseCase;
  final Tracker _tracker;

  TaleSortAndFilterManager(
    this._saveSortAndFilterUseCase,
    this._getSortAndFilterItemsUseCase,
    this._screenController,
    this._tracker,
  ) : super(const TaleSortAndFilterState.initial());

  late TaleSortAndFilterStateReady _stateReady;

  void init(TaleFilterType filterType, TaleSortType sortType) async {
    final output = await _getSortAndFilterItemsUseCase.call(dry);

    _stateReady = TaleSortAndFilterState.ready(
      filterItems: output.filterItems,
      selectedFilterType: filterType,
      sortItems: output.sortItems,
      selectedSortType: sortType,
      showApplyButton: false,
    ) as TaleSortAndFilterStateReady;
    emit(_stateReady);
  }

  void onBackPressed() => _screenController.pop();

  void onSortPressed(TaleSortType type) {
    _stateReady = _stateReady.copyWith(
      selectedSortType: type,
      showApplyButton: true,
    );
    emit(_stateReady);
    _tracker.event(TrackingEvents.sortAndFilterSortSelected);
  }

  void onFilterPressed(TaleFilterType type) {
    _stateReady = _stateReady.copyWith(
      selectedFilterType: type,
      showApplyButton: true,
    );
    emit(_stateReady);
    _tracker.event(TrackingEvents.sortAndFilterSortSelected);
  }

  void onApplyBtnPressed() async {
    final input = SaveSortAndFilterInput(
      _stateReady.selectedFilterType,
      _stateReady.selectedSortType,
    );
    await _saveSortAndFilterUseCase.call(input);
    _tracker.event(TrackingEvents.sortAndFilterApplyPressed);
    onBackPressed();
  }
}
