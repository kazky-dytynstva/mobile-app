import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/presentation/widget/empty_list_view.dart';
import 'package:mobile_app/presentation/widget/fade_animated_switcher.dart';
import 'package:mobile_app/presentation/widget/person_list_item.dart';

typedef OnPersonPressed = Function(Person person);

class PeopleList extends StatelessWidget {
  final List<Person> peopleList;
  final OnPersonPressed onPersonPressed;
  final OnPersonPressed onPersonFavPressed;
  final ScrollController? controller;

  const PeopleList({
    required this.peopleList,
    required this.onPersonPressed,
    required this.onPersonFavPressed,
    this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final child = peopleList.isEmpty
        ? const EmptyListView.filter(isFavPeople: true)
        : ListView.builder(
            controller: controller,
            itemBuilder: (_, int index) {
              final person = peopleList[index];
              return PersonListItem(
                person: person,
                onPressed: () => onPersonPressed(person),
                onFavPressed: () => onPersonFavPressed(person),
              );
            },
            itemCount: peopleList.length,
          );
    return FadeAnimatedSwitcher.middle(child: child);
  }
}
