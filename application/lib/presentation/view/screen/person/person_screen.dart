import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/domain/model/person/person_tales_tab_data.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_name.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/domain/value_objects/url_string.dart';
import 'package:mobile_app/data/di/dependency_injection.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/manager_view_mixin.dart';
import 'package:mobile_app/presentation/view/screen/person/manager/person_screen_manager.dart';
import 'package:mobile_app/presentation/view/screen/person/widget/person_screen_bottom_bar.dart';
import 'package:mobile_app/presentation/view/screen/person/widget/person_tabs_delegate.dart';
import 'package:mobile_app/presentation/widget/fade_animated_switcher.dart';
import 'package:mobile_app/presentation/widget/list_of_tales.dart';
import 'package:mobile_app/presentation/widget/person_avatar.dart';
import 'package:mobile_app/presentation/widget/url_preview.dart';

class PersonScreen extends StatefulWidget {
  final Person person;

  const PersonScreen({
    required this.person,
    Key? key,
  }) : super(key: key);

  @override
  State<PersonScreen> createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen>
    with ManagerViewMixin, SingleTickerProviderStateMixin {
  late final _manager = getIt<PersonScreenManager>()..init(widget.person.id);
  TabController? tabController;

  @override
  void dispose() {
    _manager.close();
    tabController?.dispose();
    super.dispose();
  }

  Widget get sectionSpacer => R.spaces.verticalUnit2;

  @override
  Widget build(BuildContext context) {
    Widget stateBuilder(BuildContext context, PersonScreenState state) {
      final widget = state.map(
        initial: buildInitialState,
        ready: _buildStateReady,
      );
      return FadeAnimatedSwitcher.screen(child: widget);
    }

    return Scaffold(
      body: BlocBuilder(bloc: _manager, builder: stateBuilder),
    );
  }

  Widget _buildStateReady(PersonScreenStateReady state) {
    tabController ??= TabController(
      length: state.tabDataList.length,
      vsync: this,
    );
    List<Widget> getSlivers() => [
          _getAvatarAndNameSliver(state.person),
          SliverToBoxAdapter(child: R.spaces.verticalUnit2),
          _buildInfoSection(state.person.infoOption),
          _buildPagePreview(state.person.pageOption),
          _buildTabs(state.tabDataList),
        ];
    final nested = NestedScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      headerSliverBuilder: (_, __) => getSlivers(),
      body: _buildViewPager(state.tabDataList),
    );

    final bottomBar = PersonScreenBottomBar(
      onActionPressed: _manager.onBottomActionPressed,
      isFavorite: state.person.isFavorite,
    );
    return Stack(
      children: [
        Positioned.fill(child: nested),
        Positioned.fill(top: null, child: bottomBar),
      ],
    );
  }

  Widget _getAvatarAndNameSliver(Person person) => SliverPadding(
        padding: EdgeInsets.only(top: R.dimen.notchHeight),
        sliver: SliverAppBar(
          backgroundColor: R.palette.background,
          pinned: true,
          expandedHeight: R.dimen.personAvatarBigHeight,
          automaticallyImplyLeading: false,
          flexibleSpace: FlexibleSpaceBar(
            title: _buildName(person.name),
            titlePadding: EdgeInsets.zero,
            background: _buildAvatar(person),
          ),
        ),
      );

  Widget _buildInfoSection(Option<StringSingleLine> personInfoOption) {
    final child = personInfoOption.fold(
      () => null,
      (info) => Text(
        info.get(),
        textAlign: TextAlign.center,
        style: R.styles.textSubTitle,
      ).withSideAndBottomPadding,
    );
    return SliverToBoxAdapter(child: child);
  }

  Widget _buildTabs(tabDataList) => SliverPersistentHeader(
        pinned: true,
        delegate: PersonTabsDelegate(
          tabDataList.toList(),
          tabController!,
        ),
      );

  Widget _buildAvatar(Person person) => PersonAvatar(
        photoUrl: person.photoUrl,
        width: R.dimen.personAvatarBigWidth,
        height: R.dimen.personAvatarBigHeight,
        withRoundedCorners: false,
      );

  Widget _buildName(PersonName name) {
    final withPadding = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: R.dimen.screenPaddingSide,
      ),
      child: Text(
        name.get(),
        textAlign: TextAlign.center,
        style: R.styles.textHeadline.withNiceFont,
      ),
    );

    return Container(
      height: R.dimen.toolbarHeight,
      decoration: BoxDecoration(color: R.palette.personAvatarBoxShadow),
      child: Center(child: withPadding),
    );
  }

  Widget _buildPagePreview(Option<UrlString> pageOption) {
    final child = pageOption.fold(
      () => null,
      (url) => UrlPreview(
        url: url,
        onPressed: () => _manager.onUrlPressed(url),
      ).withSideAndBottomPadding,
    );
    return SliverToBoxAdapter(child: child);
  }

  Widget _buildViewPager(List<PersonTalesTabData> tabDataList) {
    if (tabDataList.isEmpty) return R.spaces.empty;

    final pages = tabDataList
        .map(
          (tabData) => ListOfTales(
            padding:
                EdgeInsets.only(bottom: R.dimen.bottomBarWithActionsHeight),
            tales: tabData.tales,
            onTalePressed: _manager.onTalePressed,
            onTaleFavPressed: _manager.onTaleFavPressed,
            onRatingPressed: _manager.onRatingPressed,
          ),
        )
        .toList();
    return TabBarView(
      controller: tabController,
      children: pages,
    );
  }
}

extension _WidgetWithSidePadding on Widget {
  /// We need this one, cos we do not want padding for image,
  /// but for all others
  Widget get withSideAndBottomPadding => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: R.dimen.screenPaddingSide,
          vertical: R.dimen.unit,
        ),
        child: this,
      );
}
