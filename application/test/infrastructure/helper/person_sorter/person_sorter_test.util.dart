part of 'person_sorter_test.dart';

final alphabeticallySortedList = alphabetUA
    .map(
      (char) => getPerson(name: char + char + char + char),
    )
    .toList();

List<Person> getRandomList() {
  final sorted = List.of(alphabeticallySortedList);
  sorted.shuffle();
  return sorted;
}
