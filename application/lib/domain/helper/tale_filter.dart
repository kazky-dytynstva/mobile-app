import 'package:mobile_app/domain/model/sort_and_filter/filter_type.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';

abstract class TaleFilter {
  List<TalesPageItemData> filter({
    required TaleFilterType type,
    required List<TalesPageItemData> tales,
  });
}
