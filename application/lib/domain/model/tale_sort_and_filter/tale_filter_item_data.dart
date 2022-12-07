import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/sort_and_filter/filter_type.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_graphic.dart';

@immutable
class TaleFilterItemData extends Equatable {
  final TaleFilterType type;
  final StringSingleLine name;
  final SvgAssetGraphic icon;
  final IntPositive amount;

  const TaleFilterItemData(
    this.type,
    this.name,
    this.icon,
    this.amount,
  );

  @override
  List<Object> get props => [
        type,
        name,
        icon,
        amount,
      ];
}
