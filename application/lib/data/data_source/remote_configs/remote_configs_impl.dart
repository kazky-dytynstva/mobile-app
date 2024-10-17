import 'dart:async';
import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/domain/value_objects/url_string.dart';
import 'package:mobile_app/domain/data_source/remote_configs.dart';
import 'package:mobile_app/data/data_source/remote_configs/dto/forced_update_info/forced_update_info_dto.dart';
import 'package:mobile_app/data/data_source/remote_configs/dto/menu_dynamic_item/menu_dynamic_item_dto.dart';
import 'package:mobile_app/data/env_config/env_config.dart';
import 'package:mobile_app/data/helper/analytic/crash_analytic.dart';
import 'package:mobile_app/data/helper/logger/logger.dart';

@LazySingleton(as: RemoteConfigs)
class RemoteConfigsImpl implements RemoteConfigs {
  final FirebaseRemoteConfig _config;

  final CrashAnalytic _crashAnalytic;
  final Logger _logger;

  RemoteConfigsImpl(
    this._config,
    this._logger,
    this._crashAnalytic,
  );

  @override
  Future<bool> init({required Duration expiration}) async {
    final settings = RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval:
          EnvConfig.isDebug ? const Duration(minutes: 1) : expiration,
    );

    await _config.setConfigSettings(settings);

    final hasData = _config.lastFetchTime.isAfter(DateTime(1971, 1, 1));

    if (hasData) {
      await _config.activate();
      _config.fetch();
      return true;
    }

    var fetched = true;
    await _config.fetch().catchError((error) {
      _logger.log(
        () => 'Failed to init: $error',
        tag: 'REMOTE_CONFIGS',
      );
      if (!error.toString().contains("Unable to complete fetch") &&
          error is! TimeoutException &&
          !error.toString().contains('Invalid envelope')) {
        final exception = _InitRemoteConfigsException(error);
        _crashAnalytic.exception(exception, StackTrace.current);
      }
      fetched = false;
    });

    if (fetched) {
      await _config.activate();
    }
    return fetched;
  }

  @override
  ForcedUpdateInfoDto? getForcedUpdateInfo() {
    final jsonValue = _config.getString(_Keys._configForcedUpdateInfo);
    if (jsonValue.isEmpty) return null;
    try {
      final value = json.decode(jsonValue);
      return ForcedUpdateInfoDto.fromJson(value);
    } catch (e) {
      _crashAnalytic.exception(
        _ParseJsonConfigException(e),
        StackTrace.current,
        fatal: true,
      );
      return null;
    }
  }

  @override
  MenuDynamicItemDto? getMenuDynamicItem() {
    final jsonValue = _config.getString(_Keys._configMenuDynamicItemData);
    if (jsonValue.isEmpty) return null;
    try {
      final value = json.decode(jsonValue);
      return MenuDynamicItemDto.fromJson(value);
    } catch (e) {
      _crashAnalytic.exception(
        _ParseJsonConfigException(e),
        StackTrace.current,
        fatal: true,
      );
      return null;
    }
  }

  @override
  StringSingleLine getDevEmail() {
    final value = _config.getString(_Keys._configDevEmail);
    return StringSingleLine(value);
  }

  @override
  UrlString shareAppLink() {
    final input = _config.getString(_Keys._configShareAppLink);
    return UrlString(input);
  }

  @override
  UrlString getDonateUrl() {
    final input = _config.getString(_Keys._configDonateUrl);
    return UrlString(input);
  }

  @override
  UrlString getPrivacyPolicyUrl() {
    final input = _config.getString(_Keys._configPrivacyPolicyUrl);
    return UrlString(input);
  }

  @override
  UrlString getTermsAndConditionsUrl() {
    final input = _config.getString(_Keys._configTermsAndConditionsUrl);
    return UrlString(input);
  }

//endregion remoteConfigsSyncInterval
}

abstract class _Keys {
  //region remoteApi
  static const _configPrivacyPolicyUrl = "privacy_policy_url";
  static const _configTermsAndConditionsUrl = "terms_and_conditions_url";
  static const _configDonateUrl = "config_donate_url";
  static const _configMenuDynamicItemData = "config_menu_dynamic_item_data";

  //endregion remoteApi

  static const _configForcedUpdateInfo = "config_forced_update_info";

//endregion remoteConfigsSyncInterval

  static const _configDevEmail = "dev_email";
  static const _configShareAppLink = "config_share_app_link";
}

class _InitRemoteConfigsException implements Exception {
  final dynamic error;

  _InitRemoteConfigsException(this.error);

  @override
  String toString() => "Failed to init remoteConfigs. Error: $error";
}

class _ParseJsonConfigException implements Exception {
  final dynamic error;

  _ParseJsonConfigException(this.error);

  @override
  String toString() => "Failed to parse remoteConfig json. Error: $error";
}
