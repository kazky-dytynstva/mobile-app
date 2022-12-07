import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/domain/model/settings/text_scale_factor.dart';
import 'package:mobile_app/domain/model/tale/tale_text_item.dart';
import 'package:mobile_app/presentation/extensions/post_callback.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/tale/page/base_tale_page.dart';
import 'package:mobile_app/presentation/view/screen/tale/page/read/manager/read_page_manager.dart';
import 'package:mobile_app/presentation/view/screen/tale/page/read/widget/tale_text_item.dart';
import 'package:mobile_app/presentation/widget/button/button_primary.dart';
import 'package:mobile_app/presentation/widget/fade_animated_switcher.dart';
import 'package:mobile_app/presentation/widget/rate_the_tale.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ReadTalePage extends StatefulWidget {
  final AutoScrollController scrollController;
  final ValueNotifier<bool> showToolbarNotifier;
  final ValueNotifier<bool> hideToolbarNotifier;

  const ReadTalePage({
    required this.scrollController,
    required this.showToolbarNotifier,
    required this.hideToolbarNotifier,
    Key? key,
  }) : super(key: key);

  @override
  State<ReadTalePage> createState() => _ReadTalePageState();
}

class _ReadTalePageState
    extends BaseTalePageState<ReadTalePage, ReadTalePageManager> {
  late final showScrollToTopNotifier = ValueNotifier<bool>(false);
  late final appScrollDuration = R.durations.animLong;
  bool initialPositionSet = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Widget stateBuilder(BuildContext context, ReadPageState state) {
      final widget = state.map(
        initial: buildInitialState,
        ready: _buildStateReady,
      );
      return FadeAnimatedSwitcher.screen(child: widget);
    }

    return BlocBuilder(bloc: manager, builder: stateBuilder);
  }

  Widget _buildStateReady(ReadPageStateReady state) {
    _scrollToInitialPosition(state.initialIndex);
    return Stack(children: [
      Positioned.fill(child: _buildTextItems(state)),
      _buildScrollToTopBtn(),
    ]);
  }

  Widget _buildTextItems(ReadPageStateReady state) {
    final padding = EdgeInsets.only(
      bottom: R.dimen.bottomBarWithActionsHeight + R.dimen.unit3,
      top: R.dimen.taleToolbarHeight,
    );

    final items = state.textItems;

    return ListView.builder(
      controller: widget.scrollController,
      itemBuilder: (_, index) {
        final isLast = index == items.length;
        return isLast
            ? _buildRateRale(state.showRateTale)
            : _buildItem(items[index], index, state.textScaleFactor);
      },
      // +1 for TaleRatingView
      itemCount: items.length + 1,
      padding: padding,
    );
  }

  Widget _buildRateRale(bool show) => RateTheTaleView(
        show: show,
        onPressed: manager.onRatingPressed,
      );

  Widget _buildItem(
    TaleTextItem item,
    int index,
    TextScaleFactor scaleFactor,
  ) =>
      ReadTalePageItem(
        scaleFactor: scaleFactor,
        item: item,
        controller: widget.scrollController,
        index: index,
        onVisible: manager.onItemVisible,
        onInVisible: manager.onItemInvisible,
      );

  Widget _buildScrollToTopBtn() {
    Widget builder(BuildContext context, value, Widget? child) {
      final widget = !(value as bool)
          ? R.spaces.empty
          : ButtonPrimary.textWithIcon(
              R.strings.tale.scrollToStart,
              R.assets.icons.arrowUp,
              onPressed: () {
                showScrollToTopNotifier.value = false;
                this.widget.showToolbarNotifier.value = true;
                this.widget.scrollController.animateTo(
                      0,
                      duration: appScrollDuration,
                      curve: Curves.bounceInOut,
                    );
              },
            );
      return Positioned.fill(
        top: null,
        bottom: R.dimen.bottomBarWithActionsHeight + R.dimen.unit2,
        child: FadeAnimatedSwitcher.middle(child: widget),
      );
    }

    return ValueListenableBuilder(
      valueListenable: showScrollToTopNotifier,
      builder: builder,
    );
  }

  void _scrollToInitialPosition(int initialIndex) {
    try {
      if (initialPositionSet || initialIndex == 0) {
        return;
      }
      showScrollToTopNotifier.value = true;

      void scrollListener() {
        // here if we still show btn and start scroll,
        // we gonna hide it
        widget.scrollController.removeListener(scrollListener);
        Future.delayed(appScrollDuration * 3).then((value) {
          if (!mounted) return;
          showScrollToTopNotifier.value = false;
        });
      }

      postFrame(() {
        widget.hideToolbarNotifier.value = true;
        widget.scrollController
            .scrollToIndex(
          max(0, initialIndex - 1),
          duration: appScrollDuration,
          preferPosition: AutoScrollPosition.begin,
        )
            .then((value) {
          widget.scrollController.addListener(scrollListener);
          widget.scrollController.highlight(
            initialIndex,
            highlightDuration: appScrollDuration * 3,
          );
        });
      });

      // here we will hide scrollToTop btn if it is still visible
      Future.delayed(R.durations.hideScrollToTopBtnTimeout).then((value) {
        if (!mounted) return;
        showScrollToTopNotifier.value = false;
      });
    } finally {
      initialPositionSet = true;
    }
  }
}
