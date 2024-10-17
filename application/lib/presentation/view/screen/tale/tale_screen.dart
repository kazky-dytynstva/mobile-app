import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/domain/model/sort_and_filter/filter_type.dart';
import 'package:mobile_app/domain/model/tale/data/tale_screen_data.dart';
import 'package:mobile_app/domain/model/tale/tale.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_name.dart';
import 'package:mobile_app/presentation/view/screen/manager_view_mixin.dart';
import 'package:mobile_app/presentation/view/screen/screen_mixin.dart';
import 'package:mobile_app/presentation/view/screen/tale/manager/tale_screen_manager.dart';
import 'package:mobile_app/presentation/view/screen/tale/page/listen/listen_page.dart';
import 'package:mobile_app/presentation/view/screen/tale/page/read/read_page.dart';
import 'package:mobile_app/presentation/view/screen/tale/widget/tale_screen_bottom_bar.dart';
import 'package:mobile_app/presentation/view/screen/tale/widget/tale_screen_toolbar.dart';
import 'package:mobile_app/presentation/widget/fade_animated_switcher.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

@RoutePage()
class TaleScreen extends StatefulWidget {
  final Tale initialTale;
  final bool openAudio;
  final TaleFilterType? filterType;

  const TaleScreen({
    required this.initialTale,
    required this.openAudio,
    required this.filterType,
    super.key,
  });

  @override
  State<TaleScreen> createState() => _TaleScreenState();
}

class _TaleScreenState extends ScreenWidgetState<TaleScreen, TaleScreenManager>
    with ManagerViewMixin {
  late final scrollController = AutoScrollController();
  late final showToolbarNotifier = ValueNotifier(false);
  late final hideToolbarNotifier = ValueNotifier(false);
  TalePageType _lastPageType = TalePageType.text;

  @override
  void initState() {
    manager.init(
      widget.initialTale,
      widget.openAudio,
      widget.filterType,
    );
    super.initState();
  }

  @override
  bool get disposeManager => false;

  @override
  void dispose() {
    scrollController.dispose();
    showToolbarNotifier.dispose();
    manager.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget stateBuilder(BuildContext context, TaleScreenState state) {
      final widget = state.map(
        initial: buildInitialState,
        ready: _buildStateReady,
      );
      return FadeAnimatedSwitcher.screen(child: widget);
    }

    return Scaffold(
      body: BlocBuilder(bloc: manager, builder: stateBuilder),
    );
  }

  Widget _buildBottomBar(TaleScreenStateReady state) => TaleScreenBottomBar(
        scrollController: scrollController,
        onActionPressed: manager.onBottomActionPressed,
        switchType: state.switchType,
        pageType: state.pageType,
        isFavorite: state.tale.isFavorite,
        hasCrew: state.tale.crewOption.isSome(),
        ratingOption: state.tale.ratingOption,
      );

  Widget _buildToolbar(TaleName taleName) => TaleToolbar(
        scrollController: scrollController,
        name: taleName,
        forceShowNotifier: showToolbarNotifier,
        forceHideNotifier: hideToolbarNotifier,
      );

  Widget _buildStateReady(TaleScreenStateReady state) {
    _showToolbarIfNeeded(state.pageType);
    final pages = [
      ReadTalePage(
        scrollController: scrollController,
        showToolbarNotifier: showToolbarNotifier,
        hideToolbarNotifier: hideToolbarNotifier,
      ),
      const ListenTalePage(),
    ];
    return Stack(
      children: [
        Positioned.fill(
            child: IndexedStack(
          index: state.pageType.index,
          children: pages,
        )),
        Positioned.fill(bottom: null, child: _buildToolbar(state.tale.name)),
        Positioned.fill(top: null, child: _buildBottomBar(state)),
      ],
    );
  }

  void _showToolbarIfNeeded(TalePageType currentPage) {
    if (_lastPageType == currentPage) {
      return;
    }
    showToolbarNotifier.value = true;
    _lastPageType = currentPage;
  }
}
