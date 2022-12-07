import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/people/people_page_tab_data.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/domain/model/tale_crew/tale_crew_role.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/infrastructure/di/named_annotations.dart';
import 'package:mobile_app/presentation/resource/r.dart';

@Injectable(as: UseCase)
class GetPeoplePageTabDataListUseCase extends UseCase<
    GetPeoplePageTabDataListInput, GetPeoplePageTabDataListOutput> {
  final Mapper<TaleCrewRole, StringSingleLine> _roleToLabelMapper;
  final UseCase<List<Person>, Dry> _sortPeopleUseCase;

  GetPeoplePageTabDataListUseCase(
    @plural this._roleToLabelMapper,
    this._sortPeopleUseCase,
  );

  @override
  Stream<GetPeoplePageTabDataListOutput> transaction(
    GetPeoplePageTabDataListInput input,
  ) async* {
    final tabDataList = <PeoplePageTabData>[];
    final allPeopleSet = <Person>{};
    for (final role in TaleCrewRole.values) {
      final people = input.peopleByRole[role]?.toList();
      if (people != null) {
        allPeopleSet.addAll(people);
        await _sortPeopleUseCase.call(people);
        final label = _roleToLabelMapper.map(role);
        final tabData = PeoplePageTabData(
          Some(role),
          label,
          people,
        );
        tabDataList.add(tabData);
      }
    }

    final allPeopleList = allPeopleSet.toList();
    await _sortPeopleUseCase.call(allPeopleList);
    final allTabData = PeoplePageTabData(
      const None(),
      StringSingleLine(R.strings.general.allPeople),
      allPeopleList,
    );
    tabDataList.insert(0, allTabData);

    yield GetPeoplePageTabDataListOutput(tabDataList);
  }
}

class GetPeoplePageTabDataListInput {
  final Map<TaleCrewRole, Set<Person>> peopleByRole;

  GetPeoplePageTabDataListInput(this.peopleByRole);
}

class GetPeoplePageTabDataListOutput {
  final List<PeoplePageTabData> tabDataList;

  GetPeoplePageTabDataListOutput(this.tabDataList);
}
