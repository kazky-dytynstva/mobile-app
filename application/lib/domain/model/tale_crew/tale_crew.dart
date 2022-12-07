import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/domain/model/tale_crew/tale_crew_role.dart';

@immutable
class TaleCrew {
  final List<Person> authors;
  final List<Person> readers;
  final List<Person> translators;
  final List<Person> musicians;
  final List<Person> graphics;

  const TaleCrew({
    required this.authors,
    required this.readers,
    required this.translators,
    required this.musicians,
    required this.graphics,
  }) : assert(
          (authors.length > 0) ||
              (readers.length > 0) ||
              (musicians.length > 0) ||
              (translators.length > 0) ||
              (graphics.length > 0),
        );

  List<Person> getPeopleForRole(TaleCrewRole role) {
    switch (role) {
      case TaleCrewRole.author:
        return authors;
      case TaleCrewRole.reader:
        return readers;
      case TaleCrewRole.translator:
        return translators;
      case TaleCrewRole.musician:
        return musicians;
      case TaleCrewRole.graphic:
        return graphics;
    }
  }
}
