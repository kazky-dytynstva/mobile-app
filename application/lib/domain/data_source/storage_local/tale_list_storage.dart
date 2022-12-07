import 'package:dartz/dartz.dart';
import 'package:mobile_app/domain/model/sort_and_filter/filter_type.dart';
import 'package:mobile_app/domain/model/sort_and_filter/sort_type.dart';

abstract class TaleListStorage {
  //region filterType
  Future<TaleFilterType> getFilterType();

  Future<Unit> setFilterType(TaleFilterType type);

  Stream<TaleFilterType> watchFilterTypeChanges();

  //endregion filterType

  //region sortType
  Future<TaleSortType> getSortType();

  Future<Unit> setSortType(TaleSortType sortType);

  Stream<TaleSortType> watchSortTypeChanges();
//endregion sortType
}
