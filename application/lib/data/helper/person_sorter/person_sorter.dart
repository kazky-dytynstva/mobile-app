import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/constant/alphabet.dart';
import 'package:mobile_app/domain/extensions/string.dart';
import 'package:mobile_app/domain/helper/person_sorter.dart';
import 'package:mobile_app/domain/model/person/person.dart';

@LazySingleton(as: PersonSorter)
class PersonSorterImpl implements PersonSorter {
  @override
  void sort(List<Person> people) {
    int comparator(Person first, Person second) {
      final result = _compareName(first, second);
      if (result != 0) return result;

      return first.hashCode.compareTo(second.hashCode);
    }

    people.sort(comparator);
  }

  int _compareName(Person a, Person b) => a.name.get().localeCompareTo(
        b.name.get(),
        alphabetUA,
        ignoreCase: false,
      );
}
