import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/sort_and_filter/filter_type.dart';
import 'package:mobile_app/domain/model/sort_and_filter/sort_type.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_list_storage.dart';
import 'package:mobile_app/data/helper/logger/logger.dart';

@Injectable(as: UseCase)
class GetTaleSortAndFilterTypesUseCase
    extends UseCase<Dry, GetTaleSortAndFilterTypesOutput> {
  final TaleListStorage _storage;
  final Logger _logger;

  GetTaleSortAndFilterTypesUseCase(
    this._storage,
    this._logger,
  );

  @override
  Stream<GetTaleSortAndFilterTypesOutput> transaction(Dry input) async* {
    final filterType = await _storage.getFilterType();
    final sortType = await _storage.getSortType();
    _logger.log(
      () => 'Get tale filter and sort types:\n'
          '  filterType:$filterType\n'
          '  sortType:$sortType',
      tag: logTag,
    );
    yield GetTaleSortAndFilterTypesOutput(filterType, sortType);
  }
}

@immutable
class GetTaleSortAndFilterTypesOutput {
  final TaleFilterType filterType;
  final TaleSortType sortType;

  const GetTaleSortAndFilterTypesOutput(
    this.filterType,
    this.sortType,
  );
}
