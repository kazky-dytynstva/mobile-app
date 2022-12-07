import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/domain/model/sort_and_filter/sort_type.dart';
import 'package:mobile_app/domain/model/tale_sort_and_filter/tale_sort_item_data.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';

void main() {
  final type = TaleSortType.values.first;
  final name = StringSingleLine('name');

  final first = TaleSortItemData(type, name);
  final second = TaleSortItemData(type, name);
  test("GIVEN instance THEN verify it is equatable", () {
    expect(first, isA<Equatable>());
  });
  test("GIVEN instance THEN verify props are correct", () {
    final props = [
      type,
      name,
    ];
    expect(first.props, equals(props));
  });
  test("GIVEN 2 instances with same input THEN verify they are equal", () {
    expect(first, equals(second));
  });
}
