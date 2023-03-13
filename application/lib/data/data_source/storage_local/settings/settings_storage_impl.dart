import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/data_source/storage_local/settings_storage.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/app_theme/app_theme.dart';
import 'package:mobile_app/domain/model/settings/text_scale_factor.dart';
import 'package:mobile_app/data/data_source/storage_local/box_names.dart';

const String _keyAppTheme = "_appTheme";
const String _keyTextScaleFactor = "_textScaleFactor";

@LazySingleton(as: SettingsStorage)
class SettingsStorageImpl implements SettingsStorage {
  final Future<Box<dynamic>> _box;
  final Mapper<AppTheme, String> _appThemeToKeyMapper;
  final Mapper<String?, AppTheme> _keyToAppThemeMapper;
  final Mapper<TextScaleFactor, String> _textScaleFactorToKeyMapper;
  final Mapper<String?, TextScaleFactor> _keyToTextScaleFactorMapper;

  SettingsStorageImpl(
    HiveInterface hive,
    this._appThemeToKeyMapper,
    this._keyToAppThemeMapper,
    this._keyToTextScaleFactorMapper,
    this._textScaleFactorToKeyMapper,
  ) : _box = hive.openBox(BoxNames.settings);

//region appTheme
  @override
  Future<AppTheme> getAppTheme() async {
    final value = (await _box).get(_keyAppTheme) as String?;
    return _keyToAppThemeMapper.map(value);
  }

  @override
  Future<Unit> setAppTheme(AppTheme theme) async {
    (await _box).put(_keyAppTheme, _appThemeToKeyMapper.map(theme));
    return unit;
  }

  @override
  Stream<AppTheme> watchAppThemeChanges() async* {
    var current = await getAppTheme();
    final streamTransformer = StreamTransformer.fromHandlers(
      handleData: (BoxEvent event, EventSink<AppTheme> sink) {
        final theme = _keyToAppThemeMapper.map(event.value as String);
        if (theme != current) {
          current = theme;
          sink.add(theme);
        }
      },
    );
    yield* (await _box).watch(key: _keyAppTheme).transform(streamTransformer);
  }

//endregion appTheme

//region textScaleFactor
  @override
  Future<TextScaleFactor> getTextScaleFactor() async {
    final value = (await _box).get(_keyTextScaleFactor) as String?;
    return _keyToTextScaleFactorMapper.map(value);
  }

  @override
  Future<Unit> setTextScaleFactor(TextScaleFactor theme) async {
    (await _box)
        .put(_keyTextScaleFactor, _textScaleFactorToKeyMapper.map(theme));
    return unit;
  }

  @override
  Stream<TextScaleFactor> watchTextScaleFactorChanges() async* {
    var current = await getTextScaleFactor();
    final streamTransformer = StreamTransformer.fromHandlers(
      handleData: (BoxEvent event, EventSink<TextScaleFactor> sink) {
        final scaleFactor =
            _keyToTextScaleFactorMapper.map(event.value as String);
        if (scaleFactor != current) {
          current = scaleFactor;
          sink.add(scaleFactor);
        }
      },
    );
    yield* (await _box)
        .watch(key: _keyTextScaleFactor)
        .transform(streamTransformer);
  }

//endregion textScaleFactor
}
