import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_name.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_name.dart';
import 'package:mobile_app/presentation/resource/r.dart';

typedef OnTextPressed = Function(String search);

class SearchTaleExample extends StatelessWidget {
  final TaleName taleName;
  final PersonName authorName;
  final OnTextPressed onTextPressed;

  const SearchTaleExample(
    this.taleName,
    this.authorName, {
    required this.onTextPressed,
    super.key,
  });

  TextStyle get style => R.styles.textSubTitleSecondary;

  TextStyle get styleActive => style.copyWith(color: R.palette.accent);

  @override
  Widget build(BuildContext context) {
    final space = R.spaces.verticalUnit2;
    final column = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildText(R.strings.searchTale.searchExampleTaleName),
        space,
        _buildTextActive('"${taleName.get()}"'),
        space,
        _buildText(R.strings.searchTale.searchExampleAuthorName),
        space,
        _buildTextActive('"${authorName.get()}"'),
      ],
    );
    return Center(child: column);
  }

  Widget _buildText(String text) => Text(
        text,
        style: style,
        textAlign: TextAlign.center,
      );

  Widget _buildTextActive(String text) {
    final child = Text(
      text,
      style: styleActive,
      textAlign: TextAlign.center,
    );
    return InkWell(
      splashColor: R.palette.transparent,
      highlightColor: R.palette.transparent,
      hoverColor: R.palette.transparent,
      onTap: () => onTextPressed(text.replaceAll("\"", "")),
      child: child,
    );
  }
}
