import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/changed_data/changed_data.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_name.dart';
import 'package:mobile_app/domain/model/rating/rating_data.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_name.dart';
import 'package:mobile_app/domain/tracking/tracker.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/infrastructure/use_case/tale/change_tale_fav.dart';
import 'package:mobile_app/infrastructure/use_case/tale/get_random_tale_name_and_author_use_case.dart';
import 'package:mobile_app/infrastructure/use_case/tale/get_tale_use_case.dart';
import 'package:mobile_app/infrastructure/use_case/tale/search_tales_use_case.dart';
import 'package:mobile_app/infrastructure/util/debouncer.dart';
import 'package:mobile_app/presentation/navigation/dialog/dialog_controller.dart';
import 'package:mobile_app/presentation/navigation/screen/screen_controller.dart';

part 'search_tale_state.dart';

part 'search_tale_manager.freezed.dart';

@injectable
class SearchTaleManager extends Cubit<SearchTaleState> {
  final ScreenController _screenController;
  final DialogController _dialogController;
  final UseCase<Dry, GetRandomTaleNameAndAuthorOutput>
      _getRandomTaleNameAndAuthorUseCase;
  final UseCase<TaleId, GetTaleOutput> _getTaleUseCase;
  final UseCase<ChangeTaleFavInput, Dry> _changeTaleFavUseCase;
  final UseCase<StringSingleLine, SearchTalesOutput> _searchTalesUseCase;
  final UseCase<Dry, ChangedData<TalesPageItemData, TaleId>>
      _listenAllTalesUseCase;
  final Tracker _tracker;
  final _debouncer = Debouncer(const Duration(milliseconds: 350));

  SearchTaleManager(
    this._screenController,
    this._getRandomTaleNameAndAuthorUseCase,
    this._getTaleUseCase,
    this._changeTaleFavUseCase,
    this._searchTalesUseCase,
    this._listenAllTalesUseCase,
    this._dialogController,
    this._tracker,
  ) : super(const SearchTaleState.init()) {
    _init();
  }

  late final UseCaseSubscription _listenTalesChangesSubscription;

  SearchTaleStateReady get _stateReady => state as SearchTaleStateReady;
  var _wasCleaned = false;

  @override
  Future<void> close() async {
    await _listenTalesChangesSubscription.cancel();
    return super.close();
  }

  void onFavPressed(TalesPageItemData tale) {
    _tracker.event(TrackingEvents.searchTaleFavPressed);
    final input = ChangeTaleFavInput(tale.id, !tale.isFav);
    _changeTaleFavUseCase.call(input);
  }

  void onRatingPressed(
    TaleName name,
    RatingData data,
  ) {
    _tracker.event(TrackingEvents.searchTaleRatingPressed);
    _dialogController.showTaleRating(name: name, data: data);
  }

  void onBackPressed() => _screenController.pop();

  void onTalePressed(TalesPageItemData tale) async {
    _tracker.event(TrackingEvents.searchTalePressed);
    final taleOutput = await _getTaleUseCase.call(tale.id);
    _screenController.openTale(tale: taleOutput.tale);
  }

  void onSuggestionPressed(String text) {
    _tracker.event(TrackingEvents.searchSuggestionPressed);
    onSearchChanged(text);
  }

  void onSearchChanged(final String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) {
      _wasCleaned = true;
      final state = _stateReady.copyWith(
        searchPhraseOption: const None(),
        results: [],
      );
      emit(state);
      return;
    }
    _wasCleaned = false;
    final phrase = StringSingleLine(trimmed.toLowerCase());
    _debouncer.run(() async {
      if (_wasCleaned) return;
      final searchOutput = await _searchTalesUseCase.call(phrase);

      final state = _stateReady.copyWith(
        searchPhraseOption: Some(phrase),
        results: searchOutput.results,
      );
      emit(state);
    });
  }

  void _init() async {
    final output = await _getRandomTaleNameAndAuthorUseCase.call(dry);
    final state = SearchTaleState.ready(
      results: [],
      taleName: output.taleName,
      authorName: output.authorName,
      searchPhraseOption: const None(),
    );
    emit(state);

    void taleDeleted(TaleId id) {
      final results = _stateReady.results;
      final tale = results.firstWhereOrNull((tale) => tale.id == id);
      if (tale != null) {
        results.remove(tale);
        emit(_stateReady.copyWith(results: results));
      }
    }

    void taleUpdated(TalesPageItemData item) {
      final results = List<TalesPageItemData>.from(_stateReady.results);
      final tale = results.firstWhereOrNull((tale) => tale.id == item.id);
      if (tale == null || tale != item) {
        final index = tale == null ? -1 : results.indexOf(tale);
        if (index >= 0) {
          results.removeAt(index);
          results.insert(index, item);
        } else {
          results.add(item);
        }
        emit(_stateReady.copyWith(
          results: results,
          // timestamp: DateTime.now(),
        ));
      }
    }

    _listenTalesChangesSubscription = _listenAllTalesUseCase.listen(
      dry,
      (output) => output.map(
        deleted: taleDeleted,
        updated: taleUpdated,
      ),
    );
  }
}
