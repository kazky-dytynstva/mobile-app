import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/data_source/storage_local/settings_storage.dart';
import 'package:mobile_app/domain/model/app_theme/app_theme.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/data/helper/logger/logger.dart';

@Injectable(as: UseCase)
class ListenAppThemeChangesUseCase
    extends UseCase<ListenAppThemeChangesInput, AppTheme> {
  final SettingsStorage _storage;
  final Logger _logger;

  ListenAppThemeChangesUseCase(
    this._storage,
    this._logger,
  );

  @override
  Stream<AppTheme> transaction(ListenAppThemeChangesInput input) async* {
    final current = await _storage.getAppTheme();
    yield current;

    final transformer = StreamTransformer.fromHandlers(
      handleData: (
        AppTheme type,
        EventSink<AppTheme> sink,
      ) {
        _logger.log(
          () => 'AppTheme was changed to $type',
          tag: logTag,
        );
        sink.add(type);
      },
    );
    yield* _storage.watchAppThemeChanges().transform(transformer);
  }
}

class ListenAppThemeChangesInput {
  const ListenAppThemeChangesInput._();
}

const ListenAppThemeChangesInput listenAppThemeChangesInput =
    ListenAppThemeChangesInput._();
