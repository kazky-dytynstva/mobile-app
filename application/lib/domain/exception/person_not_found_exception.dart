import 'package:equatable/equatable.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_id.dart';

class PersonNotFoundException extends Equatable implements Exception {
  final PersonId id;

  const PersonNotFoundException(this.id);

  @override
  String toString() => 'Person (with id=${id.get()}) not found';

  @override
  List<Object?> get props => [id];
}
