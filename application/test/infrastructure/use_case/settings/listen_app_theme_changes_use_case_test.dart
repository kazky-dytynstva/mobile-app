import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/domain/model/app_theme/app_theme.dart';
import 'package:mobile_app/infrastructure/use_case/settings/listen_app_theme_changes_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/mocks/mocks.dart';

void main() {
  late MockSettingsStorage storage;
  late ListenAppThemeChangesUseCase useCase;

  setUp(() {
    storage = MockSettingsStorage();
    final logger = MockLogger();
    useCase = ListenAppThemeChangesUseCase(storage, logger);
  });

  test(
    'GIVEN list of changed states WHEN listening the changes THEN emit same list with themes',
    () async {
      // ARRANGE
      when(() => storage.watchAppThemeChanges()).thenAnswer(
        (_) => Stream.fromIterable(AppTheme.values),
      );
      when(() => storage.getAppTheme()).thenAnswer(
        (_) async => AppTheme.dark,
      );
      final results = <AppTheme>[];

      // ACT
      useCase.listen(listenAppThemeChangesInput, (appTheme) {
        results.add(appTheme);
      });
      // we need this fake delay to wait async operation inside useCase
      await Future.delayed(Duration.zero);

      // ASSERT
      expect(results, equals([AppTheme.dark, ...AppTheme.values]));
      verifyInOrder([
        () => storage.getAppTheme(),
        () => storage.watchAppThemeChanges(),
      ]);
      verifyNoMoreInteractions(storage);
    },
  );
}
