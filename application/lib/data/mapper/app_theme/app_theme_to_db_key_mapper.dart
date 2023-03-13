import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/app_theme/app_theme.dart';

const _system = 'system';
const _light = 'light';
const _dark = 'dark';

@Singleton(as: Mapper)
class AppThemeToDbKeyMapper implements Mapper<AppTheme, String> {
  @override
  String map(AppTheme input) {
    switch (input) {
      case AppTheme.system:
        return _system;
      case AppTheme.light:
        return _light;
      case AppTheme.dark:
        return _dark;
    }
  }
}

@Singleton(as: Mapper)
class DbKeyToAppThemeMapper implements Mapper<String?, AppTheme> {
  @override
  AppTheme map(String? input) {
    switch (input) {
      case _light:
        return AppTheme.light;
      case _dark:
        return AppTheme.dark;
      case _system:
      default:
        return AppTheme.system;
    }
  }
}
