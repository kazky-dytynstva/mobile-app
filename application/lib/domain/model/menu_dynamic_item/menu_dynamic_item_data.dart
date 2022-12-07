import 'package:dartz/dartz.dart';
import 'package:mobile_app/domain/value_objects/string_not_empty.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/domain/value_objects/url_string.dart';

class MenuDynamicItemData {
  final StringSingleLine title;
  final Option<StringSingleLine> subTitleOption;
  final Option<List<StringNonEmpty>> pointsOption;
  final StringSingleLine cta;
  final UrlString url;

  MenuDynamicItemData({
    required this.title,
    required this.subTitleOption,
    required this.pointsOption,
    required this.cta,
    required this.url,
  });

  bool get needToOpenScreen => pointsOption.isSome();
}
