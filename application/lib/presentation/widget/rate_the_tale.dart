import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/rating/rating_type.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/animated_scale_and_fade.dart';
import 'package:mobile_app/presentation/widget/rating_item.dart';

typedef OnRatingPressed = Function(RatingType type);

class RateTheTaleView extends StatelessWidget {
  final bool show;
  final OnRatingPressed onPressed;

  const RateTheTaleView({
    required this.show,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final column = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTitle(),
        _buildRowWithButtons(),
      ],
    );
    final sized = SizedBox(
      height: R.dimen.rateTaleHeight,
      width: R.dimen.screenWidth,
      child: Center(child: column),
    );

    return _animated(sized);
  }

  Widget _buildTitle() => Text(
        'Будь ласка, оцініть твір',
        style: R.styles.textBody.copyWith(color: R.palette.accent).withNiceFont,
      );

  Widget _buildRowWithButtons() => Row(
        mainAxisSize: MainAxisSize.min,
        children: RatingType.values.reversed.map(_buildItem).toList(),
      );

  Widget _buildItem(RatingType type) => Padding(
        padding: EdgeInsets.symmetric(horizontal: R.dimen.unit0_5),
        child: RatingItemButton(
          type: type,
          asFab: false,
          onPressed: () => onPressed(type),
        ),
      );

  Widget _animated(Widget child) => AnimatedSizeAndFade.showHide(
        show: show,
        fadeDuration: R.durations.animMiddle,
        sizeDuration: R.durations.animMiddle,
        child: child,
      );
}
