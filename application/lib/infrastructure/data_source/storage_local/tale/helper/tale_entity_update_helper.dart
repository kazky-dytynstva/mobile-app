import 'package:mobile_app/infrastructure/data_source/storage_local/tale/entity/tale_entity.dart';

abstract class TaleEntityUpdateHelper {
  TaleEntity getUpdated({
    required TaleEntity newTale,
    required TaleEntity currentTale,
  });
}
