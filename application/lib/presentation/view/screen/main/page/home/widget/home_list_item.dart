import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/home_list_item_data/home_list_item_data.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/domain/model/user_action/user_action_request.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/main/page/home/widget/home_page_tale_item.dart';
import 'package:mobile_app/presentation/view/screen/main/page/home/widget/home_user_action_request_item.dart';
import 'package:mobile_app/presentation/widget/labeled_child.dart';

typedef OnTalePressed = Function(TalesPageItemData);
typedef OnUserCtaPressed = Function(UserActionRequest actionRequest);

class HomeListItem extends StatelessWidget {
  final HomeListItemData data;
  final bool isFirst;
  final OnTalePressed onTalePressed;
  final OnTalePressed onFavPressed;
  final OnRatingPressed onRatingPressed;
  final OnUserCtaPressed onUserRequestCtaPressed;
  final VoidCallback onUserRequestHidePressed;

  const HomeListItem({
    required this.data,
    required this.isFirst,
    required this.onTalePressed,
    required this.onFavPressed,
    required this.onRatingPressed,
    required this.onUserRequestCtaPressed,
    required this.onUserRequestHidePressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding:
            isFirst ? EdgeInsets.zero : EdgeInsets.only(top: R.dimen.unit2),
        child: LabeledChild(
          horizontalChildPadding: 0,
          label: _getLabel(),
          labelStyle: R.styles.textSubTitle,
          child: _buildItem(),
        ),
      );

  String _getLabel() => data.when(
        random: (_) => R.strings.main.homeItemsRandom,
        latest: (_) => R.strings.main.homeItemsLatest,
        bestRating: (_) => R.strings.main.homeItemsBestRating,
        userActionRequest: (_) => R.strings.main.homeItemsUserActionRequest,
      );

  Widget _buildItem() => data.map(
        random: (e) => _createListView(e.tales),
        latest: (e) => _createListView(e.tales),
        bestRating: (e) => _createListView(e.tales),
        userActionRequest: (e) => _buildUserActionRequest(e.actionRequest),
      );

  Widget _createListView(List<TalesPageItemData> tales) {
    var index = 0;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: tales.map((e) => _buildTaleItem(tales, index++)).toList(),
      ),
    );
  }

  Widget _buildUserActionRequest(UserActionRequest request) =>
      HomeUserActionRequestItem(
        actionRequest: request,
        onCtaPressed: () => onUserRequestCtaPressed(request),
        onHidePressed: onUserRequestHidePressed,
      );

  Widget _buildTaleItem(List<TalesPageItemData> tales, int index) {
    final taleItem = tales[index];
    final item = HomePageTaleItem(
      margin: EdgeInsets.zero,
      data: taleItem,
      onTalePressed: () => onTalePressed(taleItem),
      onFavPressed: () => onFavPressed(taleItem),
      onRatingPressed: onRatingPressed,
    );
    final isFirst = index == 0;
    final isLast = index == tales.length - 1;

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
