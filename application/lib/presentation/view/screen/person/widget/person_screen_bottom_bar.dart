import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/people/person_bottom_bar_action.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/bottom_bar_with_actions.dart';
import 'package:mobile_app/presentation/widget/favorite.dart';

typedef OnActionPressed = Function(PersonBottomBarAction action);

class PersonScreenBottomBar extends StatelessWidget {
  final OnActionPressed onActionPressed;
  final bool isFavorite;

  const PersonScreenBottomBar({
    required this.onActionPressed,
    required this.isFavorite,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      _buildFav(),
    ].toList(growable: false);
    return BottomBarWithActions(
      itemsAlignment: MainAxisAlignment.end,
      onBackPressed: () => onActionPressed(PersonBottomBarAction.back),
      items: items,
    );
  }

  Widget _buildFav() => Padding(
        padding: EdgeInsets.only(right: R.dimen.screenPaddingSide),
        child: Favorite(
          onPressed: () => onActionPressed(PersonBottomBarAction.fav),
          isFav: isFavorite,
          mini: true,
        ),
      );
}
