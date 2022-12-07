import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/app_version/app_version.dart';
import 'package:mobile_app/domain/model/show_dot/show_dot_type.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/data_source/storage_local/app_state_storage.dart';

@Injectable(as: UseCase)
class CheckAppVersionChangedUseCase
    extends UseCase<Dry, CheckAppVersionChangedOutput> {
  final AppStateStorage _stateStorage;
  final UseCase<Dry, AppVersion> _getCurrentAppVersionUseCase;

  CheckAppVersionChangedUseCase(
    this._stateStorage,
    this._getCurrentAppVersionUseCase,
  );

  @override
  Stream<CheckAppVersionChangedOutput> transaction(Dry input) async* {
    final last = await _stateStorage.getLastKnownAppVersion();
    final current = await _getCurrentAppVersionUseCase.call(dry);
    final output = CheckAppVersionChangedOutput(
      last: last,
      current: current,
    );

    if (output.changed) {
      await _performAction(output);
    }
    await _stateStorage.setLastKnownAppVersion(current);
    yield output;
  }

  Future<Unit> _performAction(CheckAppVersionChangedOutput output) async {
    // here in case of need we can perform action when out app updated
    // f.e. clean some state, remove some data, etc;
    await _stateStorage.setShowDotType(ShowDotType.whatsNew, show: true);
    return unit;
  }
}

class CheckAppVersionChangedOutput {
  final AppVersion last;
  final AppVersion current;

  CheckAppVersionChangedOutput({
    required this.last,
    required this.current,
  });

  bool get changed => last.name != current.name && current.code > last.code;

  bool get isPatchUpdate {
    if (last.name == current.name && current.code > last.code) {
      return true;
    }
    final lastList = last.name.get().split('.');
    final currentList = current.name.get().split('.');
    if (lastList.first != currentList.first) {
      return false;
    }
    if (lastList[1] != currentList[1]) {
      return false;
    }
    return lastList.last != currentList.last;
  }
}
