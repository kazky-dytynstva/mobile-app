import 'package:dartz/dartz.dart';
import 'package:mobile_app/data/data_source/storage_local/tale/entity/tale_entity.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/model/changed_data/changed_data.dart';
import 'package:mobile_app/data/data_source/storage_local/tale/entity/rating/rating_entity.dart';

abstract class TaleStorage {
  Future<bool> isEmpty();

  Future<Iterable<TaleEntity>> getAll();

  Future<TaleEntity?> find(TaleId taleId);

  Future<Unit> update(TaleEntity entity);

  Future<Unit> updateTales(Iterable<TaleEntity> tales);

  Future<Unit> updateRatings(Map<TaleId, RatingEntity> ratings);

  Future<Unit> deleteTales(Iterable<TaleId> tales);

  /// Emit [ChangedData] when changes happened :)
  /// If [taleId] is NOT null, then will [watch] changes for it,
  /// otherwise - for the whole storage
  Stream<ChangedData<TaleEntity, TaleId>> watch({TaleId? taleId});
}
