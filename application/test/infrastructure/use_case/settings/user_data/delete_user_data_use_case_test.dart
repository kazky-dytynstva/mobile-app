import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/infrastructure/use_case/settings/user_data/delete_user_data_use_case.dart';
import 'package:mobile_app/infrastructure/use_case/settings/user_data/set_crash_logging_enabled_use_case.dart';
import 'package:mobile_app/infrastructure/use_case/settings/user_data/set_tracking_enabled_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/utils.dart';

void main() {
  late DeleteUserDataUseCase useCase;

  late MockFirebaseInstallations installations;
  late MockSetTrackingEnabledUseCase setTrackingEnabledUseCase;
  late MockSetCrashLoggingEnabledUseCase setCrashLoggingEnabledUseCase;
  setUp(() {
    installations = MockFirebaseInstallations();

    setTrackingEnabledUseCase = MockSetTrackingEnabledUseCase();
    setCrashLoggingEnabledUseCase = MockSetCrashLoggingEnabledUseCase();

    useCase = DeleteUserDataUseCase(
      installations,
      setCrashLoggingEnabledUseCase,
      setTrackingEnabledUseCase,
    );
  });

  test("GIVEN useCase call  THEN verify correct order of calls", () async {
    // ARRANGE
    when(() => installations.delete()).thenAnswer((_) async => () {});
    when(() => setTrackingEnabledUseCase.call(false))
        .thenAnswer((_) async => const SetTrackingEnabledOutput(false));
    when(() => setCrashLoggingEnabledUseCase.call(false))
        .thenAnswer((_) async => const SetCrashLoggingEnabledOutput(false));

    // ACT
    final output = await useCase.call(dry);

    // ASSERT
    expect(
      output,
      equals(const DeleteUserDataUseCaseOutput(
        isTrackingEnabled: false,
        isCrashLoggingEnabled: false,
      )),
    );
    verifyInOrder([
      () => installations.delete(),
      () => setCrashLoggingEnabledUseCase.call(false),
      () => setTrackingEnabledUseCase.call(false),
    ]);
    verifyNoMoreInteractions(installations);
    verifyNoMoreInteractions(setCrashLoggingEnabledUseCase);
    verifyNoMoreInteractions(setTrackingEnabledUseCase);
  });
}
