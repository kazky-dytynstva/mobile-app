import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/rating/rating_data.dart';
import 'package:mobile_app/domain/model/rating/rating_type.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_name.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_icon.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/fade_animated_switcher.dart';
import 'package:mobile_app/presentation/widget/favorite.dart';
import 'package:mobile_app/presentation/widget/rating_item.dart';
import 'package:mobile_app/presentation/widget/svg_widget.dart';
import 'package:mobile_app/presentation/widget/tale_image.dart';

typedef OnRatingPressed = Function(TaleName name, RatingData data);

class HomePageTaleItem extends StatelessWidget {
  final TalesPageItemData data;
  final VoidCallback onTalePressed;
  final VoidCallback onFavPressed;
  final OnRatingPressed onRatingPressed;
  final EdgeInsets? margin;

  const HomePageTaleItem({
    Key? key,
    required this.data,
    required this.onTalePressed,
    required this.onFavPressed,
    required this.onRatingPressed,
    this.margin,
  }) : super(key: key);

  double get _imageSize => R.dimen.taleListImageSize * 2;

  double get _buttonColumnWidth => R.dimen.unit6;

  double get _nameAndAuthorWidth => _imageSize + _buttonColumnWidth;

  @override
  Widget build(BuildContext context) {
    final row = Row(
      children: [
        _createImage(context),
        _buildIconsColumn(),
      ],
    );
    final column = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        row,
        _buildNameAndAuthor(),
      ],
    );
    return _buildWrap(column);
  }

  Widget _buildIconsColumn() {
    final column = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _buildTaleTypeItems(),
    );
    return SizedBox(
      height: _imageSize,
      width: _buttonColumnWidth,
      child: column,
    );
  }

  Widget _buildWrap(Widget child) {
    final bordered = Container(
      decoration: BoxDecoration(
        border: Border.all(color: R.palette.divider),
        borderRadius: R.styles.imageBorderRadius,
      ),
      child: Padding(
        padding: EdgeInsets.all(R.dimen.unit0_5),
        child: child,
      ),
    );

    final clickable = InkWell(
      onTap: onTalePressed,
      splashColor: R.palette.accent,
      borderRadius: R.styles.imageBorderRadius,
      child: bordered,
    );

    return Padding(
      padding: margin ??
          EdgeInsets.symmetric(
            vertical: R.dimen.unit,
            horizontal: R.dimen.screenPaddingSide,
          ),
      child: clickable,
    );
  }

  Widget _buildNameAndAuthor() {
    final nameStyle = R.styles.textSubTitle;
    const nameMaxLines = 2;
    final name = Text(
      data.name.get(),
      style: nameStyle,
      maxLines: nameMaxLines,
      overflow: TextOverflow.ellipsis,
    );
    final nameLineHeight = (nameStyle.fontSize ?? 0) * (nameStyle.height ?? 1);
    final nameSized = SizedBox(
      height: nameLineHeight * nameMaxLines,
      child: name,
    );

    final author = Text(
      data.provider.get(),
      style: R.styles.textCaption,
      maxLines: 1,
    );

    final column = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        nameSized,
        R.spaces.verticalUnit,
        author,
      ],
    );
    return SizedBox(
      width: _nameAndAuthorWidth,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: R.dimen.unit,
          horizontal: R.dimen.unit0_5,
        ),
        child: column,
      ),
    );
  }

  Widget _buildFavWidget() => Favorite(
        onPressed: onFavPressed,
        isFav: data.isFav,
        asFab: false,
      );

  Widget _buildRating() {
    Widget build(RatingData? ratingData) {
      final isVisible = ratingData != null;
      final opacity = isVisible ? 0.6 : 0.0;
      final onPressed =
          isVisible ? () => onRatingPressed(data.name, ratingData) : () {};
      return Opacity(
        opacity: opacity,
        child: RatingItemButton(
          type: ratingData?.type ?? RatingType.terrible,
          onPressed: onPressed,
          asFab: false,
        ),
      );
    }

    final child = data.optionRating.fold(
      () => build(null),
      build,
    );
    return FadeAnimatedSwitcher.middle(child: child);
  }

  Widget _createImage(BuildContext context) => TaleImage(
        imageUrl: data.imageUrl,
        width: _imageSize,
        height: _imageSize,
        radius: R.styles.imageBorderRadiusSmall,
      );

  List<Widget> _buildTaleTypeItems() {
    final size = R.dimen.unit2;
    final space = SizedBox.square(dimension: size);
    final halfSpace = SizedBox.square(dimension: size / 2);

    SvgWidget getIcon(SvgAssetIcon icon) => SvgWidget.icon(
          icon,
          width: size,
          height: size,
          color: R.palette.iconColorDisabled,
        );

    Widget buildIsCached() => FutureBuilder<bool>(
        future: data.isCached,
        builder: (_, snapshot) {
          final result =
              snapshot.data == true ? getIcon(R.assets.icons.save) : space;
          return FadeAnimatedSwitcher.short(child: result);
        });

    return <Widget>[
      _buildFavWidget(),
      _buildRating(),
      halfSpace,
      data.hasText ? getIcon(R.assets.icons.text) : space,
      halfSpace,
      data.hasAudio ? getIcon(R.assets.icons.audio) : space,
      data.hasAudio ? buildIsCached() : space,
    ];
  }
}
