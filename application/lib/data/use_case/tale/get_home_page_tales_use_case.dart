import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_storage.dart';
import 'package:mobile_app/domain/helper/tale_sorter.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/sort_and_filter/sort_type.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/data/data_source/storage_local/tale/entity/tale_entity.dart';
import 'package:mobile_app/data/helper/logger/logger.dart';

@Injectable(as: UseCase)
class GetHomePageTalesUseCase
    extends UseCase<GetHomePageTalesInput, List<TalesPageItemData>> {
  final TaleStorage _storage;
  final Mapper<TaleEntity, TalesPageItemData> _mapper;
  final Logger _logger;
  final TaleSorter _taleSorter;

  GetHomePageTalesUseCase(
    this._storage,
    this._mapper,
    this._logger,
    this._taleSorter,
  );

  @override
  Stream<List<TalesPageItemData>> transaction(
    GetHomePageTalesInput input,
  ) async* {
    _logger.log(
      () => 'getHomePageTales useCase called. input: $input',
      tag: logTag,
    );
    final entities = await _storage.getAll();
    assert(entities.length >= input._requestedAmount);

    final allItems = entities.map(_mapper.map).toList();

    final sorted = _getSorted(allItems, input);
    final filtered = sorted.sublist(0, input._requestedAmount);
    yield _getMixed(filtered, input);
  }

  List<TalesPageItemData> _getMixed(
    List<TalesPageItemData> allItems,
    GetHomePageTalesInput input,
  ) {
    switch (input._type) {
      case _GetHomePageTalesType.latest:
        return allItems..shuffle();
      case _GetHomePageTalesType.random:
      case _GetHomePageTalesType.bestRating:
        return allItems;
    }
  }

  List<TalesPageItemData> _getSorted(
    List<TalesPageItemData> allItems,
    GetHomePageTalesInput input,
  ) {
    late final TaleSortType sortType;
    switch (input._type) {
      case _GetHomePageTalesType.random:
        sortType = TaleSortType.random;
        break;
      case _GetHomePageTalesType.latest:
        sortType = TaleSortType.newestFirst;
        break;
      case _GetHomePageTalesType.bestRating:
        sortType = TaleSortType.byRating;
        break;
    }
    return _taleSorter.sort(type: sortType, tales: allItems);
  }
}

@immutable
class GetHomePageTalesInput {
  final int _requestedAmount;
  final _GetHomePageTalesType _type;

  const GetHomePageTalesInput.random({
    required int requestedAmount,
  })  : _requestedAmount = requestedAmount,
        _type = _GetHomePageTalesType.random;

  const GetHomePageTalesInput.latest({
    required int requestedAmount,
  })  : _requestedAmount = requestedAmount,
        _type = _GetHomePageTalesType.latest;

  const GetHomePageTalesInput.bestRating({
    required int requestedAmount,
  })  : _requestedAmount = requestedAmount,
        _type = _GetHomePageTalesType.bestRating;

  @override
  String toString() => '$GetHomePageTalesInput:\n'
      ' - requestedAmount: $_requestedAmount\n'
      ' - type: $_type ';
}

enum _GetHomePageTalesType {
  random,
  latest,
  bestRating,
}
