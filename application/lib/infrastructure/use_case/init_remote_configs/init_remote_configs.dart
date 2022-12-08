import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/data_source/remote_configs.dart';
import 'package:mobile_app/infrastructure/helper/logger/logger.dart';
import 'package:mobile_app/infrastructure/util/waiter.dart';

part 'init_remote_configs.freezed.dart';

@Injectable(as: UseCase)
class InitRemoteConfigsUseCase extends UseCase<Dry, InitRemoteConfigsOutput> {
  final RemoteConfigs _configs;
  final Waiter _waiter;
  final Logger _logger;

  InitRemoteConfigsUseCase(
    this._configs,
    this._logger,
  ) : _waiter = Waiter(timeToWait: const Duration(seconds: 2));

  @override
  Stream<InitRemoteConfigsOutput> transaction(Dry input) async* {
    _waiter.start();

    final init = await _configs.init(expiration: const Duration(hours: 6));

    await _waiter.waitFor();

    _logger.log(
      () => 'Init remote config successful: $init',
      tag: logTag,
    );
    yield init
        ? InitRemoteConfigsOutput.success()
        : InitRemoteConfigsOutput.failure();
  }
}

@Freezed(
  map: FreezedMapOptions(maybeMap: false),
  when: FreezedWhenOptions(maybeWhen: false),
)
abstract class InitRemoteConfigsOutput with _$InitRemoteConfigsOutput {
  InitRemoteConfigsOutput._();

  factory InitRemoteConfigsOutput.success() = _Data;

  factory InitRemoteConfigsOutput.failure() = _Failure;
}
