import 'package:dartz/dartz.dart' as d;
import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/animated_scale_and_fade.dart';
import 'package:mobile_app/presentation/widget/button/button_primary.dart';
import 'package:mobile_app/presentation/widget/button/button_secondary.dart';
import 'package:mobile_app/presentation/widget/fade_animated_switcher.dart';
import 'package:mobile_app/presentation/widget/tale_image.dart';

typedef OnTalePressed = Function(TalesPageItemData tale);

class CurrentPlayingAudio extends StatefulWidget {
  final d.Option<TalesPageItemData> playingTaleOption;
  final VoidCallback onStopPressed;
  final OnTalePressed onTalePressed;

  const CurrentPlayingAudio({
    required this.playingTaleOption,
    required this.onStopPressed,
    required this.onTalePressed,
    super.key,
  });

  @override
  State<CurrentPlayingAudio> createState() => _CurrentPlayingAudioState();
}

class _CurrentPlayingAudioState extends State<CurrentPlayingAudio> {
  TalesPageItemData? _tale;

  @override
  void didUpdateWidget(covariant CurrentPlayingAudio oldWidget) {
    if (oldWidget.playingTaleOption != widget.playingTaleOption) {
      widget.playingTaleOption.fold(() => null, (tale) {
        _tale = tale;
      });
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final item = _buildItem(_tale);
    return AnimatedSizeAndFade.showHide(
      show: widget.playingTaleOption.isSome(),
      fadeDuration: R.durations.animMiddle,
      sizeDuration: R.durations.animMiddle,
      child: item,
    );
  }

  Widget _buildItem(TalesPageItemData? tale) {
    if (tale == null) return R.spaces.empty;
    final row = Row(
      key: ValueKey(tale.id),
      children: [
        _buildImage(tale),
        R.spaces.horizontalUnit2,
        Expanded(child: _buildName(tale)),
        _buildStopBtn(),
      ],
    );
    final animated = FadeAnimatedSwitcher.middle(child: row);
    final btn = ButtonSecondary(
      onPressed: () => widget.onTalePressed(tale),
      fixedMaxHeight: true,
      contentPadding: EdgeInsets.symmetric(
        horizontal: R.dimen.screenPaddingSide,
        vertical: R.dimen.unit,
      ),
      child: animated,
    );
    final withPadding = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: R.dimen.screenPaddingSide / 2,
        vertical: R.dimen.unit0_5,
      ),
      child: btn,
    );
    return SizedBox(
      height: R.dimen.toolbarHeightBig,
      child: withPadding,
    );
  }

  Widget _buildStopBtn() => SizedBox.square(
        dimension: R.dimen.toolbarHeight * 0.8,
        child: ButtonPrimary.icon(
          R.assets.icons.audioStop,
          onPressed: widget.onStopPressed,
        ),
      );

  Widget _buildImage(TalesPageItemData tale) => AspectRatio(
        aspectRatio: 1,
        child: TaleImage(
          imageUrl: tale.imageUrl,
        ),
      );

  Widget _buildName(TalesPageItemData tale) => Text(
        tale.name.get(),
        style: R.styles.textSubTitle.withNiceFont,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );
}
