import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/sort_and_filter/filter_type.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_list_storage.dart';
import 'package:mobile_app/data/helper/logger/logger.dart';

@Injectable(as: UseCase)
class ListenFilterChangeUseCase extends UseCase<Dry, TaleFilterType> {
  final TaleListStorage _storage;
  final Logger _logger;

  ListenFilterChangeUseCase(
    this._storage,
    this._logger,
  );

  @override
  Stream<TaleFilterType> transaction(Dry input) async* {
    final transformer = StreamTransformer.fromHandlers(
      handleData: (
        TaleFilterType type,
        EventSink<TaleFilterType> sink,
      ) {
        _logger.log(
          () => 'TaleFilterType was changed to $type',
          tag: logTag,
        );
        sink.add(type);
      },
    );
    yield* _storage.watchFilterTypeChanges().transform(transformer);
  }
}
