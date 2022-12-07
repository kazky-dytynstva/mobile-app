import 'package:dartz/dartz.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/value_objects/file_path.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/infrastructure/data_source/storage_local/tale/entity/chapter/chapter_entity.dart';

abstract class AudioCacheHelper {
  Future<bool> delete(TaleId taleId, int index);

  Future<Unit> deleteAll();

  Future<bool> isCached(TaleId id, TaleChapterEntity entity);

  FilePath getTaleAudioPath(TaleId id, int index);

  Future<IntPositive> getCachedFilesAmount();

  Future<IntPositive> getCachedFilesSize();

  Stream<Unit> watchWhenFilesChanged();
}
