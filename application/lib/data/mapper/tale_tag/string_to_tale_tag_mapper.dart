import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/tale_tag/tale_tag.dart';

const String _keyAudio = 'audio';
const String _keyText = 'text';
const String _keyPoem = 'poem';
const String _keyLullaby = 'lullaby';
const String _keyAuthor = 'author';

@LazySingleton(as: Mapper)
class StringToTaleCategoryMapper implements Mapper<String, TaleTag> {
  @override
  TaleTag map(String input) {
    switch (input) {
      case _keyAudio:
        return TaleTag.audio;
      case _keyText:
        return TaleTag.text;
      case _keyPoem:
        return TaleTag.poem;
      case _keyLullaby:
        return TaleTag.lullaby;
      case _keyAuthor:
        return TaleTag.author;
    }
    return TaleTag.none;
  }
}

@LazySingleton(as: Mapper)
class TaleTagToStringMapper implements Mapper<TaleTag, String> {
  @override
  String map(TaleTag input) {
    switch (input) {
      case TaleTag.audio:
        return _keyAudio;
      case TaleTag.text:
        return _keyText;
      case TaleTag.poem:
        return _keyPoem;
      case TaleTag.lullaby:
        return _keyLullaby;
      case TaleTag.author:
        return _keyAuthor;

      //default one
      case TaleTag.none:
        return '';
    }
  }
}
