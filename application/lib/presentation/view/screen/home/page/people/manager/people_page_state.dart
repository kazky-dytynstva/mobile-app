part of 'people_page_manager.dart';

@freezed
abstract class PeoplePageState with _$PeoplePageState {
  const factory PeoplePageState.initial() = _Initial;

  const factory PeoplePageState.ready({
    required List<PeoplePageTabData> tabDataList,
    required DateTime timestamp,
  }) = PeoplePageStateReady;
}
