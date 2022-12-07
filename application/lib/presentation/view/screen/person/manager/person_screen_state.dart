part of 'person_screen_manager.dart';

@freezed
class PersonScreenState with _$PersonScreenState {
  const factory PersonScreenState.initial() = _Initial;

  const factory PersonScreenState.ready({
    required Person person,
    required List<PersonTalesTabData> tabDataList,
    DateTime? timestamp,
  }) = PersonScreenStateReady;
}
