import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/sort_and_filter/filter_type.dart';
import 'package:mobile_app/domain/model/sort_and_filter/sort_type.dart';
import 'package:mobile_app/infrastructure/data_source/storage_local/box_names.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_list_storage.dart';

const String _keyFilterType = "_filterType";
const String _keySortType = "_sortType";

@LazySingleton(as: TaleListStorage)
class TaleListStorageImpl implements TaleListStorage {
  final Future<Box<dynamic>> _box;
  final Mapper<TaleFilterType, String> _filterTypeToDbKeyMapper;
  final Mapper<String?, TaleFilterType> _dbKeyToFilterTypeMapper;
  final Mapper<TaleSortType, String> _sortTypeToDbKeyMapper;
  final Mapper<String?, TaleSortType> _dbKeyToSortTypeMapper;

  TaleListStorageImpl(
    HiveInterface hive,
    this._filterTypeToDbKeyMapper,
    this._dbKeyToFilterTypeMapper,
    this._sortTypeToDbKeyMapper,
    this._dbKeyToSortTypeMapper,
  ) : _box = hive.openBox(BoxNames.taleList);

  //region filterType
  @override
  Future<TaleFilterType> getFilterType() async {
    final value = (await _box).get(_keyFilterType) as String?;
    return _dbKeyToFilterTypeMapper.map(value);
  }

  @override
  Future<Unit> setFilterType(TaleFilterType type) async {
    (await _box).put(_keyFilterType, _filterTypeToDbKeyMapper.map(type));
    return unit;
  }

  @override
  Stream<TaleFilterType> watchFilterTypeChanges() async* {
    var prev = await getFilterType();
    final transformer = StreamTransformer.fromHandlers(
      handleData: (BoxEvent event, EventSink<TaleFilterType> sink) {
        final data = event.value as String;
        final value = _dbKeyToFilterTypeMapper.map(data);
        if (prev == value) return;
        sink.add(value);
        prev = value;
      },
    );
    final box = await _box;
    yield* box.watch(key: _keyFilterType).transform(transformer);
  }

  //endregion filterType

  //region sortType
  @override
  Future<TaleSortType> getSortType() async {
    final value = (await _box).get(_keySortType) as String?;
    return _dbKeyToSortTypeMapper.map(value);
  }

  @override
  Future<Unit> setSortType(TaleSortType sortType) async {
    (await _box).put(_keySortType, _sortTypeToDbKeyMapper.map(sortType));
    return unit;
  }

  @override
  Stream<TaleSortType> watchSortTypeChanges() async* {
    var prev = await getSortType();
    final transformer = StreamTransformer.fromHandlers(
      handleData: (BoxEvent event, EventSink<TaleSortType> sink) {
        final data = event.value as String;
        final value = _dbKeyToSortTypeMapper.map(data);
        if (value == prev) return;
        sink.add(value);
        prev = value;
      },
    );
    final box = await _box;
    yield* box.watch(key: _keySortType).transform(transformer);
  }
//endregion sortType
}
