import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/sort_and_filter/filter_type.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_graphic.dart';
import 'package:mobile_app/presentation/resource/r.dart';

@LazySingleton(as: Mapper)
class FilterTypeToStringMapper
    implements Mapper<TaleFilterType, SvgAssetGraphic> {
  @override
  SvgAssetGraphic map(TaleFilterType input) {
    switch (input) {
      case TaleFilterType.all:
        return R.assets.graphics.allTales;
      case TaleFilterType.national:
        return R.assets.graphics.national;
      case TaleFilterType.author:
        return R.assets.graphics.author;
      case TaleFilterType.audio:
        return R.assets.graphics.audio;
      case TaleFilterType.lullaby:
        return R.assets.graphics.lullaby;
      case TaleFilterType.poem:
        return R.assets.graphics.poem;
      case TaleFilterType.lastAdded:
        return R.assets.graphics.lastAdded;
      case TaleFilterType.hidden:
        return R.assets.graphics.unseen;
      case TaleFilterType.unwatched:
        return R.assets.graphics.unseen;
      case TaleFilterType.favorite:
        return R.assets.graphics.favorite;
    }
  }
}
