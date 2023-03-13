import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/helper/person_sorter.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';

@LazySingleton(as: UseCase)
class SortPeopleUseCase extends UseCase<List<Person>, Dry> {
  final PersonSorter _personSorter;

  SortPeopleUseCase(this._personSorter);

  @override
  Stream<Dry> transaction(List<Person> input) async* {
    _personSorter.sort(input);
    yield dry;
  }
}
