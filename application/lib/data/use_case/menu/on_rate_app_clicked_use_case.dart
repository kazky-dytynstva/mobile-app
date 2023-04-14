import 'package:in_app_review/in_app_review.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/data_source/storage_local/app_state_storage.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';

@Injectable(as: UseCase)
class OnRateAppClickedUseCase extends UseCase<Dry, OnRateAppClickedOutput> {
  final AppStateStorage _stateStorage;
  final InAppReview _inAppReview;

  OnRateAppClickedUseCase(
    this._stateStorage,
    this._inAppReview,
  );

  @override
  Stream<OnRateAppClickedOutput> transaction(Dry input) async* {
    await _stateStorage.setRateAppClicked();

    if (await _inAppReview.isAvailable()) {
      await _inAppReview.requestReview();
    } else {
      await _inAppReview.openStoreListing(appStoreId: '1513020180');
    }

    yield _output;
  }
}

class OnRateAppClickedOutput {
  const OnRateAppClickedOutput._();
}

const OnRateAppClickedOutput _output = OnRateAppClickedOutput._();
