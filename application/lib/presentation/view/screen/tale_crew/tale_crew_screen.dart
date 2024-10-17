import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_name.dart';
import 'package:mobile_app/domain/model/tale_crew/tale_crew.dart';
import 'package:mobile_app/domain/model/tale_crew/tale_crew_list_item.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/manager_view_mixin.dart';
import 'package:mobile_app/presentation/view/screen/screen_mixin.dart';
import 'package:mobile_app/presentation/widget/label_with_line.dart';
import 'package:mobile_app/presentation/view/screen/tale_crew/manager/tale_crew_screen_manager.dart';
import 'package:mobile_app/presentation/view/screen/tale_crew/manager/tale_crew_screen_state.dart';
import 'package:mobile_app/presentation/widget/bottom_bar_with_actions.dart';
import 'package:mobile_app/presentation/widget/person_list_item.dart';

@RoutePage()
class TaleCrewScreen extends StatefulWidget {
  final TaleName taleName;
  final TaleCrew crew;

  const TaleCrewScreen({
    required this.taleName,
    required this.crew,
    Key? key,
  }) : super(key: key);

  @override
  State<TaleCrewScreen> createState() => _State();
}

class _State extends ScreenWidgetState<TaleCrewScreen, TaleCrewScreenManager>
    with ManagerViewMixin {
  @override
  void initState() {
    manager.init(widget.crew);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder(
        bloc: manager,
        builder: _buildStateReady,
      );

  Widget _buildStateReady(_, TaleCrewScreenState state) => Scaffold(
        appBar: _buildAppBar(),
        body: _buildCrewList(state.items),
        bottomNavigationBar: BottomBarWithActions(
          onBackPressed: manager.onBackPressed,
        ),
      );

  AppBar _buildAppBar() {
    final taleName = Text(
      widget.taleName.get(),
      style: R.styles.textBody.withNiceFont,
      textAlign: TextAlign.center,
    );
    final title = Text(
      R.strings.crewRoles.taleCrewForTale,
      style: R.styles.toolbarTitle,
      textAlign: TextAlign.center,
    );
    final column = Column(
      children: [
        title,
        R.spaces.verticalUnit,
        taleName,
      ],
    );
    return AppBar(
      backgroundColor: R.palette.primary,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: column,
      toolbarHeight: R.dimen.toolbarHeightBig,
    );
  }

  Widget _buildCrewList(List<TaleCrewListItem> items) {
    final column = Column(
      children: items.map(_buildListItem).toList(),
    );
    return SingleChildScrollView(child: column);
  }

  Widget _buildListItem(TaleCrewListItem item) {
    final children = <Widget>[
      LabelWithLine(label: item.roleLabel.get()),
    ];
    children.addAll(item.people.map(_buildPerson));
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  Widget _buildPerson(Person person) => PersonListItem(
        person: person,
        onPressed: () => manager.onPersonPressed(person),
        onFavPressed: () => manager.onPersonFavPressed(person),
      );
}
