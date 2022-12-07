import 'dart:ui';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/domain/model/settings/settings_data_audio.dart';
import 'package:mobile_app/domain/model/settings/settings_data_general.dart';
import 'package:mobile_app/domain/model/settings/settings_data_text.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/domain/value_objects/url_string.dart';
import 'package:mobile_app/infrastructure/use_case/helper/open_url_use_case.dart';
import 'package:mobile_app/infrastructure/use_case/settings/user_data/delete_user_data_use_case.dart';
import 'package:mobile_app/infrastructure/use_case/settings/user_data/set_crash_logging_enabled_use_case.dart';
import 'package:mobile_app/infrastructure/use_case/settings/user_data/set_tracking_enabled_use_case.dart';
import 'package:mobile_app/presentation/view/screen/settings/manager/settings_screen_manager.dart';
import 'package:mobile_app/domain/model/settings/settings_page_type.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../utils/utils.dart';

void main() {
  late MockRemoteConfigs remoteConfigs;
  late MockTracker tracker;
  late MockScreenController screenController;
  late MockDialogController dialogController;
  late MockSnackbarController snackbarController;
  late MockSetAppThemeUseCase setAppThemeUseCase;
  late MockListenAppThemeChangesUseCase listenAppThemeChangesUseCase;
  late MockDeleteAllAudioTalesUseCase deleteAllAudioTalesUseCase;
  late MockGetCachedAudioInfoUseCase getCachedAudioInfoUseCase;
  late MockCacheAllAudioUseCase cacheAllAudioUseCase;
  late MockIsConnectionMobileUseCase isConnectionMobileUseCase;
  late MockGetCrashLoggingEnabledUseCase getCrashLoggingEnabledUseCase;
  late MockSetCrashLoggingEnabledUseCase setCrashLoggingEnabledUseCase;
  late MockGetTrackingEnabledUseCase getTrackingEnabledUseCase;
  late MockSetTrackingEnabledUseCase setTrackingEnabledUseCase;
  late MockDeleteUserDataUseCase deleteUserDataUseCase;
  late MockOpenUrlUseCase openUrlUseCase;
  late MockListenTextScaleFactorChangesUseCase
      listenTextScaleFactorChangesUseCase;
  late MockSetTextScaleFactorUseCase setTextScaleFactorUseCase;

  late SettingsScreenManager manager;

  setUp(() {
    tracker = MockTracker();
    remoteConfigs = MockRemoteConfigs();
    screenController = MockScreenController();
    dialogController = MockDialogController();
    snackbarController = MockSnackbarController();
    setAppThemeUseCase = MockSetAppThemeUseCase();
    listenAppThemeChangesUseCase = MockListenAppThemeChangesUseCase();
    deleteAllAudioTalesUseCase = MockDeleteAllAudioTalesUseCase();
    getCachedAudioInfoUseCase = MockGetCachedAudioInfoUseCase();
    cacheAllAudioUseCase = MockCacheAllAudioUseCase();
    isConnectionMobileUseCase = MockIsConnectionMobileUseCase();
    getCrashLoggingEnabledUseCase = MockGetCrashLoggingEnabledUseCase();
    setCrashLoggingEnabledUseCase = MockSetCrashLoggingEnabledUseCase();
    getTrackingEnabledUseCase = MockGetTrackingEnabledUseCase();
    setTrackingEnabledUseCase = MockSetTrackingEnabledUseCase();
    deleteUserDataUseCase = MockDeleteUserDataUseCase();
    openUrlUseCase = MockOpenUrlUseCase();
    listenTextScaleFactorChangesUseCase =
        MockListenTextScaleFactorChangesUseCase();
    setTextScaleFactorUseCase = MockSetTextScaleFactorUseCase();

    manager = SettingsScreenManager(
      tracker,
      screenController,
      dialogController,
      snackbarController,
      remoteConfigs,
      setAppThemeUseCase,
      listenAppThemeChangesUseCase,
      deleteAllAudioTalesUseCase,
      getCachedAudioInfoUseCase,
      cacheAllAudioUseCase,
      isConnectionMobileUseCase,
      getCrashLoggingEnabledUseCase,
      setCrashLoggingEnabledUseCase,
      getTrackingEnabledUseCase,
      setTrackingEnabledUseCase,
      deleteUserDataUseCase,
      openUrlUseCase,
      setTextScaleFactorUseCase,
      listenTextScaleFactorChangesUseCase,
    );
  });

  SettingsScreenStateReady getStateReady({
    List<SettingsPageType> pages = SettingsPageType.values,
    int initialPageIndex = 0,
    SettingsDataGeneral dataGeneral = const SettingsDataGeneral(),
    SettingsDataText dataText = const SettingsDataText(),
    SettingsDataAudio? dataAudio,
  }) =>
      SettingsScreenState.ready(
        pages: pages,
        initialPageIndex: initialPageIndex,
        dataGeneral: dataGeneral,
        dataText: dataText,
        dataAudio: dataAudio ??
            SettingsDataAudio(
              needToCacheAudioInfo: StringSingleLine('need'),
              cachedAudioInfo: StringSingleLine('cached'),
            ),
      ) as SettingsScreenStateReady;
  group('setCrashLoggingEnabled method', () {
    blocTest<SettingsScreenManager, SettingsScreenState>(
      'GIVEN false THEN call useCase emit updated state',
      build: () => manager,
      setUp: () {
        when(() => setCrashLoggingEnabledUseCase.call(false)).thenAnswer(
          (_) async => const SetCrashLoggingEnabledOutput(false),
        );
      },
      seed: () => getStateReady(
        dataGeneral: const SettingsDataGeneral(isCrashLoggingEnabled: true),
      ),
      act: (_) => manager.setCrashLoggingEnabled(false),
      verify: (_) {
        verify(() => setCrashLoggingEnabledUseCase.call(false));
        verifyNoMoreInteractions(setCrashLoggingEnabledUseCase);
        verifyZeroInteractions(getCrashLoggingEnabledUseCase);
      },
      expect: () {
        const dataGeneral = SettingsDataGeneral(isCrashLoggingEnabled: false);
        return [getStateReady(dataGeneral: dataGeneral)];
      },
    );
    blocTest<SettingsScreenManager, SettingsScreenState>(
      'GIVEN true THEN call useCase emit updated state',
      build: () => manager,
      setUp: () {
        when(() => setCrashLoggingEnabledUseCase.call(true)).thenAnswer(
          (_) async => const SetCrashLoggingEnabledOutput(true),
        );
      },
      seed: () => getStateReady(
        dataGeneral: const SettingsDataGeneral(isCrashLoggingEnabled: false),
      ),
      act: (_) => manager.setCrashLoggingEnabled(true),
      verify: (_) {
        verify(() => setCrashLoggingEnabledUseCase.call(true));
        verifyNoMoreInteractions(setCrashLoggingEnabledUseCase);
        verifyZeroInteractions(getCrashLoggingEnabledUseCase);
      },
      expect: () {
        const dataGeneral = SettingsDataGeneral(isCrashLoggingEnabled: true);
        return [getStateReady(dataGeneral: dataGeneral)];
      },
    );
  });

  group('setTrackingEnabled method', () {
    blocTest<SettingsScreenManager, SettingsScreenState>(
      'GIVEN false THEN call useCase emit updated state',
      build: () => manager,
      setUp: () {
        when(() => setTrackingEnabledUseCase.call(false)).thenAnswer(
          (_) async => const SetTrackingEnabledOutput(false),
        );
      },
      seed: () => getStateReady(
        dataGeneral: const SettingsDataGeneral(isTrackingEnabled: true),
      ),
      act: (_) => manager.setTrackingEnabled(false),
      verify: (_) {
        verify(() => setTrackingEnabledUseCase.call(false));
        verifyNoMoreInteractions(setTrackingEnabledUseCase);
        verifyZeroInteractions(getTrackingEnabledUseCase);
      },
      expect: () {
        const dataGeneral = SettingsDataGeneral(isTrackingEnabled: false);
        return [getStateReady(dataGeneral: dataGeneral)];
      },
    );
    blocTest<SettingsScreenManager, SettingsScreenState>(
      'GIVEN true THEN call useCase emit updated state',
      build: () => manager,
      setUp: () {
        when(() => setTrackingEnabledUseCase.call(true)).thenAnswer(
          (_) async => const SetTrackingEnabledOutput(true),
        );
      },
      seed: () => getStateReady(
        dataGeneral: const SettingsDataGeneral(isTrackingEnabled: false),
      ),
      act: (_) => manager.setTrackingEnabled(true),
      verify: (_) {
        verify(() => setTrackingEnabledUseCase.call(true));
        verifyNoMoreInteractions(setTrackingEnabledUseCase);
        verifyZeroInteractions(getTrackingEnabledUseCase);
      },
      expect: () {
        const dataGeneral = SettingsDataGeneral(isTrackingEnabled: true);
        return [getStateReady(dataGeneral: dataGeneral)];
      },
    );
  });

  group('onDeleteUserDataPressed method', () {
    late final VoidCallback onDeleteAction;
    blocTest<SettingsScreenManager, SettingsScreenState>(
      'GIVEN user action WHEN confirm dialog pressed THEN call useCase and emit new state',
      build: () => manager,
      setUp: () {
        when(() => deleteUserDataUseCase.call(dry)).thenAnswer(
          (_) async => const DeleteUserDataUseCaseOutput(
            isCrashLoggingEnabled: false,
            isTrackingEnabled: false,
          ),
        );
      },
      seed: () => getStateReady(
        dataGeneral: const SettingsDataGeneral(
          isTrackingEnabled: true,
          isCrashLoggingEnabled: true,
        ),
      ),
      act: (_) {
        manager.onDeleteUserDataPressed();
        onDeleteAction = manager.deleteUserDataAction;
        onDeleteAction.call();
      },
      verify: (_) {
        verifyInOrder([
          () => dialogController.showConfirmDeleteUseData(
              onConfirmPressed: onDeleteAction),
          () => deleteUserDataUseCase.call(dry),
        ]);
        verifyNoMoreInteractions(dialogController);
        verifyNoMoreInteractions(deleteUserDataUseCase);
      },
      expect: () {
        const dataGeneral = SettingsDataGeneral(
          isTrackingEnabled: false,
          isCrashLoggingEnabled: false,
        );
        return [getStateReady(dataGeneral: dataGeneral)];
      },
    );
    blocTest<SettingsScreenManager, SettingsScreenState>(
      'GIVEN user action WHEN confirm dialog NOT pressed THEN do nothing',
      build: () => manager,
      setUp: () {
        when(() => deleteUserDataUseCase.call(dry)).thenAnswer(
          (_) async => const DeleteUserDataUseCaseOutput(
            isCrashLoggingEnabled: false,
            isTrackingEnabled: false,
          ),
        );
      },
      seed: () => getStateReady(
        dataGeneral: const SettingsDataGeneral(
          isTrackingEnabled: true,
          isCrashLoggingEnabled: true,
        ),
      ),
      act: (_) => manager.onDeleteUserDataPressed(),
      verify: (_) {
        verify(() => dialogController.showConfirmDeleteUseData(
            onConfirmPressed: manager.deleteUserDataAction));
        verifyNoMoreInteractions(dialogController);
        verifyZeroInteractions(deleteUserDataUseCase);
      },
      expect: () => [],
    );
  });

  group('onPrivacyPolityPressed method', () {
    final urlString = UrlString('https://hi.there');
    blocTest<SettingsScreenManager, SettingsScreenState>(
      "GIVEN urlString WHEN remoteConfigs called THEN call the useCase to open url",
      build: () => manager,
      setUp: () {
        when(() => remoteConfigs.getPrivacyPolicyUrl()).thenReturn(urlString);
        when(() => openUrlUseCase.call(urlString))
            .thenAnswer((_) async => const OpenUrlOutput());
      },
      act: (_) => manager.onPrivacyPolityPressed(),
      verify: (_) {
        verifyInOrder([
          () => remoteConfigs.getPrivacyPolicyUrl(),
          () => openUrlUseCase.call(urlString),
        ]);
        verifyNoMoreInteractions(remoteConfigs);
        verifyNoMoreInteractions(openUrlUseCase);
      },
      expect: () => [],
    );
  });

  group('onTermsAndConditionsPressed method', () {
    final urlString = UrlString('https://hi.there');
    blocTest<SettingsScreenManager, SettingsScreenState>(
      "GIVEN urlString WHEN remoteConfigs called THEN call the useCase to open url",
      build: () => manager,
      setUp: () {
        when(() => remoteConfigs.getTermsAndConditionsUrl())
            .thenReturn(urlString);
        when(() => openUrlUseCase.call(urlString))
            .thenAnswer((_) async => const OpenUrlOutput());
      },
      act: (_) => manager.onTermsAndConditionsPressed(),
      verify: (_) {
        verifyInOrder([
          () => remoteConfigs.getTermsAndConditionsUrl(),
          () => openUrlUseCase.call(urlString),
        ]);
        verifyNoMoreInteractions(remoteConfigs);
        verifyNoMoreInteractions(openUrlUseCase);
      },
      expect: () => [],
    );
  });
}
