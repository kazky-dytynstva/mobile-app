import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/show_dot/show_dot_type.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/data_source/storage_local/app_state_storage.dart';

@Injectable(as: UseCase)
class SetShowDotTypeWatchedUseCase extends UseCase<ShowDotType, Dry> {
  final AppStateStorage _storage;

  SetShowDotTypeWatchedUseCase(
    this._storage,
  );

  @override
  Stream<Dry> transaction(ShowDotType input) async* {
    await _storage.setShowDotType(input, show: false);
    yield dry;
  }
}
