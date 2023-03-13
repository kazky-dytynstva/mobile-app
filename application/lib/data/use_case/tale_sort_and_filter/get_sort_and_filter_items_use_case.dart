import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/helper/tale_filter.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/sort_and_filter/filter_type.dart';
import 'package:mobile_app/domain/model/sort_and_filter/sort_type.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/domain/model/tale_sort_and_filter/tale_filter_item_data.dart';
import 'package:mobile_app/domain/model/tale_sort_and_filter/tale_sort_item_data.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_graphic.dart';
import 'package:mobile_app/data/data_source/storage_local/tale/entity/tale_entity.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_storage.dart';

@Injectable(as: UseCase)
class GetSortAndFilterItemsUseCase
    extends UseCase<Dry, GetSortAndFilterItemsOutput> {
  final TaleStorage _storage;
  final Mapper<TaleEntity, TalesPageItemData> _taleMapper;
  final Mapper<TaleFilterType, StringSingleLine> _filterNameMapper;
  final Mapper<TaleSortType, StringSingleLine> _sortNameMapper;
  final Mapper<TaleFilterType, SvgAssetGraphic> _filterIconMapper;
  final TaleFilter _taleFilter;

  GetSortAndFilterItemsUseCase(
    this._taleMapper,
    this._storage,
    this._filterNameMapper,
    this._sortNameMapper,
    this._filterIconMapper,
    this._taleFilter,
  );

  @override
  Stream<GetSortAndFilterItemsOutput> transaction(Dry input) async* {
    final allTaleEntities = await _storage.getAll();
    final allTales = allTaleEntities.map((it) => _taleMapper.map(it)).toList();

    final filterItems = _getFilterModels(allTales);
    final sortItems = _getTaleSortItemData();

    yield GetSortAndFilterItemsOutput(filterItems, sortItems);
  }

  List<TaleFilterItemData> _getFilterModels(List<TalesPageItemData> allTales) =>
      TaleFilterType.values
          .map((type) => TaleFilterItemData(
                type,
                _filterNameMapper.map(type),
                _filterIconMapper.map(type),
                IntPositive(
                  _taleFilter.filter(type: type, tales: allTales).length,
                ),
              ))
          .where((data) => !(data.type.isHidden && data.amount.get() == 0))
          .toList();

  List<TaleSortItemData> _getTaleSortItemData() => TaleSortType.values
      .map((type) => TaleSortItemData(
            type,
            _sortNameMapper.map(type),
          ))
      .toList();
}

class GetSortAndFilterItemsOutput {
  final List<TaleFilterItemData> filterItems;
  final List<TaleSortItemData> sortItems;

  GetSortAndFilterItemsOutput(
    this.filterItems,
    this.sortItems,
  );
}
