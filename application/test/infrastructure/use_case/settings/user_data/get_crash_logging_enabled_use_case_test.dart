import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/infrastructure/use_case/settings/user_data/get_crash_logging_enabled_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/utils.dart';

void main() {
  late MockAppStateStorage storage;
  late GetCrashLoggingEnabledUseCase useCase;
  setUp(() {
    storage = MockAppStateStorage();
    useCase = GetCrashLoggingEnabledUseCase(storage);
  });

  test("GIVEN false WHEN check crashlytics is enabled THEN return false",
      () async {
    // ARRANGE
    when(() => storage.getCrashLoggingEnabled())
        .thenAnswer((_) => Future.value(false));

    // ACT
    final output = await useCase.call(dry);

    // ASSERT
    expect(output.isEnabled, isFalse);
    verify(() => storage.getCrashLoggingEnabled());
    verifyNoMoreInteractions(storage);
  });

  test("GIVEN true WHEN check crashlytics is enabled THEN return true",
      () async {
    // ARRANGE
    when(() => storage.getCrashLoggingEnabled())
        .thenAnswer((_) => Future.value(true));

    // ACT
    final output = await useCase.call(dry);

    // ASSERT
    expect(output.isEnabled, isTrue);
    verify(() => storage.getCrashLoggingEnabled());
    verifyNoMoreInteractions(storage);
  });
}
