import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_storage.dart';
import 'package:mobile_app/infrastructure/helper/logger/logger.dart';

@Injectable(as: UseCase)
class SaveLastReadPositionUseCase
    extends UseCase<SaveLastReadPositionUseCaseInput, Dry> {
  final TaleStorage _storage;
  final Logger _logger;

  SaveLastReadPositionUseCase(
    this._storage,
    this._logger,
  );

  @override
  Stream<Dry> transaction(SaveLastReadPositionUseCaseInput input) async* {
    final entity = await _storage.find(input.taleId);
    if (entity == null) {
      _logger.log(
        () => 'Tale with id= ${input.taleId.get()} was not found',
        tag: logTag,
        toCrashAnalytics: true,
      );
      yield dry;
      return;
    }
    final changed = entity.lastReadChapter != input.chapterIndex.get() ||
        entity.lastReadPosition != input.itemIndex;
    if (!changed) {
      _logger.log(
        () =>
            'For tale with id=${input.taleId.get()} position and chapter is the same',
        tag: logTag,
      );
    } else {
      final copy = entity.copyWith(
        lastReadPosition: input.itemIndex,
        lastReadChapter: input.chapterIndex.get(),
      );
      await _storage.update(copy);
      _logger.log(
        () =>
            'For tale with id=${input.taleId.get()} saved last read position: chapter=${input.chapterIndex.get()}, index=${input.itemIndex}',
        tag: logTag,
      );
    }

    yield dry;
  }
}

class SaveLastReadPositionUseCaseInput {
  final TaleId taleId;
  final IntPositive chapterIndex;
  final int itemIndex;

  SaveLastReadPositionUseCaseInput({
    required this.taleId,
    required this.chapterIndex,
    required this.itemIndex,
  });
}
