import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/helper/tale_sorter.dart';
import 'package:mobile_app/domain/model/sort_and_filter/filter_type.dart';
import 'package:mobile_app/domain/model/sort_and_filter/sort_type.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_list_storage.dart';

@Injectable(as: UseCase)
class SaveSortAndFilterUseCase extends UseCase<SaveSortAndFilterInput, Dry> {
  final TaleListStorage _storage;
  final TaleSorter _taleSorter;

  SaveSortAndFilterUseCase(
    this._storage,
    this._taleSorter,
  );

  @override
  Stream<Dry> transaction(SaveSortAndFilterInput input) async* {
    final oldFilterType = await _storage.getFilterType();
    if (oldFilterType != input.filterType) {
      _taleSorter.clearRandomness();
    }
    await _storage.setFilterType(input.filterType);
    await _storage.setSortType(input.sortType);
    yield dry;
  }
}

class SaveSortAndFilterInput {
  final TaleFilterType filterType;
  final TaleSortType sortType;

  SaveSortAndFilterInput(
    this.filterType,
    this.sortType,
  );
}
