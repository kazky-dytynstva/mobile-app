import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/people/people_page_tab_data.dart';
import 'package:mobile_app/presentation/widget/list_of_people.dart';

typedef OnScrollPositionChanged = Function(double position);

class RolePeopleTabPage extends StatefulWidget {
  final PeoplePageTabData tabData;
  final OnPersonPressed onPersonPressed;
  final OnPersonPressed onPersonFavPressed;
  final OnScrollPositionChanged onScrollPositionChanged;

  const RolePeopleTabPage({
    required this.tabData,
    required this.onPersonPressed,
    required this.onPersonFavPressed,
    required this.onScrollPositionChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<RolePeopleTabPage> createState() => _State();
}

class _State extends State<RolePeopleTabPage> {
  late final controller = ScrollController(
    initialScrollOffset: widget.tabData.scrollPosition,
  );
  late double currentPosition = widget.tabData.scrollPosition;

  @override
  void initState() {
    controller.addListener(() {
      currentPosition = controller.offset;
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.onScrollPositionChanged(currentPosition);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PeopleList(
        peopleList: widget.tabData.peopleList,
        controller: controller,
        onPersonPressed: widget.onPersonPressed,
        onPersonFavPressed: widget.onPersonFavPressed,
      );
}
