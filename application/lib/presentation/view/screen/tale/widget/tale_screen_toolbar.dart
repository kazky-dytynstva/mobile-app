import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_name.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/hide_when_scroll.dart';

class TaleToolbar extends StatelessWidget {
  final TaleName name;
  final ScrollController scrollController;
  final ValueNotifier<bool> forceShowNotifier;
  final ValueNotifier<bool> forceHideNotifier;

  const TaleToolbar({
    required this.scrollController,
    required this.name,
    required this.forceShowNotifier,
    required this.forceHideNotifier,
    super.key,
  });

  double get _height => R.dimen.taleToolbarHeight;

  @override
  Widget build(BuildContext context) {
    final appBar = Container(
      color: R.palette.primary,
      height: _height,
      child: Padding(
          padding: EdgeInsets.only(top: R.dimen.statusBarHeight),
          child: _buildItems()),
    );
    return HideWhenScroll(
      controller: scrollController,
      hideDirection: HideDirection.top,
      forceShowNotifier: forceShowNotifier,
      forceHideNotifier: forceHideNotifier,
      child: appBar,
    );
  }

  Widget _buildItems() {
    final title = Text(
      name.get(),
      style: R.styles.textHeadline.withNiceFont,
      maxLines: 2,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: R.dimen.screenPaddingSide),
      child: Center(child: title),
    );
  }
}
