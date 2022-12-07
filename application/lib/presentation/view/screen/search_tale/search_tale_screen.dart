import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/manager_view_mixin.dart';
import 'package:mobile_app/presentation/view/screen/screen_mixin.dart';
import 'package:mobile_app/presentation/view/screen/search_tale/manager/search_tale_manager.dart';
import 'package:mobile_app/presentation/view/screen/search_tale/widget/edit_search.dart';
import 'package:mobile_app/presentation/widget/bottom_bar_with_actions.dart';
import 'package:mobile_app/presentation/widget/divider.dart';
import 'package:mobile_app/presentation/widget/fade_animated_switcher.dart';
import 'package:mobile_app/presentation/widget/list_of_tales.dart';

import 'widget/search_tale_example.dart';

class SearchTaleScreen extends StatefulWidget {
  const SearchTaleScreen({Key? key}) : super(key: key);

  @override
  State<SearchTaleScreen> createState() => _SearchTaleScreenState();
}

class _SearchTaleScreenState
    extends ScreenWidgetState<SearchTaleScreen, SearchTaleManager>
    with ManagerViewMixin {
  @override
  Widget build(BuildContext context) {
    Widget stateBuilder(BuildContext context, SearchTaleState state) {
      final widget = state.map(
        init: buildInitialState,
        ready: _buildStateReady,
      );
      return FadeAnimatedSwitcher.screen(child: widget);
    }

    final bloc = BlocBuilder(
      bloc: manager,
      builder: stateBuilder,
    );
    return Scaffold(body: bloc);
  }

  Widget _buildStateReady(SearchTaleStateReady state) => Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(state),
      );

  AppBar _buildAppBar() => AppBar(
        backgroundColor: R.palette.primary,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          R.strings.searchTale.searchTitle,
          style: R.styles.toolbarTitle,
        ),
        toolbarHeight: R.dimen.toolbarHeight,
      );

  Widget _buildEditText(
    Option<StringSingleLine> searchPhraseOption,
  ) =>
      SizedBox(
        width: R.dimen.screenWidth / 5 * 3,
        child: EditSearch(
          onSearchChanged: manager.onSearchChanged,
          searchOption: searchPhraseOption,
        ),
      );

  Widget _buildBody(SearchTaleStateReady state) {
    final list = _buildList(state);
    final search = _buildEditText(state.searchPhraseOption);

    final bottomBar = Container(
      color: R.palette.background,
      child: BottomBarWithActions(
        onBackPressed: manager.onBackPressed,
        items: [search],
      ),
    );

    return Stack(
      children: [
        Positioned.fill(child: list),
        Positioned.fill(
          top: null,
          bottom: R.dimen.bottomBarWithActionsHeight,
          child: const AppDivider(padding: EdgeInsets.zero),
        ),
        Positioned.fill(top: null, child: bottomBar),
      ],
    );
  }

  Widget _buildList(SearchTaleStateReady state) {
    late final Widget child;
    if (state.results.isEmpty && state.searchPhraseOption.isNone()) {
      child = SearchTaleExample(
        state.taleName,
        state.authorName,
        onTextPressed: manager.onSuggestionPressed,
      );
    } else {
      child = ListOfTales(
        padding: EdgeInsets.only(bottom: R.dimen.bottomBarWithActionsHeight),
        tales: state.results,
        searchPhraseOption: state.searchPhraseOption,
        onTalePressed: manager.onTalePressed,
        onTaleFavPressed: manager.onFavPressed,
        onRatingPressed: manager.onRatingPressed,
      );
    }
    return FadeAnimatedSwitcher.middle(child: child);
  }
}
