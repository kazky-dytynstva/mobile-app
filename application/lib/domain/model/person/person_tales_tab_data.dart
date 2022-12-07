import 'package:equatable/equatable.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';

class PersonTalesTabData extends Equatable {
  final StringSingleLine label;
  final List<TalesPageItemData> tales;

  const PersonTalesTabData(
    this.label,
    this.tales,
  );

  @override
  List<Object?> get props => [
        label,
        tales,
      ];
}
