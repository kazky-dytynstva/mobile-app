import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/data/use_case/settings/user_data/set_crash_logging_enabled_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/utils.dart';

void main() {
  late MockFirebaseCrashlytics crashAnalytic;
  late MockAppStateStorage storage;
  late SetCrashLoggingEnabledUseCase useCase;
  setUp(() {
    crashAnalytic = MockFirebaseCrashlytics();
    storage = MockAppStateStorage();
    useCase = SetCrashLoggingEnabledUseCase(crashAnalytic, storage);

    registerFallbackValue(true);
    when(() => crashAnalytic.setCrashlyticsCollectionEnabled(any()))
        .thenAnswer((_) async => {});
    when(() => storage.setCrashLoggingEnabled(any()))
        .thenAnswer((_) => Future.value(unit));
  });

  test("GIVEN false WHEN set enabled THEN return false", () async {
    // ARRANGE
    const value = false;
    when(() => storage.getCrashLoggingEnabled())
        .thenAnswer((_) => Future.value(value));

    // ACT
    final output = await useCase.call(value);

    // ASSERT
    expect(output.isEnabled, isFalse);
    verifyInOrder([
      () => storage.setCrashLoggingEnabled(value),
      () => crashAnalytic.setCrashlyticsCollectionEnabled(value),
      () => storage.getCrashLoggingEnabled(),
    ]);
    verifyNoMoreInteractions(crashAnalytic);
    verifyNoMoreInteractions(storage);
  });

  test("GIVEN true WHEN set enabled THEN return true", () async {
    // ARRANGE
    const value = true;
    when(() => storage.getCrashLoggingEnabled())
        .thenAnswer((_) => Future.value(value));

    // ACT
    final output = await useCase.call(value);

    // ASSERT
    expect(output.isEnabled, isTrue);
    verifyInOrder([
      () => storage.setCrashLoggingEnabled(value),
      () => crashAnalytic.setCrashlyticsCollectionEnabled(value),
      () => storage.getCrashLoggingEnabled(),
    ]);
    verifyNoMoreInteractions(crashAnalytic);
    verifyNoMoreInteractions(storage);
  });
}
