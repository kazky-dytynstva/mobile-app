import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:just_audio/just_audio.dart' as j;
import 'package:just_audio/just_audio.dart';
import 'package:mobile_app/domain/data_source/remote_configs.dart';
import 'package:mobile_app/domain/data_source/storage_local/settings_storage.dart';
import 'package:mobile_app/domain/feature_flag/feature_flag_provider.dart';
import 'package:mobile_app/domain/helper/person_sorter.dart';
import 'package:mobile_app/domain/helper/tale_sorter.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/app_theme/app_theme.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/domain/model/player/playlist_data.dart';
import 'package:mobile_app/domain/model/settings/text_scale_factor.dart';
import 'package:mobile_app/domain/model/tale_crew/tale_crew_role.dart';
import 'package:mobile_app/domain/navigation/snackbar_controller.dart';
import 'package:mobile_app/domain/repository/people_repository.dart';
import 'package:mobile_app/domain/tracking/tracker.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/domain/data_source/storage_local/app_state_storage.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_storage.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_list_storage.dart';
import 'package:mobile_app/infrastructure/data_source/storage_local/tale/entity/tale_entity.dart';
import 'package:mobile_app/domain/value_objects/url_string.dart';
import 'package:mobile_app/infrastructure/helper/analytic/crash_analytic.dart';
import 'package:mobile_app/infrastructure/helper/logger/logger.dart';
import 'package:mobile_app/infrastructure/use_case/audio/cache_all_audio_use_case.dart';
import 'package:mobile_app/infrastructure/use_case/audio/delete_all_audio_tales_use_case.dart';
import 'package:mobile_app/infrastructure/use_case/audio/get_cached_all_audio_info_use_case.dart';
import 'package:mobile_app/infrastructure/use_case/connection/is_connection_mobile_use_case.dart';
import 'package:mobile_app/infrastructure/use_case/helper/open_url_use_case.dart';
import 'package:mobile_app/infrastructure/use_case/settings/listen_app_theme_changes_use_case.dart';
import 'package:mobile_app/infrastructure/use_case/settings/listen_text_scale_factor_changes_use_case.dart';
import 'package:mobile_app/infrastructure/use_case/settings/user_data/delete_user_data_use_case.dart';
import 'package:mobile_app/infrastructure/use_case/settings/user_data/get_crash_logging_enabled_use_case.dart';
import 'package:mobile_app/infrastructure/use_case/settings/user_data/get_tracking_enabled_use_case.dart';
import 'package:mobile_app/infrastructure/use_case/settings/user_data/set_crash_logging_enabled_use_case.dart';
import 'package:mobile_app/infrastructure/use_case/settings/user_data/set_tracking_enabled_use_case.dart';
import 'package:mobile_app/presentation/navigation/dialog/dialog_controller.dart';
import 'package:mobile_app/presentation/navigation/screen/screen_controller.dart';
import 'package:mocktail/mocktail.dart';

class MockSnackbarController extends Mock implements SnackbarController {}

class MockDialogController extends Mock implements DialogController {}

class MockScreenController extends Mock implements ScreenController {}

class MockFirebaseCrashlytics extends Mock implements FirebaseCrashlytics {}

class MockFirebaseInstallations extends Mock implements FirebaseInstallations {}

class MockJustAudioPlayer extends Mock implements j.AudioPlayer {}

class MockLogger extends Mock implements Logger {}

class MockCrashAnalytic extends Mock implements CrashAnalytic {}

class MockTaleListStorage extends Mock implements TaleListStorage {}

class MockTaleStorage extends Mock implements TaleStorage {}

class MockRemoteConfigs extends Mock implements RemoteConfigs {}

class MockTracker extends Mock implements Tracker {}

class MockTaleSorter extends Mock implements TaleSorter {}

class MockTaleAudioToAudioSourceMapper extends Mock
    implements Mapper<PlaylistItemData, Future<IndexedAudioSource>> {}

class MockTaleEntityToAuthorMapper extends Mock
    implements Mapper<TaleEntity, StringSingleLine> {}

class MockCrewRoleToLabelPluralMapper extends Mock
    implements Mapper<TaleCrewRole, StringSingleLine> {}

class MockAppStateStorage extends Mock implements AppStateStorage {}

class MockSettingsStorage extends Mock implements SettingsStorage {}

class MockPeopleRepository extends Mock implements PeopleRepository {}

class MockPersonSorter extends Mock implements PersonSorter {}

class MockFeatureFlagProvider extends Mock implements FeatureFlagProvider {}

class MockSetAppThemeUseCase extends Mock implements UseCase<AppTheme, Dry> {}

class MockListenAppThemeChangesUseCase extends Mock
    implements UseCase<ListenAppThemeChangesInput, AppTheme> {}

class MockDeleteAllAudioTalesUseCase extends Mock
    implements UseCase<Dry, DeleteAllAudioTalesOutput> {}

class MockGetCachedAudioInfoUseCase extends Mock
    implements UseCase<Dry, GetCachedAudioInfoOutput> {}

class MockCacheAllAudioUseCase extends Mock
    implements UseCase<Dry, CacheAllAudioOutput> {}

class MockIsConnectionMobileUseCase extends Mock
    implements UseCase<Dry, IsConnectionMobileOutput> {}

class MockGetCrashLoggingEnabledUseCase extends Mock
    implements UseCase<Dry, GetCrashLoggingEnabledOutput> {}

class MockSetCrashLoggingEnabledUseCase extends Mock
    implements UseCase<bool, SetCrashLoggingEnabledOutput> {}

class MockGetTrackingEnabledUseCase extends Mock
    implements UseCase<Dry, GetTrackingEnabledOutput> {}

class MockSortPeopleUseCase extends Mock implements UseCase<List<Person>, Dry> {
}

class MockSetTrackingEnabledUseCase extends Mock
    implements UseCase<bool, SetTrackingEnabledOutput> {}

class MockDeleteUserDataUseCase extends Mock
    implements UseCase<Dry, DeleteUserDataUseCaseOutput> {}

class MockOpenUrlUseCase extends Mock
    implements UseCase<UrlString, OpenUrlOutput> {}

class MockListenTextScaleFactorChangesUseCase extends Mock
    implements UseCase<ListenTextScaleFactorChangesInput, TextScaleFactor> {}

class MockSetTextScaleFactorUseCase extends Mock
    implements UseCase<TextScaleFactor, Dry> {}
