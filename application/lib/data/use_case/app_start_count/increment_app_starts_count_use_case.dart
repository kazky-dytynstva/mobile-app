import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/domain/data_source/storage_local/app_state_storage.dart';
import 'package:mobile_app/data/helper/logger/logger.dart';

@Injectable(as: UseCase)
class IncrementAppStartsCountUseCase
    extends UseCase<Dry, IncrementAppStartsCountOutput> {
  final AppStateStorage _appStateStorage;
  final Logger _logger;

  IncrementAppStartsCountUseCase(
    this._appStateStorage,
    this._logger,
  );

  @override
  Stream<IncrementAppStartsCountOutput> transaction(Dry input) async* {
    final appStartsCount = await _appStateStorage.getAppStartsCount();
    final incremented = IntPositive(appStartsCount.get() + 1);
    await _appStateStorage.setAppStartsCount(incremented);
    _logger.log(
      () => 'Incremented app start count is: ${incremented.get()}',
      tag: logTag,
    );
    yield _output;
  }
}

class IncrementAppStartsCountOutput {
  const IncrementAppStartsCountOutput._();
}

const IncrementAppStartsCountOutput _output = IncrementAppStartsCountOutput._();
