import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/domain/model/sort_and_filter/filter_type.dart';
import 'package:mobile_app/domain/model/tale_sort_and_filter/tale_filter_item_data.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_graphic.dart';

void main() {
  final type = TaleFilterType.values.first;
  final name = StringSingleLine('name');
  const icon = SvgAssetGraphic(name: 'icon');
  final amount = IntPositive(111);

  final first = TaleFilterItemData(type, name, icon, amount);
  final second = TaleFilterItemData(type, name, icon, amount);
  test("GIVEN instance THEN verify it is equatable", () {
    expect(first, isA<Equatable>());
  });
  test("GIVEN instance THEN verify props are correct", () {
    final props = [
      type,
      name,
      icon,
      amount,
    ];
    expect(first.props, equals(props));
  });
  test("GIVEN 2 instances with same input THEN verify they are equal", () {
    expect(first, equals(second));
  });
}
