import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/sort_and_filter/sort_type.dart';

const _random = 'random';
const _newestFirst = 'newestFirst';
const _oldestFirst = 'oldestFirst';
const _byName = 'byName';
const _byAuthor = 'byAuthor';
const _byRating = 'byRating';
const _byRatingAmount = 'byRatingAmount';

@Singleton(as: Mapper)
class TaleSortTypeToDbKeyMapper implements Mapper<TaleSortType, String> {
  @override
  String map(TaleSortType input) {
    switch (input) {
      case TaleSortType.random:
        return _random;
      case TaleSortType.oldestFirst:
        return _oldestFirst;
      case TaleSortType.newestFirst:
        return _newestFirst;
      case TaleSortType.byName:
        return _byName;
      case TaleSortType.byAuthor:
        return _byAuthor;
      case TaleSortType.byRating:
        return _byRating;
      case TaleSortType.byRatingAmount:
        return _byRatingAmount;
    }
  }
}

@Singleton(as: Mapper)
class DbKeyToTaleSortTypeMapper implements Mapper<String?, TaleSortType> {
  @override
  TaleSortType map(String? input) {
    switch (input) {
      case _byAuthor:
        return TaleSortType.byAuthor;
      case _byRating:
        return TaleSortType.byRating;
      case _byRatingAmount:
        return TaleSortType.byRatingAmount;
      case _byName:
        return TaleSortType.byName;
      case _newestFirst:
        return TaleSortType.newestFirst;
      case _oldestFirst:
        return TaleSortType.oldestFirst;
      case _random:
      default:
        return TaleSortType.random;
    }
  }
}
