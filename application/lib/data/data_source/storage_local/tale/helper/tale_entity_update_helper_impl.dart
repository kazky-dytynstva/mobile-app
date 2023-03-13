import 'package:injectable/injectable.dart';
import 'package:mobile_app/data/data_source/storage_local/tale/entity/tale_entity.dart';

import 'tale_entity_update_helper.dart';

@Injectable(as: TaleEntityUpdateHelper)
class TaleEntityUpdateHelperImpl implements TaleEntityUpdateHelper {
  @override
  TaleEntity getUpdated({
    required TaleEntity newTale,
    required TaleEntity currentTale,
  }) {
    if (newTale.createDate != currentTale.createDate) {
      return newTale;
    }

    final updated = TaleEntity.create(
      id: newTale.id,
      name: newTale.name,
      createDate: newTale.createDate,
      updateDate: newTale.updateDate,
      tags: newTale.tags,
      content: newTale.content,
      crew: newTale.crew,

      //region should be taken from current tale
      isFavorite: currentTale.isFavorite,
      isWatched: currentTale.isWatched,
      isHidden: currentTale.isHidden,
      isRated: currentTale.isRated,
      lastReadChapter: currentTale.lastReadChapter,
      lastReadPosition: currentTale.lastReadPosition,
      rating: currentTale.rating,
      //endregion
    );

    return updated;
  }
}
