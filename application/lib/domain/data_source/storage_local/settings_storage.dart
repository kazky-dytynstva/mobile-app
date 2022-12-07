import 'package:dartz/dartz.dart';
import 'package:mobile_app/domain/model/app_theme/app_theme.dart';
import 'package:mobile_app/domain/model/settings/text_scale_factor.dart';

abstract class SettingsStorage {
  //region appTheme
  Future<AppTheme> getAppTheme();

  Future<Unit> setAppTheme(AppTheme theme);

  Stream<AppTheme> watchAppThemeChanges();

  //endregion appTheme

  //region TextScaleFactor
  Future<TextScaleFactor> getTextScaleFactor();

  Future<Unit> setTextScaleFactor(TextScaleFactor theme);

  Stream<TextScaleFactor> watchTextScaleFactorChanges();
//endregion TextScaleFactor
}
