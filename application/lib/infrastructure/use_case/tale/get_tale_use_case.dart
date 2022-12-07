import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/tale/tale.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/infrastructure/data_source/storage_local/tale/entity/tale_entity.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_storage.dart';

@Injectable(as: UseCase)
class GetTaleUseCase extends UseCase<TaleId, GetTaleOutput> {
  final TaleStorage _storage;
  final Mapper<TaleEntity, Tale> _mapper;

  GetTaleUseCase(
    this._storage,
    this._mapper,
  );

  @override
  Stream<GetTaleOutput> transaction(TaleId input) async* {
    final entity = await _storage.find(input);
    final tale = _mapper.map(entity!);
    yield GetTaleOutput(tale);
  }
}

@immutable
class GetTaleOutput {
  final Tale tale;

  const GetTaleOutput(this.tale);
}
