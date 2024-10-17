import 'dart:async';

import 'package:collection/collection.dart';
import 'package:bloc/bloc.dart';
import 'package:mobile_app/domain/model/rating/rating_data.dart';
import 'package:mobile_app/domain/model/sort_and_filter/data/sort_and_filter_open_type.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_name.dart';
import 'package:mobile_app/domain/model/tale_sort_and_filter/tale_filter_item_data.dart';
import 'package:mobile_app/domain/model/tale_sort_and_filter/tale_sort_item_data.dart';
import 'package:mobile_app/domain/navigation/snackbar_controller.dart';
import 'package:mobile_app/domain/tracking/tracker.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_graphic.dart';
import 'package:mobile_app/data/use_case/tale/get_tale_use_case.dart';
import 'package:mobile_app/data/use_case/tale_sort_and_filter/filter_and_sort_tales_use_case.dart';
import 'package:mobile_app/data/use_case/tale_sort_and_filter/get_tale_sort_and_filter_type.dart';
import 'package:mobile_app/presentation/navigation/dialog/dialog_controller.dart';
import 'package:mobile_app/presentation/navigation/screen/screen_controller.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/changed_data/changed_data.dart';
import 'package:mobile_app/domain/model/sort_and_filter/filter_type.dart';
import 'package:mobile_app/domain/model/sort_and_filter/sort_type.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/data/use_case/tale/change_tale_fav.dart';

part 'tales_page_manager.freezed.dart';

part 'tales_page_state.dart';

@injectable
class TalesPageManager extends Cubit<TalesPageState> {
  final ScreenController _screenController;
  final DialogController _dialogController;
  final SnackbarController _snackbarController;
  final UseCase<Dry, Iterable<TalesPageItemData>> _getAllTalesUseCase;
  final UseCase<Dry, GetTaleSortAndFilterTypesOutput>
      _getFilterAndSortTypesUseCase;
  final UseCase<Dry, ChangedData<TalesPageItemData, TaleId>>
      _listenAllTalesUseCase;
  final UseCase<ChangeTaleFavInput, Dry> _changeTaleFavUseCase;
  final UseCase<Dry, TaleSortType> _listenSortTypeChangeOutput;
  final UseCase<Dry, TaleFilterType> _listenFilterTypeChangeOutput;
  final UseCase<TaleId, GetTaleOutput> _getTaleUseCase;
  final UseCase<FilterAndSortTalesInput, List<TalesPageItemData>>
      _filterAndSortTalesUseCase;
  final Mapper<TaleFilterType, StringSingleLine> _filterTypeToNameMapper;
  final Mapper<TaleFilterType, SvgAssetGraphic> _filterTypeToIconMapper;
  final Mapper<TaleSortType, StringSingleLine> _sortTypeToNameMapper;
  final Tracker _tracker;

  TalesPageManager(
    this._snackbarController,
    this._screenController,
    this._dialogController,
    this._getAllTalesUseCase,
    this._getFilterAndSortTypesUseCase,
    this._changeTaleFavUseCase,
    this._listenAllTalesUseCase,
    this._filterAndSortTalesUseCase,
    this._getTaleUseCase,
    this._listenSortTypeChangeOutput,
    this._listenFilterTypeChangeOutput,
    this._filterTypeToNameMapper,
    this._sortTypeToNameMapper,
    this._filterTypeToIconMapper,
    this._tracker,
  ) : super(const TalesPageState.initial()) {
    _init();
  }

  final _updateTaleController = StreamController<Dry>();
  late TaleFilterType _filterType;
  late TaleSortType _sortType;
  final _allTales = <TalesPageItemData>[];
  final _subscriptions = UseCaseSubscriptionGroup();

  @override
  Future<void> close() async {
    await _subscriptions.cancel();
    await _updateTaleController.close();
    return super.close();
  }

  void onTaleFavPressed(TalesPageItemData item) {
    _tracker.event(TrackingEvents.talesPageFavPressed);
    _changeTaleFav(item);
  }

  void onFilterPressed() => _openSortAndFilter(SortAndFilterOpenType.filter);

  void onSortPressed() => _openSortAndFilter(SortAndFilterOpenType.sort);

  void onTalePressed(TalesPageItemData item) async {
    _tracker.event(TrackingEvents.talesPageTalePressed);
    _openTale(item);
  }

  void onSearchPressed() {
    _tracker.event(TrackingEvents.talesPageSearchPressed);
    _screenController.openSearchTale();
  }

  void onRatingPressed(
    TaleName name,
    RatingData data,
  ) {
    _tracker.event(TrackingEvents.talesPageTaleRatingPressed);
    _dialogController.showTaleRating(name: name, data: data);
  }

  void _init() async {
    final tales = await _getAllTalesUseCase.call(dry);
    _allTales.addAll(tales);

    final typesOutput = await _getFilterAndSortTypesUseCase.call(dry);
    _filterType = typesOutput.filterType;
    _sortType = typesOutput.sortType;

    _updateState(dry);
    _addListeners();
  }

  void _updateState(Dry dry) async {
    final input = FilterAndSortTalesInput(_filterType, _sortType, _allTales);
    final filteredAndSorted = await _filterAndSortTalesUseCase.call(input);

    final filterData = TaleFilterItemData(
      _filterType,
      _filterTypeToNameMapper.map(_filterType),
      _filterTypeToIconMapper.map(_filterType),
      IntPositive(filteredAndSorted.length),
    );
    final sortData = TaleSortItemData(
      _sortType,
      _sortTypeToNameMapper.map(_sortType),
    );
    final newState = TalesPageState.ready(
      filterData: filterData,
      sortData: sortData,
      tales: List.from(filteredAndSorted),
    );
    emit(newState);
  }

  void _addListeners() {
    void taleDeleted(TaleId id) {
      final tale = _allTales.firstWhereOrNull((tale) => tale.id == id);
      if (tale != null) {
        _allTales.remove(tale);
        _updateTaleController.add(dry);
      }
    }

    void taleUpdated(TalesPageItemData item) {
      final tale = _allTales.firstWhereOrNull((tale) => tale.id == item.id);
      if (tale == null || tale != item) {
        _allTales.remove(tale);
        _allTales.add(item);
        _updateTaleController.add(dry);
      }
    }

    final taleSubscription = _listenAllTalesUseCase.listen(
      dry,
      (ChangedData<TalesPageItemData, TaleId> data) {
        data.map(
          deleted: taleDeleted,
          updated: taleUpdated,
        );
      },
    );
    _subscriptions.add(taleSubscription);

    final sortSubscription = _listenSortTypeChangeOutput.listen(
      dry,
      (TaleSortType type) {
        _sortType = type;
        _updateTaleController.add(dry);
      },
    );
    _subscriptions.add(sortSubscription);

    final filterSubscription = _listenFilterTypeChangeOutput.listen(
      dry,
      (TaleFilterType type) {
        _filterType = type;
        _updateTaleController.add(dry);
      },
    );
    _subscriptions.add(filterSubscription);

    _updateTaleController.stream
        .debounce(R.durations.updateTaleListDebounce)
        .listen(_updateState);
  }

  void _openSortAndFilter(SortAndFilterOpenType openType) {
    late final TrackingEvent event;
    switch (openType) {
      case SortAndFilterOpenType.filter:
        event = TrackingEvents.talesPageFilterPressed;
        break;
      case SortAndFilterOpenType.sort:
        event = TrackingEvents.talesPageSortPressed;
        break;
    }
    _tracker.event(event);
    _screenController.openSortAndFilter(
      openType: openType,
      sortType: _sortType,
      filterType: _filterType,
    );
  }

  void _openTale(TalesPageItemData item) async {
    final taleOutput = await _getTaleUseCase.call(item.id);
    _screenController.openTale(
      tale: taleOutput.tale,
      openAudio: _filterType.isAudio,
    );
  }

  void _changeTaleFav(TalesPageItemData item) {
    void doAction(bool newFavStatus) {
      final input = ChangeTaleFavInput(item.id, newFavStatus);
      _changeTaleFavUseCase.call(input);
    }

    doAction(!item.isFav);

    if (_filterType.isFav && item.isFav) {
      _snackbarController.showBringBackFavTale(
        name: item.name,
        onBringBackPressed: () {
          _tracker.event(TrackingEvents.talesPageFavUndoPressed);
          doAction(true);
        },
      );
    }
  }
}
