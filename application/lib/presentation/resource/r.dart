import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/app_theme/app_theme.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_graphic.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_icon.dart';
import 'package:mobile_app/presentation/resource/string/string_res.dart';

part 'asset/assets.dart';

part 'device/device.dart';

part 'duration/durations.dart';

part 'palette/palette.dart';

part 'dimen/dimen.dart';

part 'space/spaces.dart';

part 'theme/styles.dart';

part 'theme/theme_data.dart';

class R {
  const R._();

  static late Assets _assets;
  static late Device _device;
  static late Dimen _dimen;
  static final Durations _durations = Durations._();
  static late Palette _palette;
  static late Spaces _spaces;
  static final StringRes _stringRes = StringRes();
  static late Styles _styles;
  static late AppTheme _theme;
  static late ThemeData _themeData;

  /// will be called first
  static void setData(MediaQueryData mediaQuery) {
    _device = Device._(
      screenSize: mediaQuery.size,
      orientation: mediaQuery.orientation,
    );
    _dimen = Dimen._(
      device: _device,
      screenPadding: mediaQuery.padding,
      viewInsets: mediaQuery.viewInsets,
    );
    _spaces = Spaces._(_dimen);
  }

  /// will be called second
  static void setTheme(AppTheme theme) {
    _theme = theme;
    _assets = Assets._();
    _palette = Palette._(_theme);
    _themeData = _createThemeData(theme.brightness, palette, dimen);
    _styles = Styles._(themeData, _palette, _dimen);
  }

  static Assets get assets => _assets;

  static Device get device => _device;

  static Dimen get dimen => _dimen;

  static Durations get durations => _durations;

  static Palette get palette => _palette;

  static Spaces get spaces => _spaces;

  static StringRes get strings => _stringRes;

  static Styles get styles => _styles;

  static AppTheme get theme => _theme;

  static ThemeData get themeData => _themeData;
}
