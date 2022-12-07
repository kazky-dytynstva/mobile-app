import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/show_dot/show_dot_type.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/data_source/storage_local/app_state_storage.dart';

@Injectable(as: UseCase)
class ListenShowDotTypeUseCase extends UseCase<ShowDotType, bool> {
  final AppStateStorage _stateStorage;

  ListenShowDotTypeUseCase(
    this._stateStorage,
  );

  @override
  Stream<bool> transaction(ShowDotType input) async* {
    final show = await _stateStorage.showDotForType(input);
    yield show;

    yield* _stateStorage.watchShowDotForType(input);
  }
}
