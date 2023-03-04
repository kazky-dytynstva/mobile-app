import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/sort_and_filter/sort_type.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/presentation/resource/r.dart';

@LazySingleton(as: Mapper)
class SortTypeToStringMapper implements Mapper<TaleSortType, StringSingleLine> {
  @override
  StringSingleLine map(TaleSortType input) {
    switch (input) {
      case TaleSortType.random:
        return StringSingleLine(R.strings.taleSortType.random);
      case TaleSortType.newestFirst:
        return StringSingleLine(R.strings.taleSortType.newestFirst);
      case TaleSortType.oldestFirst:
        return StringSingleLine(R.strings.taleSortType.oldestFirst);
      case TaleSortType.byName:
        return StringSingleLine(R.strings.taleSortType.byName);
      case TaleSortType.byAuthor:
        return StringSingleLine(R.strings.taleSortType.byAuthor);
      case TaleSortType.byRating:
        return StringSingleLine(R.strings.taleSortType.byRating);
      case TaleSortType.byRatingAmount:
        return StringSingleLine(R.strings.taleSortType.byRatingAmount);
    }
  }
}
