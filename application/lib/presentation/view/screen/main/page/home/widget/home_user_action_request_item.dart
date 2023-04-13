import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/user_action/user_action_request.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_icon.dart';
import 'package:mobile_app/presentation/extensions/post_callback.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/animated_scale_and_fade.dart';
import 'package:mobile_app/presentation/widget/button/button_primary.dart';
import 'package:mobile_app/presentation/widget/button/button_secondary.dart';

class HomeUserActionRequestItem extends StatefulWidget {
  final UserActionRequest actionRequest;
  final VoidCallback onCtaPressed;
  final VoidCallback onHidePressed;

  const HomeUserActionRequestItem({
    required this.actionRequest,
    required this.onCtaPressed,
    required this.onHidePressed,
    Key? key,
  }) : super(key: key);

  @override
  State<HomeUserActionRequestItem> createState() =>
      _HomeUserActionRequestItemState();
}

class _HomeUserActionRequestItemState extends State<HomeUserActionRequestItem> {
  var showItem = false;

  @override
  void initState() {
    postFrame(() {
      setState(() {
        showItem = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final row = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [_buildHideButton(), R.spaces.horizontalUnit2, _buildCta()],
    );

    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTitle(),
        _buildMsg(),
        Padding(
          padding: EdgeInsets.only(top: R.dimen.unit),
          child: row,
        ),
      ],
    );

    final withPadding = Padding(
      padding: EdgeInsets.symmetric(horizontal: R.dimen.screenPaddingSide),
      child: ButtonSecondary(
        onPressed: null,
        contentPadding: EdgeInsets.all(R.dimen.screenPaddingSide),
        child: column,
      ),
    );
    return AnimatedSizeAndFade.showHide(
      show: showItem,
      fadeDuration: R.durations.animLong,
      sizeDuration: R.durations.animMiddle,
      child: withPadding,
    );
  }

  Widget _buildHideButton() => ButtonSecondary.text(
        R.strings.general.hide,
        onPressed: widget.onHidePressed,
      );

  Widget _buildCta() {
    final text = getCtaText();
    final icon = getCtaIcon();
    final btn = icon == null
        ? ButtonPrimary.text(text, onPressed: widget.onCtaPressed)
        : ButtonPrimary.textWithIcon(text, icon,
            onPressed: widget.onCtaPressed);

    return btn;
  }

  Widget _buildTitle() => Text(getTitleText(), style: R.styles.textHeadline);

  Widget _buildMsg() {
    final string = getMsgText();
    if (string.isEmpty) return R.spaces.empty;
    return Padding(
      padding: EdgeInsets.only(top: R.dimen.unit),
      child: Text(string, style: R.styles.textSubTitle),
    );
  }

  String getTitleText() => widget.actionRequest.when(
        rate: () => R.strings.main.userActionRequestTitleRate,
        share: () => R.strings.main.userActionRequestTitleShare,
        support: () => R.strings.main.userActionRequestTitleSupport,
        appUpdate: (info) => info.title.get(),
        dynamic: (item) => item.title.get(),
      );

  String getMsgText() => widget.actionRequest.when(
        rate: () => R.strings.main.userActionRequestMessageRate,
        share: () => R.strings.main.userActionRequestMessageShare,
        support: () => R.strings.main.userActionRequestMessageSupport,
        appUpdate: (info) => '',
        dynamic: (item) => item.subTitleOption.fold(
          () => '',
          (stringSingleLine) => stringSingleLine.get(),
        ),
      );

  String getCtaText() => widget.actionRequest.when(
        rate: () => R.strings.main.userActionRequestCtaRate,
        share: () => R.strings.main.userActionRequestCtaShare,
        support: () => R.strings.main.userActionRequestCtaSupport,
        appUpdate: (_) => R.strings.main.userActionRequestCtaAppUpdate,
        dynamic: (item) => item.cta.get(),
      );

  SvgAssetIcon? getCtaIcon() => widget.actionRequest.when(
        rate: () => R.assets.icons.star,
        share: () => R.assets.icons.share,
        support: () => R.assets.icons.support,
        appUpdate: (info) => null,
        dynamic: (item) => null,
      );
}
