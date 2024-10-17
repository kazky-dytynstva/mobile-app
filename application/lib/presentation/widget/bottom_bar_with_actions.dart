import 'package:flutter/material.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/background_shadow.dart';
import 'package:mobile_app/presentation/widget/button/fab.dart';

class BottomBarWithActions extends StatelessWidget {
  final VoidCallback? onBackPressed;
  final List<Widget> items;
  final MainAxisAlignment itemsAlignment;

  const BottomBarWithActions({
    this.items = const [],
    this.onBackPressed,
    this.itemsAlignment = MainAxisAlignment.spaceEvenly,
    super.key,
  }) : assert(onBackPressed != null || items.length > 0);

  @override
  Widget build(BuildContext context) {
    final row = Row(
      children: [
        _buildBackBtn(),
        Expanded(child: _buildItems()),
      ],
    );
    final sized = SizedBox(
      height: R.dimen.bottomBarWithActionsHeight,
      child: Padding(
        padding: EdgeInsets.only(bottom: R.dimen.bottomNotchHeight),
        child: row,
      ),
    );
    final withPadding = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: R.dimen.screenPaddingSide,
      ),
      child: sized,
    );
    return BackgroundShadow(child: withPadding);
  }

  Row _buildItems() => Row(
        mainAxisAlignment: itemsAlignment,
        children: items,
      );

  Widget _buildBackBtn() {
    return onBackPressed == null
        ? R.spaces.empty
        : Padding(
            padding: EdgeInsets.only(right: R.dimen.unit),
            child: Fab.icon(
              R.assets.icons.arrowLeft,
              onPressed: onBackPressed!,
              iconColor: R.palette.iconColor,
            ),
          );
  }
}
