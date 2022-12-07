import 'package:equatable/equatable.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';

class TaleCrewListItem extends Equatable {
  final StringSingleLine roleLabel;
  final List<Person> people;

  const TaleCrewListItem(
    this.roleLabel,
    this.people,
  );

  @override
  List<Object> get props => [roleLabel, people];
}
