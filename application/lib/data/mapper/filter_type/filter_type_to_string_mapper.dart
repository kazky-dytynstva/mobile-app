import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/sort_and_filter/filter_type.dart';

const _all = 'all';
const _favorite = 'favorite';
const _national = 'national';
const _author = 'author';
const _audio = 'audio';
const _lullaby = 'lullaby';
const _poem = 'poem';
const _lastAdded = 'lastAdded';
const _unwatched = 'unwatched';
const _hidden = 'hidden';

@Singleton(as: Mapper)
class TaleFilterTypeToDbKeyMapper implements Mapper<TaleFilterType, String> {
  @override
  String map(TaleFilterType input) {
    switch (input) {
      case TaleFilterType.all:
        return _all;
      case TaleFilterType.favorite:
        return _favorite;
      case TaleFilterType.national:
        return _national;
      case TaleFilterType.author:
        return _author;
      case TaleFilterType.audio:
        return _audio;
      case TaleFilterType.lullaby:
        return _lullaby;
      case TaleFilterType.poem:
        return _poem;
      case TaleFilterType.lastAdded:
        return _lastAdded;
      case TaleFilterType.unwatched:
        return _unwatched;
      case TaleFilterType.hidden:
        return _hidden;
    }
  }
}

@Singleton(as: Mapper)
class DbKeyToTaleFilterTypeMapper implements Mapper<String?, TaleFilterType> {
  @override
  TaleFilterType map(String? input) {
    switch (input) {
      case _national:
        return TaleFilterType.national;
      case _author:
        return TaleFilterType.author;
      case _audio:
        return TaleFilterType.audio;
      case _lullaby:
        return TaleFilterType.lullaby;
      case _poem:
        return TaleFilterType.poem;
      case _lastAdded:
        return TaleFilterType.lastAdded;
      case _favorite:
        return TaleFilterType.favorite;
      case _hidden:
        return TaleFilterType.hidden;
      case _unwatched:
        return TaleFilterType.unwatched;

      case _all:
      default:
        return TaleFilterType.all;
    }
  }
}
