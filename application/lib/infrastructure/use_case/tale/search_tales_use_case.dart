import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/infrastructure/data_source/storage_local/tale/entity/tale_entity.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_storage.dart';
import 'package:mobile_app/infrastructure/helper/logger/logger.dart';
import 'package:mobile_app/presentation/resource/r.dart';

@Injectable(as: UseCase)
class SearchTalesUseCase extends UseCase<StringSingleLine, SearchTalesOutput> {
  final TaleStorage _storage;
  final Mapper<TaleEntity, TalesPageItemData> _mapper;
  final Logger _logger;

  SearchTalesUseCase(
    this._storage,
    this._mapper,
    this._logger,
  );

  @override
  Stream<SearchTalesOutput> transaction(StringSingleLine input) async* {
    _logger.log(
      () => 'Search tale with phrase: "${input.get()}"',
      tag: logTag,
    );
    final allTales = await _getAllTales();
    final results = _getFilteredTales(allTales, input.get());

    yield SearchTalesOutput(results);
  }

  List<TalesPageItemData> _getFilteredTales(
    List<TalesPageItemData> allTales,
    String phrase,
  ) {
    bool compareTaleName(TalesPageItemData tale) =>
        tale.name.get().toLowerCase().contains(phrase);
    bool compareAuthorName(TalesPageItemData tale) =>
        tale.provider.get() != R.strings.general.authorNation &&
        tale.provider.get().toLowerCase().contains(phrase);
    return allTales
        .where(
          (tale) => compareTaleName(tale) || compareAuthorName(tale),
        )
        .toList();
  }

  Future<List<TalesPageItemData>> _getAllTales() async {
    final entities = await _storage.getAll();
    return entities.map(_mapper.map).toList();
  }
}

class SearchTalesOutput {
  final List<TalesPageItemData> results;

  SearchTalesOutput(this.results);
}
