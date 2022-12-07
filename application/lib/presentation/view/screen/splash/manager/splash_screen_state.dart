part of 'splash_screen_manager.dart';

@freezed
class SplashScreenState with _$SplashScreenState {
  const factory SplashScreenState.initial() = _Initial;

  const factory SplashScreenState.failed({
    required StringNonEmpty errorMsg,
  }) = _Failed;
}
