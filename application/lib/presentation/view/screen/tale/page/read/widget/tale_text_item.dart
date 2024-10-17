import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/settings/text_scale_factor.dart';
import 'package:mobile_app/domain/model/tale/tale_text_item.dart';
import 'package:mobile_app/domain/value_objects/image_url.dart';
import 'package:mobile_app/domain/value_objects/string_not_empty.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/tale_image.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:visibility_detector/visibility_detector.dart';

typedef VisibilityCallback = Function(int index);

class ReadTalePageItem extends StatelessWidget {
  final AutoScrollController controller;
  final TaleTextItem item;
  final int index;
  final TextScaleFactor scaleFactor;
  final VisibilityCallback onVisible;
  final VisibilityCallback onInVisible;

  const ReadTalePageItem({
    super.key,
    required this.item,
    required this.controller,
    required this.index,
    required this.scaleFactor,
    required this.onVisible,
    required this.onInVisible,
  });

  @override
  Widget build(BuildContext context) {
    final content = item.map(
      text: (e) => _buildParagraph(e.text, isFirst: index == 1),
      image: (e) => _buildImage(e.url),
    );
    final withPadding = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: R.dimen.screenPaddingSide,
        vertical: item.map(
          text: (_) => R.dimen.unit,
          image: (_) => R.dimen.unit2,
        ),
      ),
      child: content,
    );
    final key = ValueKey(index);

    final visibility = VisibilityDetector(
      key: key,
      onVisibilityChanged: (info) {
        (info.visibleFraction == 0) ? onInVisible(index) : onVisible(index);
      },
      child: withPadding,
    );

    return AutoScrollTag(
      key: key,
      controller: controller,
      index: index,
      highlightColor: R.palette.splashColor,
      child: visibility,
    );
  }

  Widget _buildParagraph(
    StringNonEmpty nonEmpty, {
    required bool isFirst,
  }) {
    final text = nonEmpty.get();
    final style = R.styles.taleText;
    const paragraph = '    ';
    if (!isFirst) {
      return Text(
        paragraph + text,
        style: style,
        textScaler: scaleFactor.value,
      );
    }
    final prefix = TextSpan(
      text: paragraph,
      style: style,
    );
    final capital = TextSpan(
      text: text.substring(0, 1),
      style: style.withNiceFont.copyWith(
        color: R.palette.accent,
        fontSize: style.fontSize! * 1.5,
      ),
    );
    final theRest = TextSpan(
      text: text.substring(1),
      style: style,
    );

    return RichText(
        textScaler: scaleFactor.value,
        text: TextSpan(
          children: [
            prefix,
            capital,
            theRest,
          ],
        ));
  }

  Widget _buildImage(ImageUrl url) => TaleImage(imageUrl: url);
}
