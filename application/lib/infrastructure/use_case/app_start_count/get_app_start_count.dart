import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/domain/data_source/storage_local/app_state_storage.dart';
import 'package:mobile_app/infrastructure/helper/logger/logger.dart';

@Injectable(as: UseCase)
class GetAppStartCount extends UseCase<Dry, IntPositive> {
  final AppStateStorage _storage;
  final Logger _logger;

  GetAppStartCount(
    this._storage,
    this._logger,
  );

  @override
  Stream<IntPositive> transaction(Dry input) async* {
    final count = await _storage.getAppStartsCount();
    _logger.log(
      () => 'App start count: ${count.get()}',
      tag: logTag,
    );
    yield count;
  }
}
