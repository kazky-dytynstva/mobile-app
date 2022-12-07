import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/model/tale_tag/tale_tag.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/infrastructure/data_source/storage_local/tale/entity/tale_entity.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_storage.dart';
import 'package:mobile_app/infrastructure/helper/audio_cache/audio_cache_helper.dart';

@Injectable(as: UseCase)
class GetCachedAudioInfoUseCase extends UseCase<Dry, GetCachedAudioInfoOutput> {
  final Mapper<IntPositive, String> _sizeToStringMapper;
  final Mapper<TaleTag, String> _tagToStringMapper;
  final AudioCacheHelper _cacheHelper;
  final TaleStorage _storage;

  GetCachedAudioInfoUseCase(
    this._sizeToStringMapper,
    this._tagToStringMapper,
    this._cacheHelper,
    this._storage,
  );

  @override
  Stream<GetCachedAudioInfoOutput> transaction(Dry input) async* {
    final output = await _getOutput();
    //notify initial data
    yield output;

    final transformer = StreamTransformer.fromHandlers(
      handleData: (
        Unit _,
        EventSink<GetCachedAudioInfoOutput> sink,
      ) async {
        final output = await _getOutput();
        sink.add(output);
      },
    );

    yield* _cacheHelper.watchWhenFilesChanged().transform(transformer);
  }

  Future<GetCachedAudioInfoOutput> _getOutput() async {
    final allAudioTales = await _getAllAudioTales();
    final cachedAmount = await _cacheHelper.getCachedFilesAmount();

    final needToCacheSize = await _getNeedToCacheSize(allAudioTales);
    final cachedSize =
        _sizeToStringMapper.map(await _cacheHelper.getCachedFilesSize());

    final allAudioTalesAmount = IntPositive(allAudioTales.length);
    final cachedAudioInfo = StringSingleLine(
      '${cachedAmount.get()}/${allAudioTalesAmount.get()} ($cachedSize)',
    );
    final needToCacheAmount = allAudioTalesAmount - cachedAmount;
    final needToCacheAudioInfo = StringSingleLine(
      '$needToCacheAmount (~$needToCacheSize)',
    );

    return GetCachedAudioInfoOutput(
      needToCacheAudioInfo: needToCacheAudioInfo,
      cachedAudioInfo: cachedAudioInfo,
      hasMoreAudioToCache: allAudioTalesAmount > cachedAmount,
      hasCachedAudio: cachedAmount > 0,
    );
  }

  Future<String> _getNeedToCacheSize(Iterable<TaleEntity> allAudioTales) async {
    var size = 0;
    for (final tale in allAudioTales) {
      final id = TaleId(tale.id);
      for (final chapter in tale.content) {
        final isCached = await _cacheHelper.isCached(id, chapter);
        if (!isCached) {
          size += chapter.audioSize ?? 0;
        }
      }
    }
    return _sizeToStringMapper.map(IntPositive(size));
  }

  Future<Iterable<TaleEntity>> _getAllAudioTales() async {
    final allTales = await _storage.getAll();
    final tagText = _tagToStringMapper.map(TaleTag.audio);
    return allTales.where((tale) => tale.tags.contains(tagText));
  }
}

@immutable
class GetCachedAudioInfoOutput {
  final StringSingleLine needToCacheAudioInfo;
  final StringSingleLine cachedAudioInfo;
  final bool hasMoreAudioToCache;
  final bool hasCachedAudio;

  const GetCachedAudioInfoOutput({
    required this.needToCacheAudioInfo,
    required this.cachedAudioInfo,
    required this.hasMoreAudioToCache,
    required this.hasCachedAudio,
  });
}
