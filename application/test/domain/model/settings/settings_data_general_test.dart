import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/domain/model/app_theme/app_theme.dart';
import 'package:mobile_app/domain/model/settings/settings_data_general.dart';

void main() {
  test("GIVEN instance THEN default values are correct", () async {
    // ARRANGE
    const data = SettingsDataGeneral();

    // ASSERT
    expect(data.appTheme, equals(AppTheme.system));
    expect(data.isCrashLoggingEnabled, isFalse);
    expect(data.isTrackingEnabled, isFalse);
  });
  test("GIVEN appTheme THEN verify param is same", () async {
    // ARRANGE
    final dataList = AppTheme.values.reversed
        .map((e) => SettingsDataGeneral(appTheme: e))
        .toList();

    // ASSERT
    expect(dataList[0].appTheme, equals(AppTheme.dark));
    expect(dataList[1].appTheme, equals(AppTheme.light));
    expect(dataList[2].appTheme, equals(AppTheme.system));
    expect(dataList.length, equals(3));
  });

  test("GIVEN true WHEN isCrashLoggingEnabled THEN verify params is same",
      () async {
    // ARRANGE
    const first = SettingsDataGeneral(isCrashLoggingEnabled: true);
    const second = SettingsDataGeneral(isCrashLoggingEnabled: false);

    // ASSERT
    expect(first.isCrashLoggingEnabled, isTrue);
    expect(second.isCrashLoggingEnabled, isFalse);
  });

  test("GIVEN true WHEN isTrackingEnabled THEN verify params is same",
      () async {
    // ARRANGE
    const first = SettingsDataGeneral(isTrackingEnabled: true);
    const second = SettingsDataGeneral(isTrackingEnabled: false);

    // ASSERT
    expect(first.isTrackingEnabled, isTrue);
    expect(second.isTrackingEnabled, isFalse);
  });

  test("GIVEN 2 instances with same input THEN verify they are equal",
      () async {
    // ARRANGE
    const first = SettingsDataGeneral(
      appTheme: AppTheme.light,
      isCrashLoggingEnabled: true,
      isTrackingEnabled: true,
    );
    const second = SettingsDataGeneral(
      appTheme: AppTheme.light,
      isCrashLoggingEnabled: true,
      isTrackingEnabled: true,
    );

    // ASSERT
    expect(first, equals(second));
  });
}
