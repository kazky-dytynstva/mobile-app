part of 'search_tale_manager.dart';

@freezed
abstract class SearchTaleState with _$SearchTaleState {
  const factory SearchTaleState.init() = _Init;

  const factory SearchTaleState.ready({
    required List<TalesPageItemData> results,
    required TaleName taleName,
    required PersonName authorName,
    required Option<StringSingleLine> searchPhraseOption,
  }) = SearchTaleStateReady;
}
