import 'package:flutter/material.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/svg_widget.dart';

class EmptyListView extends StatelessWidget {
  final bool _isFavTales;
  final bool _isFavPeople;
  final bool _isSearchList;

  const EmptyListView.filter({
    bool isFavTales = false,
    bool isFavPeople = false,
    Key? key,
  })  : assert(isFavTales || isFavPeople),
        _isFavTales = isFavTales,
        _isFavPeople = isFavPeople,
        _isSearchList = false,
        super(key: key);

  const EmptyListView.search({
    Key? key,
  })  : _isSearchList = true,
        _isFavTales = false,
        _isFavPeople = false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final child = _buildChild();
    final withPadding = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: R.dimen.screenPaddingSide,
        vertical: R.dimen.unit2,
      ),
      child: child,
    );
    return Center(child: withPadding);
  }

  Widget _buildChild() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIcon(),
          R.spaces.verticalUnit2,
          _buildText(),
        ],
      );

  Widget _buildText() {
    final String text = _isSearchList
        ? R.strings.searchTale.searchNoResults
        : _isFavTales
            ? R.strings.general.emptyListFavTales
            : _isFavPeople
                ? R.strings.general.emptyListFavPeople
                : R.strings.general.emptyList;

    return Text(
      text,
      style: R.styles.textSubTitleSecondary.withNiceFont,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildIcon() => SvgWidget.graphic(
        R.assets.graphics.upset,
        width: R.dimen.unit9,
      );
}
