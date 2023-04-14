import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:mobile_app/domain/data_source/storage_local/app_state_storage.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/app_version/app_version.dart';
import 'package:mobile_app/domain/model/menu_dynamic_item/menu_dynamic_item_id.dart';
import 'package:mobile_app/domain/model/player/loop_mode.dart';
import 'package:mobile_app/domain/model/show_dot/show_dot_type.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';

const String _keyAppStartsCount = "_appStartsCount";
const String _keyRemoteConfigsSyncIntervalHours =
    "_remoteConfigsSyncIntervalHours";

const String _keyLastContentUpdateDate = "_lastContentUpdateDate";
const String _keyPlayerLoopMode = "_playerLoopMode2";
const String _keyLastKnownAppVersion = "_appVersion";
const String _keyNumberOfRatedTales = "_numberOfRatedTales";
const String _keyCrashLoggingEnabled = "_crashLoggingEnabled";
const String _keyTrackingEnabled = "_crashTrackingEnabled";
const String _keyShareAppClicked = "_crashShareAppClicked";
const String _keyRateAppClicked = "_crashRateAppClicked";
const String _keySupportAppClicked = "_crashSupportAppClicked";
const String _keyLastSeenDynamicItemId = "_lastSeenDynamicItemId";

class AppStateStorageImpl implements AppStateStorage {
  final Box<dynamic> _box;

  final Mapper<PlayerLoopMode, String> _loopModeToKeyMapper;
  final Mapper<String?, PlayerLoopMode> _keyToLoopModeMapper;
  final Mapper<AppVersion, String> _appVersionToStringMapper;
  final Mapper<String, AppVersion> _stringToAppVersionMapper;
  final Mapper<ShowDotType, String> _showDotTypeToKeyMapper;

  AppStateStorageImpl(
    this._box,
    this._loopModeToKeyMapper,
    this._keyToLoopModeMapper,
    this._appVersionToStringMapper,
    this._stringToAppVersionMapper,
    this._showDotTypeToKeyMapper,
  );

  //region lastContentUpdateDate

  @override
  Future<DateTime> getLastContentUpdateDate() async {
    final value = _box.get(
      _keyLastContentUpdateDate,
      defaultValue: 0,
    ) as int;

    return DateTime.fromMillisecondsSinceEpoch(value);
  }

  @override
  Future<Unit> setLastContentUpdateDate(DateTime date) async {
    _box.put(_keyLastContentUpdateDate, date.millisecondsSinceEpoch);
    return unit;
  }

  //endregion lastContentUpdateDate

  //region appStartsCount
  @override
  Future<IntPositive> getAppStartsCount() async {
    final value = _box.get(_keyAppStartsCount, defaultValue: 0) as int;
    return IntPositive(value);
  }

  @override
  Future<Unit> setAppStartsCount(IntPositive appStartsCount) async {
    _box.put(_keyAppStartsCount, appStartsCount.get());
    return unit;
  }

  //endregion appStartsCount

  //region numberOfRatedTales

  @override
  Future<Unit> incrementNumberOfRatedTales() async {
    final number = await getNumberOfRatedTales();
    _box.put(_keyAppStartsCount, number.get() + 1);
    return unit;
  }

  @override
  Future<IntPositive> getNumberOfRatedTales() async {
    final value = _box.get(_keyNumberOfRatedTales, defaultValue: 0) as int;
    return IntPositive(value);
  }

  //endregion numberOfRatedTales

  //endregion hasStoredContent

  //region remoteConfigSyncInterval
  @override
  Future<Duration> getRemoteConfigSyncInterval() async {
    final value =
        _box.get(_keyRemoteConfigsSyncIntervalHours, defaultValue: 0) as int;
    return Duration(hours: value);
  }

  @override
  Future<Unit> setRemoteConfigSyncInterval({
    required IntPositive hours,
  }) async {
    _box.put(_keyRemoteConfigsSyncIntervalHours, hours.get());
    return unit;
  }

//endregion

  //region playerLoopMode
  @override
  Future<PlayerLoopMode> getLoopMode() async {
    final value = _box.get(_keyPlayerLoopMode) as String?;
    return _keyToLoopModeMapper.map(value);
  }

  @override
  Future<Unit> setLoopMode(PlayerLoopMode loopMode) async {
    _box.put(_keyPlayerLoopMode, _loopModeToKeyMapper.map(loopMode));
    return unit;
  }

  //endregion playerLoopMode

  //region lastKnownAppVersion
  @override
  Future<AppVersion> getLastKnownAppVersion() async {
    final value = _box.get(_keyLastKnownAppVersion, defaultValue: '');
    return _stringToAppVersionMapper.map(value);
  }

  @override
  Future<Unit> setLastKnownAppVersion(AppVersion appVersion) async {
    final value = _appVersionToStringMapper.map(appVersion);
    _box.put(_keyLastKnownAppVersion, value);
    return unit;
  }

  //endregion lastKnownAppVersion

  //region crashLoggingEnabled
  @override
  Future<bool> getCrashLoggingEnabled() async {
    final value = _box.get(_keyCrashLoggingEnabled);
    return value ?? true;
  }

  @override
  Future<Unit> setCrashLoggingEnabled(bool isEnabled) async {
    _box.put(_keyCrashLoggingEnabled, isEnabled);
    return unit;
  }

  //endregion crashLoggingEnabled

  //region trackingEnabled
  @override
  Future<bool> getTrackingEnabled() async {
    final value = _box.get(_keyTrackingEnabled);
    return value ?? true;
  }

  @override
  Future<Unit> setTrackingEnabled(bool isEnabled) async {
    _box.put(_keyTrackingEnabled, isEnabled);
    return unit;
  }

  //endregion trackingEnabled

  //region showDotType
  @override
  Future<bool> showDotForType(ShowDotType type) async {
    if (type.isUnknown) return false;
    final key = _showDotTypeToKeyMapper.map(type);
    final value = _box.get(key, defaultValue: true);
    return value;
  }

  @override
  Future<Unit> setShowDotType(
    ShowDotType type, {
    required bool show,
  }) async {
    final key = _showDotTypeToKeyMapper.map(type);
    _box.put(key, show);
    return unit;
  }

  @override
  Stream<bool> watchShowDotForType(ShowDotType type) async* {
    final streamTransformer = StreamTransformer.fromHandlers(
      handleData: (BoxEvent event, EventSink<bool> sink) {
        sink.add(event.value);
      },
    );
    final key = _showDotTypeToKeyMapper.map(type);
    yield* _box.watch(key: key).distinct().transform(streamTransformer);
  }

  //endregion showDotType

  //region shareAppClicked
  @override
  Future<bool> isShareAppClicked() async {
    final value = _box.get(_keyShareAppClicked, defaultValue: false);
    return value;
  }

  @override
  Future<Unit> setShareAppClicked() async {
    await _box.put(_keyShareAppClicked, true);
    return unit;
  }

  //endregion shareAppClicked

  //region rateAppClicked
  @override
  Future<bool> isRateAppClicked() async {
    final value = _box.get(_keyRateAppClicked, defaultValue: false);
    return value;
  }

  @override
  Future<Unit> setRateAppClicked() async {
    await _box.put(_keyRateAppClicked, true);
    return unit;
  }

  //endregion rateAppClicked

  //region supportAppClicked

  @override
  Future<bool> isSupportAppClicked() async {
    final value = _box.get(_keySupportAppClicked, defaultValue: false);
    return value;
  }

  @override
  Future<Unit> setSupportAppClicked() async {
    await _box.put(_keySupportAppClicked, true);
    return unit;
  }

  @override
  Future<MenuDynamicItemId> getLastSeenMenuDynamicDataId() async {
    final value = _box.get(_keyLastSeenDynamicItemId, defaultValue: null);
    return MenuDynamicItemId(value ?? 'id');
  }

  @override
  Future<Unit> setLastSeenMenuDynamicDataId(MenuDynamicItemId itemId) async {
    await _box.put(_keyLastSeenDynamicItemId, itemId.get());
    return unit;
  }
//endregion supportAppClicked
}
