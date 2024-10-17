import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/rating/rating_data.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_icon.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/domain/model/tale/data/tale_screen_data.dart';
import 'package:mobile_app/presentation/view/screen/tale/page/read/read_page.dart';
import 'package:mobile_app/presentation/view/screen/tale/page/read/widget/read_tale_page_scroll_progress.dart';
import 'package:mobile_app/presentation/widget/bottom_bar_with_actions.dart';
import 'package:mobile_app/presentation/widget/button/fab.dart';
import 'package:mobile_app/presentation/widget/fade_animated_switcher.dart';
import 'package:mobile_app/presentation/widget/favorite.dart';
import 'package:mobile_app/presentation/widget/rating_item.dart';

typedef OnActionPressed = Function(TaleBottomBarAction action);

class TaleScreenBottomBar extends StatelessWidget {
  final ScrollController scrollController;
  final OnActionPressed onActionPressed;
  final bool isFavorite;
  final Option<RatingData> ratingOption;
  final TaleSwitchType switchType;
  final TalePageType pageType;
  final bool hasCrew;

  const TaleScreenBottomBar({
    required this.scrollController,
    required this.onActionPressed,
    required this.isFavorite,
    required this.switchType,
    required this.pageType,
    required this.hasCrew,
    required this.ratingOption,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      _buildTextAudioSwitch(),
      if (ratingOption.isSome()) _buildRating((ratingOption as Some).value),
      if (hasCrew) _buildCrew(),
      _buildFav(),
      _buildMore(),
    ].toList(growable: false);
    final bar = BottomBarWithActions(
      itemsAlignment: MainAxisAlignment.end,
      onBackPressed: () => onActionPressed(TaleBottomBarAction.back),
      items: items,
    );
    return Stack(
      children: [
        bar,
        _buildProgress(),
      ],
    );
  }

  Widget _buildMore() => _buildItem(
        R.assets.icons.more,
        () => onActionPressed(TaleBottomBarAction.more),
      );

  Widget _buildCrew() => _buildItem(
        R.assets.icons.talesCrew,
        () => onActionPressed(TaleBottomBarAction.crew),
      );

  Widget _buildRating(RatingData data) => RatingItemButton(
        type: data.type,
        onPressed: () => onActionPressed(TaleBottomBarAction.rating),
      );

  Widget _buildFav() => Favorite(
        onPressed: () => onActionPressed(TaleBottomBarAction.fav),
        isFav: isFavorite,
        mini: true,
      );

  Widget _buildTextAudioSwitch() {
    void action() => onActionPressed(TaleBottomBarAction.change);
    switch (switchType) {
      case TaleSwitchType.none:
        return R.spaces.empty;
      case TaleSwitchType.text:
        return _buildItem(R.assets.icons.text, action);
      case TaleSwitchType.audio:
        return _buildItem(R.assets.icons.audio, action);
    }
  }

  Widget _buildItem(
    SvgAssetIcon icon,
    VoidCallback onPressed, {
    bool accentIconColor = false,
  }) =>
      Fab.icon(
        icon,
        onPressed: onPressed,
        mini: true,
        iconColor: accentIconColor ? R.palette.accent : null,
      );

  /// this one is for [ReadTalePage]
  /// cos we need to show it on top of the shadow :)
  Widget _buildProgress() {
    late final Widget child;
    switch (pageType) {
      case TalePageType.text:
        child = Opacity(
          opacity: 0.8,
          child: ReadTalePageScrollProgress(scrollController: scrollController),
        );
        break;
      case TalePageType.audio:
        child = R.spaces.empty;
        break;
    }
    return Positioned.fill(
      top: null,
      child: FadeAnimatedSwitcher.screen(child: child),
    );
  }
}
