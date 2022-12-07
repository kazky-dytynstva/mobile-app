import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/domain/model/settings/settings_data_text.dart';
import 'package:mobile_app/domain/model/settings/text_scale_factor.dart';

void main() {
  test("GIVEN instance THEN default values are correct", () async {
    // ARRANGE
    const data = SettingsDataText();

    // ASSERT
    expect(data.textScaleFactor, equals(TextScaleFactor.m));
  });
  test("GIVEN textScaleFactor THEN verify param is same", () async {
    // ARRANGE
    final dataList = TextScaleFactor.values.reversed
        .map((e) => SettingsDataText(textScaleFactor: e))
        .toList();

    // ASSERT
    expect(dataList[0].textScaleFactor, equals(TextScaleFactor.xl));
    expect(dataList[1].textScaleFactor, equals(TextScaleFactor.l));
    expect(dataList[2].textScaleFactor, equals(TextScaleFactor.m));
    expect(dataList[3].textScaleFactor, equals(TextScaleFactor.s));
    expect(dataList.length, equals(4));
  });

  test("GIVEN 2 instances with same input THEN verify they are equal",
      () async {
    // ARRANGE
    const first = SettingsDataText(textScaleFactor: TextScaleFactor.xl);
    const second = SettingsDataText(textScaleFactor: TextScaleFactor.xl);

    // ASSERT
    expect(first, equals(second));
  });
}
