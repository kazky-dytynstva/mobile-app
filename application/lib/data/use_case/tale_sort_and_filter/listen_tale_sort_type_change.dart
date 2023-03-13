import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/sort_and_filter/sort_type.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_list_storage.dart';
import 'package:mobile_app/data/helper/logger/logger.dart';

@Injectable(as: UseCase)
class ListenSortChangeUseCase extends UseCase<Dry, TaleSortType> {
  final TaleListStorage _storage;
  final Logger _logger;

  ListenSortChangeUseCase(
    this._storage,
    this._logger,
  );

  @override
  Stream<TaleSortType> transaction(Dry input) async* {
    final transformer = StreamTransformer.fromHandlers(
      handleData: (
        TaleSortType type,
        EventSink<TaleSortType> sink,
      ) {
        _logger.log(
          () => 'TaleSortType was changed to $type',
          tag: logTag,
        );
        sink.add(type);
      },
    );
    yield* _storage.watchSortTypeChanges().transform(transformer);
  }
}
