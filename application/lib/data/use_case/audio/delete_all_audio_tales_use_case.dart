import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/tale_tag/tale_tag.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_storage.dart';
import 'package:mobile_app/data/helper/audio_cache/audio_cache_helper.dart';
import 'package:mobile_app/data/helper/logger/logger.dart';

@Injectable(as: UseCase)
class DeleteAllAudioTalesUseCase
    extends UseCase<Dry, DeleteAllAudioTalesOutput> {
  final AudioCacheHelper _cacheHelper;
  final TaleStorage _storage;
  final Mapper<TaleTag, String> _tagToStringMapper;
  final Logger _logger;

  DeleteAllAudioTalesUseCase(
    this._cacheHelper,
    this._tagToStringMapper,
    this._storage,
    this._logger,
  );

  @override
  Stream<DeleteAllAudioTalesOutput> transaction(Dry input) async* {
    _logger.log(() => 'Delete all audio tale started', tag: logTag);

    final cachedTales = await _cacheHelper.getCachedFilesAmount();
    if (cachedTales > 0) {
      await _cacheHelper.deleteAll();
      await _notifyTalesAudioWasDeleted();
    }
    _logger.log(() => 'Delete all audio tale DONE', tag: logTag);

    yield output;
  }

  Future<void> _notifyTalesAudioWasDeleted() async {
    final allTales = await _storage.getAll();
    final tagText = _tagToStringMapper.map(TaleTag.audio);
    final updated = allTales
        .where((tale) => tale.tags.contains(tagText))
        .map((tale) => tale.copyWith(updateDate: (tale.updateDate ?? 0) + 1));
    await _storage.updateTales(updated);
  }
}

class DeleteAllAudioTalesOutput {
  const DeleteAllAudioTalesOutput._();
}

const output = DeleteAllAudioTalesOutput._();
