import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/domain/constant/alphabet.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/data/helper/person_sorter/person_sorter.dart';

import '../../../utils/utils.dart';

part 'person_sorter_test.util.dart';

void main() {
  final sorter = PersonSorterImpl();

  test(
    'GIVEN random list of people THEN after sort list is alphabetically sorted',
    () async {
      // ARRANGE
      final input = getRandomList();

      // ACT
      sorter.sort(input);

      // ASSERT
      expect(input, equals(alphabeticallySortedList));
    },
  );
}
