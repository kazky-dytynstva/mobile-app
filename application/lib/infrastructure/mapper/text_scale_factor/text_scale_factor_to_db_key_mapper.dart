import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/settings/text_scale_factor.dart';

const _small = 'small';
const _medium = 'medium';
const _large = 'large';
const _xLarge = 'x_large';

@Singleton(as: Mapper)
class TextScaleFactorToDbKeyMapper implements Mapper<TextScaleFactor, String> {
  @override
  String map(TextScaleFactor input) {
    switch (input) {
      case TextScaleFactor.s:
        return _small;
      case TextScaleFactor.m:
        return _medium;
      case TextScaleFactor.l:
        return _large;
      case TextScaleFactor.xl:
        return _xLarge;
    }
  }
}

@Singleton(as: Mapper)
class DbKeyToTextScaleFactorMapper implements Mapper<String?, TextScaleFactor> {
  @override
  TextScaleFactor map(String? input) {
    switch (input) {
      case _small:
        return TextScaleFactor.s;
      case _large:
        return TextScaleFactor.l;
      case _xLarge:
        return TextScaleFactor.xl;
      case _medium:
      default:
        return TextScaleFactor.m;
    }
  }
}
