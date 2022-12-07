import 'package:dartz/dartz.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_id.dart';

abstract class PeopleRepository {
  /// if [force] is true, than prepare will be called even it was called before,
  /// otherwise [prepare] will be executed only once
  Future<Unit> prepare(bool force);

  Iterable<Person> getAll();

  Option<Person> find(PersonId id);
}
