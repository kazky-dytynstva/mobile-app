import 'package:mobile_app/domain/model/person/person.dart';

abstract class PersonSorter {
  void sort(List<Person> people);
}
