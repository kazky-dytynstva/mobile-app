part of 'tale_screen_manager.dart';

@freezed
abstract class TaleScreenState with _$TaleScreenState {
  const factory TaleScreenState.initial() = _Initial;

  const factory TaleScreenState.ready({
    required TaleSwitchType switchType,
    required TalePageType pageType,
    required Tale tale,
    required IntPositive chapterIndex,
  }) = TaleScreenStateReady;
}
