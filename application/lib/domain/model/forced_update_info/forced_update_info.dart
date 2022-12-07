import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app/domain/value_objects/string_not_empty.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';

class ForcedUpdateInfo extends Equatable {
  final StringSingleLine title;
  final StringNonEmpty msg;
  final Option<List<StringSingleLine>> pointsOption;
  final bool canSkip;

  const ForcedUpdateInfo({
    required this.title,
    required this.msg,
    required this.pointsOption,
    required this.canSkip,
  });

  @override
  List<Object> get props => [
        title,
        msg,
        pointsOption,
        canSkip,
      ];
}
