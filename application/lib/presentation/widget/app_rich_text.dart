import 'package:flutter/material.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:super_rich_text/super_rich_text.dart';

enum RichMarker {
  accent('_a_'),
  bold('_b_'),
  italic('_i_');

  final String value;

  const RichMarker(this.value);
}

class AppRichText extends StatelessWidget {
  final String _text;
  final TextStyle? _style;
  final TextAlign _align;
  final RichMarker? _clickableMarker;
  final List<VoidCallback> _callbacks;

  AppRichText(
    this._text, {
    TextStyle? style,
    TextAlign align = TextAlign.start,
    super.key,
  })  : _style = style,
        _align = align,
        _clickableMarker = null,
        _callbacks = [];

  AppRichText.clickable(
    this._text, {
    required List<VoidCallback> callbacks,
    RichMarker clickableMarker = RichMarker.accent,
    TextStyle? style,
    TextAlign align = TextAlign.start,
    super.key,
  })  : assert(callbacks.isNotEmpty),
        _style = style,
        _align = align,
        _clickableMarker = clickableMarker,
        _callbacks = callbacks;

  TextStyle get _textStyle => _style ?? R.styles.textBody;

  @override
  Widget build(BuildContext context) => SuperRichText(
        text: _text,
        style: _textStyle,
        textAlign: _align,
        useGlobalMarkers: false,
        othersMarkers: _getMarkedTextList(),
      );

  List<MarkerText> _getMarkedTextList() {
    final markedTextList = RichMarker.values.map(_getMarkedText).toList();

    if (_clickableMarker != null) {
      final markedText = _getMarkedText(_clickableMarker);
      markedTextList.add(
        MarkerText.withFunction(
          marker: markedText.marker,
          functions: _callbacks,
          style: markedText.style,
        ),
      );
    }

    return markedTextList;
  }

  MarkerText _getMarkedText(RichMarker marker) {
    switch (marker) {
      case RichMarker.accent:
        return MarkerText(
          marker: RichMarker.accent.value,
          style: _textStyle.copyWith(color: R.palette.accent),
        );
      case RichMarker.bold:
        return MarkerText(
          marker: RichMarker.bold.value,
          style: _textStyle.copyWith(fontWeight: R.styles.textWeightBold),
        );
      case RichMarker.italic:
        return MarkerText(
          marker: RichMarker.italic.value,
          style: _textStyle.copyWith(fontStyle: FontStyle.italic),
        );
    }
  }
}
