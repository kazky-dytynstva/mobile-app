import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/rating/rating_data.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_name.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_icon.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/fade_animated_switcher.dart';
import 'package:mobile_app/presentation/widget/favorite.dart';
import 'package:mobile_app/presentation/widget/rating_item.dart';
import 'package:mobile_app/presentation/widget/svg_widget.dart';
import 'package:mobile_app/presentation/widget/tale_image.dart';

typedef OnRatingPressed = Function(TaleName name, RatingData data);

class TalesListItem extends StatelessWidget {
  final TalesPageItemData data;
  final VoidCallback onTalePressed;
  final VoidCallback onFavPressed;
  final OnRatingPressed onRatingPressed;
  final EdgeInsets? margin;
  final Option<StringSingleLine> searchPhraseOption;

  const TalesListItem({
    Key? key,
    required this.data,
    required this.onTalePressed,
    required this.onFavPressed,
    required this.onRatingPressed,
    this.margin,
    this.searchPhraseOption = const None(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final row = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _createImage(context),
        R.spaces.horizontalUnit2,
        _createNameAndAuthorWidget(),
      ],
    );

    return _buildWrap(row);
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

    final stack = Stack(
      children: [
        clickable,
        Positioned(
          top: 0,
          right: 0,
          child: _buildFavWidget(),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: _buildRating(),
        )
      ],
    );

    return Padding(
      padding: margin ??
          EdgeInsets.symmetric(
            vertical: R.dimen.unit,
            horizontal: R.dimen.screenPaddingSide,
          ),
      child: stack,
    );
  }

  Widget _createNameAndAuthorWidget() {
    final name = _SearchableText(
      text: data.name.get(),
      style: R.styles.textSubTitle,
      maxLines: 2,
      searchPhraseOption: searchPhraseOption,
    );
    final author = _SearchableText(
      text: data.provider.get(),
      style: R.styles.textBody,
      maxLines: 1,
      searchPhraseOption: searchPhraseOption,
    );

    final column = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        name,
        R.spaces.expanded,
        author,
        R.spaces.expanded,
        _buildTaleTypeRow(),
      ],
    );

    final sized = SizedBox(
      height: R.dimen.taleListImageSize,
      child: column,
    );
    return Expanded(
        child: Padding(
      padding: EdgeInsets.only(right: R.dimen.unit6),
      child: sized,
    ));
  }

  Widget _buildFavWidget() => Padding(
        padding: EdgeInsets.all(R.dimen.unit0_5),
        child: Favorite(
          onPressed: onFavPressed,
          isFav: data.isFav,
          asFab: false,
        ),
      );

  Widget _buildRating() {
    final child = data.optionRating.fold(
      () => R.spaces.empty,
      (ratindData) => Opacity(
        opacity: 0.6,
        child: RatingItemButton(
          type: ratindData.type,
          onPressed: () => onRatingPressed(data.name, ratindData),
          asFab: false,
        ),
      ),
    );
    return Padding(
      padding: EdgeInsets.all(R.dimen.unit0_5),
      child: FadeAnimatedSwitcher.middle(child: child),
    );
  }

  Widget _createImage(BuildContext context) => TaleImage(
        imageUrl: data.imageUrl,
        width: R.dimen.taleListImageSize,
        height: R.dimen.taleListImageSize,
        radius: R.styles.imageBorderRadiusSmall,
      );

  Widget _buildTaleTypeRow() {
    final size = R.dimen.unit2;
    final space = SizedBox.square(dimension: size);
    final spaceHalf = SizedBox.square(dimension: size / 2);

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

    final children = <Widget>[
      data.hasText ? getIcon(R.assets.icons.text) : space,
      space,
      space,
      data.hasAudio ? getIcon(R.assets.icons.audio) : space,
      spaceHalf,
      data.hasAudio ? buildIsCached() : space,
    ];

    return Row(children: children);
  }
}

class _SearchableText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final int maxLines;
  final Option<StringSingleLine> searchPhraseOption;

  const _SearchableText({
    required this.text,
    required this.style,
    required this.maxLines,
    required this.searchPhraseOption,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => searchPhraseOption.fold(
        _buildText,
        _buildSearchableText,
      );

  Widget _buildText() => Text(
        text,
        style: style,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
      );

  Widget _buildSearchableText(StringSingleLine phrase) {
    final searchPart = phrase.get();
    if (searchPart.isEmpty || !text.toLowerCase().contains(searchPart)) {
      return _buildText();
    }

    final List<TextSpan> spans = [];

    final startIndex = text.toLowerCase().indexOf(searchPart);
    final endIndex = startIndex + searchPart.length;

    if (startIndex > 0) {
      final prefix = text.substring(0, startIndex);
      final span = TextSpan(text: prefix, style: style);
      spans.add(span);
    }

    final accentStyle = style.copyWith(
      color: R.palette.accent,
      fontWeight: FontWeight.bold,
    );
    final active = text.substring(startIndex, endIndex);
    final span = TextSpan(text: active, style: accentStyle);
    spans.add(span);

    final lastIndex = text.length;
    if (lastIndex > endIndex) {
      final postFix = text.substring(endIndex, lastIndex);
      final span = TextSpan(text: postFix, style: style);
      spans.add(span);
    }
    return RichText(text: TextSpan(children: spans));
  }
}
