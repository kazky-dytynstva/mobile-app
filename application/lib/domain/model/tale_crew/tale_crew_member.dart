import 'package:flutter/cupertino.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/domain/model/tale_crew/tale_crew_role.dart';

@immutable
class TaleCrewMember {
  final Person person;
  final List<TaleCrewRole> roles;

  const TaleCrewMember(
    this.person,
    this.roles,
  ) : assert(roles.length > 0);
}
