import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/infrastructure/helper/player/audio_player.dart';
import 'package:mobile_app/infrastructure/helper/tracking/tracker_group.dart';
import 'package:mobile_app/infrastructure/use_case/audio/stop_playing_use_case.dart';
import 'package:mobile_app/infrastructure/use_case/menu/listen_show_menu_dot_use_case.dart';
import 'package:mobile_app/infrastructure/use_case/tale/get_tale_use_case.dart';
import 'package:mobile_app/presentation/navigation/screen/screen_controller.dart';
import 'package:mobile_app/presentation/view/screen/home/model/home_page_type.dart';

part 'home_screen_manager.freezed.dart';

part 'home_screen_state.dart';

typedef ChangePageAction = Function(int pageIndex);

@injectable
class HomeScreenManager extends Cubit<HomeScreenState> {
  final Tracker _tracker;
  final ScreenController _screenController;
  final UseCase<Dry, Option<TalesPageItemData>> _listenCurrentPlayingUseCase;
  final UseCase<Dry, ListenShowMenuDotOutput> _listenShowMenuDotUseCase;
  final UseCase<Dry, StopPlayingOutput> _stopPlayingUseCase;
  final UseCase<TaleId, GetTaleOutput> _getTaleUseCase;
  final AudioPlayer _player;

  HomeScreenManager(
    this._screenController,
    this._tracker,
    this._player,
    this._listenCurrentPlayingUseCase,
    this._stopPlayingUseCase,
    this._getTaleUseCase,
    this._listenShowMenuDotUseCase,
  ) : super(const HomeScreenState.initial()) {
    _init();
  }

  final _subscriptionGroup = UseCaseSubscriptionGroup();
  late ChangePageAction _changePageAction;

  HomeScreenStateReady get _stateReady => state as HomeScreenStateReady;

  @override
  Future<void> close() async {
    await _player.release();
    await _subscriptionGroup.cancel();
    return super.close();
  }

  void _init() {
    final pages = HomePageType.values.toList();
    pages.sort((a, b) => a.index.compareTo(b.index));

    final ready = HomeScreenState.ready(
      pages: pages,
      currentPage: HomePageType.tales,
      activeAudioTaleOption: const None(),
      showMenuDot: false,
    );
    emit(ready);
    _addListener();
  }

  @override
  void onChange(Change<HomeScreenState> change) {
    if (change.nextState is HomeScreenStateReady) {
      final nextState = change.nextState as HomeScreenStateReady;
      final needTrack = change.currentState is! HomeScreenStateReady ||
          (change.currentState as HomeScreenStateReady).currentPage !=
              nextState.currentPage;
      if (needTrack) {
        _trackPage(nextState.currentPage);
      }
    }
    super.onChange(change);
  }

  void setChangePageAction(ChangePageAction action) =>
      _changePageAction = action;

  void onStopPlayingPressed() {
    _stopPlayingUseCase.call(dry);
    _tracker.event(TrackingEvents.homeCurrentAudioTaleStopPressed);
  }

  void onTalePressed(TalesPageItemData item) async {
    _tracker.event(TrackingEvents.homeCurrentAudioTalePressed);
    final taleOutput = await _getTaleUseCase.call(item.id);
    _screenController.openTale(
      tale: taleOutput.tale,
      openAudio: true,
    );
  }

  void onPagePressed(HomePageType type) {
    if (_stateReady.currentPage == type) return;

    final index = _stateReady.pages.indexOf(type);
    _changePageAction.call(index);
    emit(_stateReady.copyWith(currentPage: type));
  }

  void _trackPage(HomePageType type) {
    final event = type.map(
      tales: () => TrackingViews.pageHomeTales,
      fav: () => TrackingViews.pageHomeFav,
      people: () => TrackingViews.pageHomePeople,
      menu: () => TrackingViews.pageHomeMenu,
    );
    _tracker.view(event);
  }

  void _addListener() {
    final playerSubscription = _listenCurrentPlayingUseCase.listen(
      dry,
      (Option<TalesPageItemData> output) {
        final state = _stateReady.copyWith(activeAudioTaleOption: output);
        emit(state);
      },
    );

    _subscriptionGroup.add(playerSubscription);
    final dotSubscription = _listenShowMenuDotUseCase.listen(
      dry,
      (output) => emit(_stateReady.copyWith(showMenuDot: output.showDot)),
    );
    _subscriptionGroup.add(dotSubscription);
  }
}
