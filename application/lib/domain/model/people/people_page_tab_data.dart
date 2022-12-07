import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/domain/model/tale_crew/tale_crew_role.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';

class PeoplePageTabData extends Equatable {
  final Option<TaleCrewRole> roleOption;
  final StringSingleLine label;
  final List<Person> peopleList;
  final double scrollPosition;

  const PeoplePageTabData(
    this.roleOption,
    this.label,
    this.peopleList, {
    this.scrollPosition = 0,
  });

  @override
  List<Object?> get props => [
        roleOption,
        label,
        peopleList,
        scrollPosition,
      ];

  PeoplePageTabData copyWith({
    double? scrollPosition,
  }) =>
      PeoplePageTabData(
        roleOption,
        label,
        peopleList,
        scrollPosition: scrollPosition ?? this.scrollPosition,
      );
}
