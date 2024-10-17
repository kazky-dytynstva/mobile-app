import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/forced_update_info/forced_update_info.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/domain/value_objects/string_not_empty.dart';
import 'package:mobile_app/data/di/dependency_injection.dart';
import 'package:mobile_app/data/helper/tracking/tracker_group.dart';
import 'package:mobile_app/data/use_case/app_start_count/increment_app_starts_count_use_case.dart';
import 'package:mobile_app/data/use_case/init_remote_configs/init_remote_configs.dart';
import 'package:mobile_app/data/use_case/prepare_content/prepare_content_use_case.dart';
import 'package:mobile_app/data/use_case/storage/check_app_version_changed_use_case.dart';
import 'package:mobile_app/presentation/navigation/screen/screen_controller.dart';
import 'package:mobile_app/presentation/resource/r.dart';

part 'splash_screen_state.dart';

part 'splash_screen_manager.freezed.dart';

@injectable
class SplashScreenManager extends Cubit<SplashScreenState> {
  final ScreenController _screenController;
  final Tracker _tracker;
  final UseCase<Dry, InitRemoteConfigsOutput> _initRemoteConfigUseCase;
  final UseCase<Dry, IncrementAppStartsCountOutput>
      _incrementAppStartCountUseCase;
  final UseCase<Dry, IntPositive> _getAppStartCount;
  final UseCase<Dry, ForcedUpdateInfo?> _getForcedUpdateInfoUseCase;
  final UseCase<Dry, CheckAppVersionChangedOutput>
      _checkAppVersionChangedUseCase;
  UseCase<PrepareContentInput, PrepareContentOutput>? _prepareContentUseCase;

  SplashScreenManager(
    this._screenController,
    this._tracker,
    this._initRemoteConfigUseCase,
    this._getAppStartCount,
    this._incrementAppStartCountUseCase,
    this._getForcedUpdateInfoUseCase,
    this._checkAppVersionChangedUseCase,
  ) : super(const SplashScreenState.initial()) {
    _init();
  }

  void retryPressed() {
    _tracker.event(TrackingEvents.splashInitRetryClicked);
    emit(const SplashScreenState.initial());
    _init();
  }

  void _init() async {
    final newState = await (await _initRemoteConfigUseCase.call(dry)).map(
      success: _initRemoteConfigSucceeded,
      failure: _initRemoteConfigFailed,
    );
    emit(newState);
    _checkAppVersionChangedUseCase.call(dry);
  }

  Future<SplashScreenState> _initRemoteConfigFailed(_) async {
    _tracker.event(TrackingEvents.splashInitFailed);
    final msg = StringNonEmpty(R.strings.splash.initAppFailedMsg);
    return SplashScreenState.failed(errorMsg: msg);
  }

  Future<SplashScreenState> _initRemoteConfigSucceeded(_) async {
    _prepareContentUseCase ??= getIt();
    final appStartCount = await _getAppStartCount.call(dry);
    final input = PrepareContentInput(silent: appStartCount > 0);
    final result = await _prepareContentUseCase!.call(input);

    return result.map(success: (_) {
      _incrementAppStartCountUseCase.call(dry);
      _openNextScreen();
      return const SplashScreenState.initial();
    }, failure: (e) {
      return SplashScreenState.failed(errorMsg: e.error);
    });
  }

  void _openNextScreen() async {
    final forcedUpdateInfo = await _getForcedUpdateInfoUseCase.call(dry);
    if (forcedUpdateInfo != null) {
      _screenController.openForcedUpdate(info: forcedUpdateInfo);
    } else {
      _screenController.openMain();
    }
  }
}
