import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/data_source/storage_local/app_state_storage.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/app_version/app_version.dart';
import 'package:mobile_app/domain/model/player/loop_mode.dart';
import 'package:mobile_app/domain/model/show_dot/show_dot_type.dart';
import 'package:mobile_app/domain/value_objects/file_path.dart';
import 'package:mobile_app/data/data_source/storage_local/app_state/app_state_storage_impl.dart';
import 'package:mobile_app/data/data_source/storage_local/box_names.dart';
import 'package:mobile_app/data/data_source/storage_local/people/entity/person_entity.dart';
import 'package:mobile_app/data/data_source/storage_local/tale/entity/tale_entity.dart';
import 'package:mobile_app/data/env_config/env_config.dart';
import 'package:path_provider/path_provider.dart';

typedef DbKey = int;

@module
abstract class StorageModule {
  @preResolve
  @singleton
  @Named("cacheDirPath")
  Future<FilePath> get cacheDirPath async {
    final appDocDir = await getApplicationDocumentsDirectory();
    return FilePath(appDocDir.path);
  }

  @preResolve
  @singleton
  Future<HiveInterface> getHive(
      @Named("cacheDirPath") FilePath cacheDirPath) async {
    final hive = Hive;

    hive.init(cacheDirPath.get());
    hive.registerAdapter(TaleEntityAdapter());
    hive.registerAdapter(PersonEntityAdapter());

    if (!EnvConfig.isProd) {
      await hive.openBox<bool>(BoxNames.devFeatureFlags);
    }

    await hive.openBox(BoxNames.appState);

    return hive;
  }

  @lazySingleton
  AppStateStorage getAppStorage(
    HiveInterface hive,
    Mapper<PlayerLoopMode, String> loopModeToKeyMapper,
    Mapper<String?, PlayerLoopMode> keyToLoopModeMapper,
    Mapper<AppVersion, String> appVersionToStringMapper,
    Mapper<String, AppVersion> stringToAppVersionMapper,
    Mapper<ShowDotType, String> showDotTypeToKeyMapper,
  ) =>
      AppStateStorageImpl(
        hive.box(BoxNames.appState),
        loopModeToKeyMapper,
        keyToLoopModeMapper,
        appVersionToStringMapper,
        stringToAppVersionMapper,
        showDotTypeToKeyMapper,
      );
}
