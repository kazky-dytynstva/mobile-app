import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/infrastructure/data_source/storage_local/tale/entity/tale_entity.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_storage.dart';
import 'package:mobile_app/infrastructure/helper/player/audio_player.dart';

@Injectable(as: UseCase)
class ListenCurrentPlayingUseCase
    extends UseCase<Dry, Option<TalesPageItemData>> {
  final TaleStorage _storage;
  final Mapper<TaleEntity, TalesPageItemData> _mapper;
  final AudioPlayer _player;

  ListenCurrentPlayingUseCase(
    this._storage,
    this._mapper,
    this._player,
  );

  @override
  Stream<Option<TalesPageItemData>> transaction(Dry input) async* {
    final streamTransformer = StreamTransformer.fromHandlers(
      handleData: (Option<TaleId> data, Sink<Option<TalesPageItemData>> sink) {
        void onSome(TaleId id) async {
          final entity = await _storage.find(id);
          if (entity == null) return;
          final item = _mapper.map(entity);
          sink.add(Some(item));
        }

        data.fold(
          () => sink.add(const None()),
          onSome,
        );
      },
    );
    yield* _player.watchPlayingTaleId().transform(streamTransformer);
  }
}
