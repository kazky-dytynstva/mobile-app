import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/person/person_tales_tab_data.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_id.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/domain/model/tale_crew/tale_crew_role.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/infrastructure/data_source/storage_local/tale/entity/tale_entity.dart';
import 'package:mobile_app/infrastructure/di/named_annotations.dart';

@Injectable(as: UseCase)
class GetPersonTabDataUseCase
    extends UseCase<GetPersonTabDataInput, GetPersonTabDataOutput> {
  final Mapper<TaleEntity, TalesPageItemData> _mapper;
  final Mapper<TaleCrewRole, StringSingleLine> _roleToLabelMapper;

  GetPersonTabDataUseCase(
    this._mapper,
    @singular this._roleToLabelMapper,
  );

  @override
  Stream<GetPersonTabDataOutput> transaction(
    GetPersonTabDataInput input,
  ) async* {
    List<PersonTalesTabData> tabDataList = [];
    for (final role in TaleCrewRole.values) {
      final byRole = _getTalesForRole(role, input);
      if (byRole.isNotEmpty) {
        final mapped = byRole.map(_mapper.map);
        final tabData = PersonTalesTabData(
          _roleToLabelMapper.map(role) + ' (${byRole.length})',
          mapped.toList(),
        );
        tabDataList.add(tabData);
      }
    }

    yield GetPersonTabDataOutput(tabDataList);
  }

  Iterable<TaleEntity> _getTalesForRole(
    TaleCrewRole role,
    GetPersonTabDataInput input,
  ) {
    final id = input.personId.get();
    switch (role) {
      case TaleCrewRole.author:
        return input.personTales
            .where((element) => element.crew?.authors?.contains(id) == true);
      case TaleCrewRole.reader:
        return input.personTales
            .where((element) => element.crew?.readers?.contains(id) == true);
      case TaleCrewRole.translator:
        return input.personTales.where(
            (element) => element.crew?.translators?.contains(id) == true);
      case TaleCrewRole.musician:
        return input.personTales
            .where((element) => element.crew?.musicians?.contains(id) == true);
      case TaleCrewRole.graphic:
        return input.personTales
            .where((element) => element.crew?.graphics?.contains(id) == true);
    }
  }
}

class GetPersonTabDataInput {
  final Iterable<TaleEntity> personTales;
  final PersonId personId;

  GetPersonTabDataInput(
    this.personTales,
    this.personId,
  );
}

class GetPersonTabDataOutput {
  final List<PersonTalesTabData> tabDataList;

  GetPersonTabDataOutput(this.tabDataList);
}
