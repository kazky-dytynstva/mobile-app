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

  const HomeUserActionRequestItem({
    required this.actionRequest,
    required this.onCtaPressed,
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
      showItem = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final row = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [_buildCta()],
    );

    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTitle(),
        _buildMsg(),
        row,
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
      sizeDuration: R.durations.animLong,
      child: withPadding,
    );
  }

  Widget _buildCta() {
    final text = getCtaText();
    final icon = getCtaIcon();
    final btn = icon == null
        ? ButtonPrimary.text(text, onPressed: widget.onCtaPressed)
        : ButtonPrimary.textWithIcon(text, icon,
            onPressed: widget.onCtaPressed);

    return Padding(
      padding: EdgeInsets.only(top: R.dimen.unit),
      child: btn,
    );
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

  String getTitleText() => widget.actionRequest.map(
        rate: (_) => R.strings.main.userActionRequestTitleRate,
        share: (_) => R.strings.main.userActionRequestTitleShare,
        support: (_) => R.strings.main.userActionRequestTitleSupport,
        dynamic: (_) => _.itemData.title.get(),
      );

  String getMsgText() => widget.actionRequest.map(
        rate: (_) => R.strings.main.userActionRequestMessageRate,
        share: (_) => R.strings.main.userActionRequestMessageShare,
        support: (_) => R.strings.main.userActionRequestMessageSupport,
        dynamic: (_) => _.itemData.subTitleOption.fold(
          () => '',
          (stringSingleLine) => stringSingleLine.get(),
        ),
      );

  String getCtaText() => widget.actionRequest.map(
        rate: (_) => R.strings.main.userActionRequestCtaRate,
        share: (_) => R.strings.main.userActionRequestCtaShare,
        support: (_) => R.strings.main.userActionRequestCtaSupport,
        dynamic: (_) => _.itemData.cta.get(),
      );

  SvgAssetIcon? getCtaIcon() => widget.actionRequest.map(
        rate: (_) => R.assets.icons.star,
        share: (_) => R.assets.icons.share,
        support: (_) => R.assets.icons.support,
        dynamic: (_) => null,
      );
}
