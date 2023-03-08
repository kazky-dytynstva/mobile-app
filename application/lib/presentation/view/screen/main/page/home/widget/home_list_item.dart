import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/home_list_item_data/home_list_item_data.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/main/page/home/widget/home_page_tale_item.dart';
import 'package:mobile_app/presentation/widget/labeled_child.dart';

typedef OnTalePressed = Function(TalesPageItemData);

class HomeListItem extends StatelessWidget {
  final HomeListItemData data;
  final bool isFirst;
  final OnTalePressed onTalePressed;
  final OnTalePressed onFavPressed;
  final OnRatingPressed onRatingPressed;

  const HomeListItem({
    required this.data,
    required this.isFirst,
    required this.onTalePressed,
    required this.onFavPressed,
    required this.onRatingPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding:
            isFirst ? EdgeInsets.zero : EdgeInsets.only(top: R.dimen.unit2),
        child: LabeledChild(
          horizontalChildPadding: 0,
          label: _getLabel(),
          labelStyle: R.styles.textSubTitle,
          child: _createListView(),
        ),
      );

  String _getLabel() => data.when(
        random: (_) => R.strings.main.homeItemsRandom,
        latest: (_) => R.strings.main.homeItemsLatest,
        bestRating: (_) => R.strings.main.homeItemsBestRating,
      );

  Widget _createListView() {
    var index = 0;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: data.tales.map((e) => _buildItem(index++)).toList(),
      ),
    );
  }

  Widget _buildItem(int index) {
    final taleItem = data.tales[index];
    final item = HomePageTaleItem(
      margin: EdgeInsets.zero,
      data: taleItem,
      onTalePressed: () => onTalePressed(taleItem),
      onFavPressed: () => onFavPressed(taleItem),
      onRatingPressed: onRatingPressed,
    );
    final isFirst = index == 0;
    final isLast = index == data.tales.length - 1;

    final sidePadding = R.dimen.screenPaddingSide;
    final itemPadding = R.dimen.unit0_5;
    final padding = EdgeInsets.only(
      left: isFirst ? sidePadding : itemPadding,
      right: isLast ? sidePadding : itemPadding,
    );
    return Padding(
      padding: padding,
      child: item,
    );
  }
}
