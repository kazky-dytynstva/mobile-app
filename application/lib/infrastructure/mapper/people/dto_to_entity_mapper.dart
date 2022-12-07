import 'package:dto/dto.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/infrastructure/data_source/storage_local/people/entity/person_entity.dart';

@LazySingleton(as: Mapper)
class PersonDtoToEntityMapper implements Mapper<PersonDto, PersonEntity> {
  @override
  PersonEntity map(PersonDto input) => PersonEntity.create(
        id: input.id,
        name: input.name,
        url: input.url,
        info: input.info,
        isFavorite: false,
      );
}
