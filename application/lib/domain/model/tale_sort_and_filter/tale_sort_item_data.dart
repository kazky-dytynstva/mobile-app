import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/sort_and_filter/sort_type.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';

@immutable
class TaleSortItemData extends Equatable {
  final TaleSortType type;
  final StringSingleLine name;

  const TaleSortItemData(
    this.type,
    this.name,
  );

  @override
  List<Object> get props => [
        type,
        name,
      ];
}
