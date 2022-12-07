import 'package:mobile_app/domain/model/sort_and_filter/sort_type.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';

abstract class TaleSorter {
  List<TalesPageItemData> sort({
    required TaleSortType type,
    required List<TalesPageItemData> tales,
  });

  void clearRandomness();
}
