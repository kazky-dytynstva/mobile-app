import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/data_source/storage_local/settings_storage.dart';
import 'package:mobile_app/domain/model/settings/text_scale_factor.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/infrastructure/helper/logger/logger.dart';

@Injectable(as: UseCase)
class ListenTextScaleFactorChangesUseCase
    extends UseCase<ListenTextScaleFactorChangesInput, TextScaleFactor> {
  final SettingsStorage _storage;
  final Logger _logger;

  ListenTextScaleFactorChangesUseCase(
    this._storage,
    this._logger,
  );

  @override
  Stream<TextScaleFactor> transaction(
      ListenTextScaleFactorChangesInput input) async* {
    final current = await _storage.getTextScaleFactor();
    yield current;

    final transformer = StreamTransformer.fromHandlers(
      handleData: (
        TextScaleFactor type,
        EventSink<TextScaleFactor> sink,
      ) {
        _logger.log(
          () => 'TextScaleFactor was changed to $type',
          tag: logTag,
        );
        sink.add(type);
      },
    );
    yield* _storage.watchTextScaleFactorChanges().transform(transformer);
  }
}

class ListenTextScaleFactorChangesInput {
  const ListenTextScaleFactorChangesInput._();
}

const ListenTextScaleFactorChangesInput listenTextScaleFactorChangesInput =
    ListenTextScaleFactorChangesInput._();
