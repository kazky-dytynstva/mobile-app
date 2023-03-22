import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/domain/model/sort_and_filter/filter_type.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/data/di/dependency_injection.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/main/page/tales/manager/tales_page_manager.dart';
import 'package:mobile_app/presentation/view/screen/main/page/tales/widget/tales_page_bottom_buttons.dart';
import 'package:mobile_app/presentation/widget/tales_page_toolbar.dart';
import 'package:mobile_app/presentation/view/screen/manager_view_mixin.dart';
import 'package:mobile_app/presentation/widget/custom_theme.dart';
import 'package:mobile_app/presentation/widget/fade_animated_switcher.dart';
import 'package:mobile_app/presentation/widget/hide_when_scroll.dart';
import 'package:mobile_app/presentation/widget/list_of_tales.dart';

class TalesPage extends StatefulWidget {
  const TalesPage({Key? key}) : super(key: key);

  @override
  State<TalesPage> createState() => _TalesPageState();
}

class _TalesPageState extends State<TalesPage>
    with
        AutomaticKeepAliveClientMixin,
        ManagerViewMixin,
        CustomThemeStatefulMixin {
  late final TalesPageManager _manager = getIt();
  late final ScrollController _scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  Duration get showBackTimeOut => R.durations.showHiddenScrolledWidget;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Widget stateBuilder(BuildContext context, TalesPageState state) {
      final widget = state.map(
        initial: buildInitialState,
        ready: _buildStateReady,
      );
      return FadeAnimatedSwitcher.screen(child: widget);
    }

    return BlocBuilder(bloc: _manager, builder: stateBuilder);
  }

  Widget _buildStateReady(TalesPageStateReady state) {
    final list = Positioned.fill(
      child: _createTalesList(state.tales, state.filterData.type),
    );
    final toolbar = Positioned.fill(
      bottom: null,
      child: _createToolbar(state),
    );
    final bottomBar = Positioned.fill(
      top: null,
      child: _createBottomButtons(),
    );
    return Stack(
      children: [
        list,
        toolbar,
        bottomBar,
      ],
    );
  }

  Widget _createToolbar(TalesPageStateReady state) {
    final toolBar = TalesPageToolbar(
      filterData: state.filterData,
      sortData: state.sortData,
    );
    return HideWhenScroll(
      controller: _scrollController,
      showBackTimeOut: showBackTimeOut,
      hideDirection: HideDirection.top,
      child: Container(
        color: R.palette.primary,
        child: SafeArea(child: toolBar),
      ),
    );
  }

  Widget _createTalesList(
    List<TalesPageItemData> tales,
    TaleFilterType filterType,
  ) =>
      ListOfTales(
        tales: tales,
        onTalePressed: _manager.onTalePressed,
        onTaleFavPressed: _manager.onTaleFavPressed,
        onRatingPressed: _manager.onRatingPressed,
        scrollController: _scrollController,
        padding: EdgeInsets.symmetric(
          vertical: R.dimen.toolbarHeight + R.dimen.statusBarHeight,
        ),
        isFavList: filterType.isFav,
      );

  Widget _createBottomButtons() {
    final buttons = TalesPageBottomButtons(
      onFilterPressed: _manager.onFilterPressed,
      onSortPressed: _manager.onSortPressed,
      onSearchPressed: _manager.onSearchPressed,
    );
    return HideWhenScroll(
      controller: _scrollController,
      showBackTimeOut: showBackTimeOut,
      child: buttons,
    );
  }
}
