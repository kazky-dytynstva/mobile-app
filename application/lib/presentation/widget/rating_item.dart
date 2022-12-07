import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/rating/rating_type.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_graphic.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/button/fab.dart';
import 'package:mobile_app/presentation/widget/svg_widget.dart';

class RatingItem extends StatelessWidget {
  final RatingType type;
  final double? size;

  const RatingItem({
    required this.type,
    this.size,
    Key? key,
  }) : super(key: key);

  SvgAssetGraphic get graphic {
    switch (type) {
      case RatingType.awesome:
        return R.assets.graphics.faceAwesome;
      case RatingType.like:
        return R.assets.graphics.faceLike;
      case RatingType.moderate:
        return R.assets.graphics.faceModerate;
      case RatingType.dislike:
        return R.assets.graphics.faceDislike;
      case RatingType.terrible:
        return R.assets.graphics.faceAngry;
    }
  }

  double get _size => size ?? R.dimen.ratingIconSmall;

  @override
  Widget build(BuildContext context) => SvgWidget.graphic(
        graphic,
        width: _size,
        height: _size,
      );
}

class RatingItemButton extends StatelessWidget {
  final RatingType type;
  final VoidCallback onPressed;
  final bool asFab;

  const RatingItemButton({
    required this.type,
    required this.onPressed,
    this.asFab = true,
    Key? key,
  }) : super(key: key);

  double get _iconSize => R.dimen.iconSize;

  @override
  Widget build(BuildContext context) {
    final padding = Padding(
      padding: EdgeInsets.all(R.dimen.unit),
      child: RatingItem(type: type, size: _iconSize),
    );
    return asFab
        ? Fab(
            padding,
            onPressed: onPressed,
            mini: true,
          )
        : InkWell(
            borderRadius: BorderRadius.all(Radius.circular(_iconSize)),
            onTap: onPressed,
            child: padding,
          );
  }
}
