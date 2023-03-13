import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/data_source/remote_configs.dart';
import 'package:mobile_app/domain/model/app_theme/app_theme.dart';
import 'package:mobile_app/domain/model/settings/settings_data_audio.dart';
import 'package:mobile_app/domain/model/settings/settings_data_general.dart';
import 'package:mobile_app/domain/model/settings/settings_data_text.dart';
import 'package:mobile_app/domain/model/settings/text_scale_factor.dart';
import 'package:mobile_app/domain/navigation/snackbar_controller.dart';
import 'package:mobile_app/domain/tracking/tracker.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/domain/value_objects/url_string.dart';
import 'package:mobile_app/data/use_case/audio/cache_all_audio_use_case.dart';
import 'package:mobile_app/data/use_case/audio/delete_all_audio_tales_use_case.dart';
import 'package:mobile_app/data/use_case/audio/get_cached_all_audio_info_use_case.dart';
import 'package:mobile_app/data/use_case/connection/is_connection_mobile_use_case.dart';
import 'package:mobile_app/data/use_case/helper/open_url_use_case.dart';
import 'package:mobile_app/data/use_case/settings/listen_app_theme_changes_use_case.dart';
import 'package:mobile_app/data/use_case/settings/listen_text_scale_factor_changes_use_case.dart';
import 'package:mobile_app/data/use_case/settings/user_data/delete_user_data_use_case.dart';
import 'package:mobile_app/data/use_case/settings/user_data/get_crash_logging_enabled_use_case.dart';
import 'package:mobile_app/data/use_case/settings/user_data/get_tracking_enabled_use_case.dart';
import 'package:mobile_app/data/use_case/settings/user_data/set_crash_logging_enabled_use_case.dart';
import 'package:mobile_app/data/use_case/settings/user_data/set_tracking_enabled_use_case.dart';
import 'package:mobile_app/presentation/navigation/dialog/dialog_controller.dart';
import 'package:mobile_app/presentation/navigation/screen/screen_controller.dart';
import 'package:mobile_app/domain/model/settings/settings_page_type.dart';

part 'settings_screen_state.dart';

part 'settings_screen_manager.freezed.dart';

@injectable
class SettingsScreenManager extends Cubit<SettingsScreenState> {
  final Tracker _tracker;
  final ScreenController _screenController;
  final DialogController _dialogController;
  final SnackbarController _snackbarController;
  final RemoteConfigs _remoteConfigs;
  final UseCase<AppTheme, Dry> _setAppThemeUseCase;
  final UseCase<ListenAppThemeChangesInput, AppTheme>
      _listenAppThemeChangesUseCase;
  final UseCase<Dry, DeleteAllAudioTalesOutput> _deleteAllAudioUseCase;
  final UseCase<Dry, GetCachedAudioInfoOutput> _getCachedAudioInfoUseCase;
  final UseCase<Dry, CacheAllAudioOutput> _cacheAllAudioUseCase;
  final UseCase<Dry, IsConnectionMobileOutput> _isConnectionMobileUseCase;
  final UseCase<Dry, GetCrashLoggingEnabledOutput>
      _getCrashLoggingEnabledUseCase;
  final UseCase<bool, SetCrashLoggingEnabledOutput>
      _setCrashLoggingEnabledUseCase;
  final UseCase<Dry, GetTrackingEnabledOutput> _getTrackingEnabledUseCase;
  final UseCase<bool, SetTrackingEnabledOutput> _setTrackingEnabledUseCase;
  final UseCase<Dry, DeleteUserDataUseCaseOutput> _deleteUserDataUseCase;
  final UseCase<UrlString, OpenUrlOutput> _openUrlUseCase;
  final UseCase<TextScaleFactor, Dry> _setTextScaleFactorUseCase;
  final UseCase<ListenTextScaleFactorChangesInput, TextScaleFactor>
      _listenTextScaleFactorUseCase;

  SettingsScreenManager(
    this._tracker,
    this._screenController,
    this._dialogController,
    this._snackbarController,
    this._remoteConfigs,
    this._setAppThemeUseCase,
    this._listenAppThemeChangesUseCase,
    this._deleteAllAudioUseCase,
    this._getCachedAudioInfoUseCase,
    this._cacheAllAudioUseCase,
    this._isConnectionMobileUseCase,
    this._getCrashLoggingEnabledUseCase,
    this._setCrashLoggingEnabledUseCase,
    this._getTrackingEnabledUseCase,
    this._setTrackingEnabledUseCase,
    this._deleteUserDataUseCase,
    this._openUrlUseCase,
    this._setTextScaleFactorUseCase,
    this._listenTextScaleFactorUseCase,
  ) : super(const SettingsScreenState.initial());

  SettingsScreenStateReady get _stateReady => state as SettingsScreenStateReady;

  late final _subscriptionGroup = UseCaseSubscriptionGroup();
  UseCaseSubscription? _cacheAllAudioSubscription;

  @override
  Future<void> close() async {
    await _subscriptionGroup.cancel();
    _cacheAllAudioSubscription?.cancel();
    return super.close();
  }

  void init(SettingsPageType openType) async {
    const pages = SettingsPageType.values;
    final initialPageIndex = pages.indexOf(openType);

    final isCrashLoggingEnabled =
        (await _getCrashLoggingEnabledUseCase.call(dry)).isEnabled;
    final isTrackingEnabled =
        (await _getTrackingEnabledUseCase.call(dry)).isEnabled;

    const dataText = SettingsDataText();
    final dataAudio = SettingsDataAudio(
      needToCacheAudioInfo: StringSingleLine(' '),
      cachedAudioInfo: StringSingleLine(' '),
    );
    final ready = SettingsScreenState.ready(
      pages: pages,
      initialPageIndex: initialPageIndex,
      dataGeneral: SettingsDataGeneral(
        isCrashLoggingEnabled: isCrashLoggingEnabled,
        isTrackingEnabled: isTrackingEnabled,
      ),
      dataAudio: dataAudio,
      dataText: dataText,
    );
    emit(ready);

    _addListeners();
  }

  void onThemeChanged(AppTheme theme) async {
    final event = TrackingEvents.getSettingsThemePressed(theme);
    _tracker.event(event);
    await _setAppThemeUseCase.call(theme);
  }

  void onTextScaleFactorChanged(TextScaleFactor scaleFactor) async {
    final event = TrackingEvents.getSettingsTextScaleFactorPressed(scaleFactor);
    _tracker.event(event);

    await _setTextScaleFactorUseCase.call(scaleFactor);

    ///
    // replace me with useCase
    final dataText = _stateReady.dataText.copyWith(
      textScaleFactor: scaleFactor,
    );
    emit(_stateReady.copyWith(dataText: dataText));
  }

  void onDeleteAllAudioPressed() {
    _tracker.event(TrackingEvents.settingsDeleteAllAudioPressed);
    _dialogController.showConfirmDeleteAllAudio(
      onConfirmPressed: () {
        _tracker.event(TrackingEvents.settingsDeleteAllAudioConfirmPressed);
        final dataAudio = _stateReady.dataAudio.copyWith(
          hasCachedAudio: false,
        );
        emit(_stateReady.copyWith(dataAudio: dataAudio));
        _deleteAllAudioUseCase.call(dry);
      },
    );
  }

  void onCacheAllAudioPressed() async {
    _tracker.event(TrackingEvents.settingsCacheAudioPressed);
    void cacheAllAction() {
      final dataAudio = _stateReady.dataAudio.copyWith(isCachingNow: true);
      emit(_stateReady.copyWith(dataAudio: dataAudio));
      _cacheAllAudioSubscription = _cacheAllAudioUseCase.listen(
        dry,
        (output) {
          if (!output.isSuccessful) _snackbarController.showCacheAudioFailed();
          onStopCacheAllAudioPressed();
        },
      );
    }

    final isConnectionMobile =
        (await _isConnectionMobileUseCase.call(dry)).isMobile;

    if (isConnectionMobile) {
      _dialogController.showSwitchToWiFi(onContinuePressed: cacheAllAction);
    } else {
      cacheAllAction();
    }
  }

  void onStopCacheAllAudioPressed() async {
    _tracker.event(TrackingEvents.settingsStopCachingAudioPressed);
    _cacheAllAudioSubscription?.cancel();
    _cacheAllAudioSubscription = null;
    final dataAudio = _stateReady.dataAudio.copyWith(isCachingNow: false);
    emit(_stateReady.copyWith(dataAudio: dataAudio));
  }

  void onBackPressed() => _screenController.pop();

  void setCrashLoggingEnabled(bool isEnabled) async {
    final output = await _setCrashLoggingEnabledUseCase.call(isEnabled);
    final dataGeneral = _stateReady.dataGeneral.copyWith(
      isCrashLoggingEnabled: output.isEnabled,
    );
    emit(_stateReady.copyWith(dataGeneral: dataGeneral));
  }

  void setTrackingEnabled(bool isEnabled) async {
    final output = await _setTrackingEnabledUseCase.call(isEnabled);
    final dataGeneral = _stateReady.dataGeneral.copyWith(
      isTrackingEnabled: output.isEnabled,
    );
    emit(_stateReady.copyWith(dataGeneral: dataGeneral));
  }

  void onPrivacyPolityPressed() =>
      _openUrlUseCase.call(_remoteConfigs.getPrivacyPolicyUrl());

  void onTermsAndConditionsPressed() =>
      _openUrlUseCase.call(_remoteConfigs.getTermsAndConditionsUrl());

  void onDeleteUserDataPressed() => _dialogController.showConfirmDeleteUseData(
        onConfirmPressed: deleteUserDataAction,
      );

  void _addListeners() {
    final appThemeSubscription = _listenAppThemeChangesUseCase.listen(
      listenAppThemeChangesInput,
      (AppTheme appTheme) {
        final newGeneral = _stateReady.dataGeneral.copyWith(appTheme: appTheme);
        final newState = _stateReady.copyWith(dataGeneral: newGeneral);
        emit(newState);
      },
    );
    _subscriptionGroup.add(appThemeSubscription);

    final textScaleFactorSubscription = _listenTextScaleFactorUseCase.listen(
      listenTextScaleFactorChangesInput,
      (TextScaleFactor factor) {
        final text = _stateReady.dataText.copyWith(textScaleFactor: factor);
        final newState = _stateReady.copyWith(dataText: text);
        emit(newState);
      },
    );
    _subscriptionGroup.add(textScaleFactorSubscription);

    final cachedAudioInfoSubscription = _getCachedAudioInfoUseCase.listen(dry,
        (GetCachedAudioInfoOutput output) {
      final dataAudio = _stateReady.dataAudio.copyWith(
        needToCacheAudioInfo: output.needToCacheAudioInfo,
        cachedAudioInfo: output.cachedAudioInfo,
        hasCachedAudio: output.hasCachedAudio,
        hasMoreAudioToCache: output.hasMoreAudioToCache,
      );
      emit(_stateReady.copyWith(dataAudio: dataAudio));
    });
    _subscriptionGroup.add(cachedAudioInfoSubscription);
  }

  @visibleForTesting
  void deleteUserDataAction() async {
    final output = await _deleteUserDataUseCase.call(dry);
    final dataGeneral = _stateReady.dataGeneral.copyWith(
      isTrackingEnabled: output.isTrackingEnabled,
      isCrashLoggingEnabled: output.isCrashLoggingEnabled,
    );
    emit(_stateReady.copyWith(dataGeneral: dataGeneral));
  }
}
