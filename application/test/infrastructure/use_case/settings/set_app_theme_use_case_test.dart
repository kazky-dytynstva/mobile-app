import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/domain/model/app_theme/app_theme.dart';
import 'package:mobile_app/data/use_case/settings/set_app_theme_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/mocks/mocks.dart';

void main() {
  late MockSettingsStorage stateStorage;
  late SetAppThemeUseCase setUseCase;

  setUp(() {
    stateStorage = MockSettingsStorage();
    setUseCase = SetAppThemeUseCase(stateStorage);
  });

  test(
    'GIVEN AppTheme.dark WHEN SetAppTheme THEN GetAppTheme',
    () async {
      // ARRANGE
      const inputTheme = AppTheme.dark;

      when(() => stateStorage.setAppTheme(inputTheme))
          .thenAnswer((invocation) async {
        return unit;
      });

      // ACT
      await setUseCase.call(inputTheme);

      // ASSERT
      verify(() => stateStorage.setAppTheme(inputTheme));
      verifyNoMoreInteractions(stateStorage);
    },
  );
}
