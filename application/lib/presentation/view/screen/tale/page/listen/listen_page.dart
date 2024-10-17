import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/domain/model/play_audio_action/play_audio_action.dart';
import 'package:mobile_app/domain/value_objects/image_url.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/tale/page/base_tale_page.dart';
import 'package:mobile_app/presentation/view/screen/tale/page/listen/manager/listen_page_manager.dart';
import 'package:mobile_app/presentation/view/screen/tale/page/listen/widget/listen_audio_controls.dart';
import 'package:mobile_app/presentation/view/screen/tale/page/listen/widget/listen_audio_progress_bar.dart';
import 'package:mobile_app/presentation/view/screen/tale/page/listen/widget/listen_image_gallery.dart';
import 'package:mobile_app/presentation/widget/fade_animated_switcher.dart';
import 'package:mobile_app/presentation/widget/rate_the_tale.dart';
import 'package:mobile_app/presentation/widget/tale_sort_and_filter_info.dart';

class ListenTalePage extends StatefulWidget {
  const ListenTalePage({super.key});

  @override
  State<ListenTalePage> createState() => _ListenTalePageState();
}

class _ListenTalePageState
    extends BaseTalePageState<ListenTalePage, ListenPageManager> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Widget stateBuilder(BuildContext context, ListenPageState state) {
      final widget = state.map(
        initial: buildInitialState,
        ready: _buildStateReady,
      );
      return FadeAnimatedSwitcher.screen(child: widget);
    }

    return BlocBuilder(bloc: manager, builder: stateBuilder);
  }

  Widget _buildStateReady(ListenPageStateReady state) {
    final info = TaleSortAndFilterInfo(
      filterData: state.filterData,
      sortData: state.sortData,
    );
    final children = <Widget>[
      // we need to "respect" toolbar, which shown in the TaleScreen
      SizedBox(height: R.dimen.taleToolbarHeight),
      Container(
        height: R.dimen.toolbarHeight,
        color: R.palette.primary,
        padding: EdgeInsets.only(bottom: R.dimen.unit),
        child: info,
      ),
      R.spaces.verticalUnit2,
      R.spaces.verticalUnit2,
      _buildImage(state.audio.images),
      R.spaces.verticalUnit2,
      _buildProgressBar(state),
      R.spaces.verticalUnit0_5,
      _buildControls(state),
      R.spaces.verticalUnit4,
      _buildRateRaleView(state.showRateTale),
      // we need to "respect" bottomBar, which shown in the TaleScreen
      SizedBox(height: R.dimen.bottomBarWithActionsHeight),
    ];
    return SizedBox(
      height: R.dimen.screenHeight,
      child: Column(children: children),
    );
  }

  Widget _buildProgressBar(ListenPageStateReady state) =>
      ListenAudioProgressBar(
        duration: state.audio.duration,
        position: state.position,
        isCached: state.audio.isCachedFuture,
        onPositionChanged: (Duration newPosition) =>
            manager.onAudioActionPressed(
          PlayAudioAction.seekTo(newPosition),
        ),
      );

  Widget _buildControls(ListenPageStateReady state) => ListenAudioControls(
        status: state.playStatus,
        onActionPressed: manager.onAudioActionPressed,
        loopMode: state.loopMode,
        countdownActive: state.isCountdownActive,
      );

  Widget _buildImage(List<ImageUrl> images) => Expanded(
        child: Center(
          child: ListenImageGallery(
            images: images,
            // todo FIX ME
            currentIndex: 0,
          ),
        ),
      );

  Widget _buildRateRaleView(bool showRateTale) => RateTheTaleView(
        show: showRateTale,
        onPressed: manager.onRatePressed,
      );
}
