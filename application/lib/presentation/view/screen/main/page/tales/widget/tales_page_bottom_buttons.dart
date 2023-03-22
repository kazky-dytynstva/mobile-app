import 'package:flutter/material.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_icon.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/background_shadow.dart';
import 'package:mobile_app/presentation/widget/button/fab.dart';

class TalesPageBottomButtons extends StatelessWidget {
  final VoidCallback onFilterPressed;
  final VoidCallback onSortPressed;
  final VoidCallback onSearchPressed;

  const TalesPageBottomButtons({
    Key? key,
    required this.onFilterPressed,
    required this.onSortPressed,
    required this.onSearchPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final row = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _createFilter(),
        _createSort(),
        _createSearch(),
      ],
    );
    return BackgroundShadow(
      height: R.dimen.toolbarHeight + R.dimen.unit,
      child: row,
    );
  }

  Widget _createSearch() => _createBtn(
        R.assets.icons.search,
        onSearchPressed,
      );

  Widget _createFilter() => _createBtn(
        R.assets.icons.filter,
        onFilterPressed,
      );

  Widget _createSort() => _createBtn(
        R.assets.icons.sort,
        onSortPressed,
      );

  Widget _createBtn(SvgAssetIcon icon, VoidCallback onPressed) {
    final fab = Fab.icon(
      icon,
      onPressed: onPressed,
      mini: true,
    );
    return Padding(
      padding: EdgeInsets.only(right: R.dimen.unit3),
      child: fab,
    );
  }
}
