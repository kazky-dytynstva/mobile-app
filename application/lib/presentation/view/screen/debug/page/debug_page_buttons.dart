import 'package:flutter/material.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/debug/page/base_debug_page.dart';
import 'package:mobile_app/presentation/widget/button/button_ghost.dart';
import 'package:mobile_app/presentation/widget/button/button_icon.dart';
import 'package:mobile_app/presentation/widget/button/button_primary.dart';
import 'package:mobile_app/presentation/widget/button/button_secondary.dart';
import 'package:mobile_app/presentation/widget/svg_widget.dart';

class DebugPageButtons extends BaseDebugPage {
  const DebugPageButtons({super.key});

  @override
  BaseDebugPageState createState() => _DebugPageState();
}

class _DebugPageState extends BaseDebugPageState<DebugPageButtons> {
  String get btnTitle => 'Button title';

  @override
  List<DebugPageSection> getSections() => [
        _buildPrimary(),
        _buildSecondary(),
        _buildGhost(),
        _buildIconButton(),
      ];

  DebugPageSection _buildPrimary() {
    ButtonPrimary buildTextWithIcon({
      bool positionIconAtEdge = false,
    }) =>
        ButtonPrimary.textWithIcon(
          btnTitle,
          R.assets.icons.heart,
          iconColor: R.palette.doneColor,
          onPressed: () {},
          positionIconAtEdge: positionIconAtEdge,
        );
    final list = <Widget>[
      ButtonPrimary.icon(R.assets.icons.heart, onPressed: () {}),
      ButtonPrimary.text(btnTitle, onPressed: () {}),
      buildTextWithIcon(),
      SizedBox(
        width: double.infinity,
        child: buildTextWithIcon(),
      ),
      SizedBox(
        width: double.infinity,
        child: buildTextWithIcon(positionIconAtEdge: true),
      ),
    ].withBottomPadding;
    return DebugPageSection(
      title: 'Primary buttons',
      children: list,
    );
  }

  DebugPageSection _buildSecondary() {
    ButtonSecondary buildTextWithIcon({
      bool positionIconAtEdge = false,
    }) =>
        ButtonSecondary.textWithIcon(
          btnTitle,
          R.assets.icons.heart,
          iconColor: R.palette.doneColor,
          onPressed: () {},
          positionIconAtEdge: positionIconAtEdge,
        );
    final list = <Widget>[
      ButtonSecondary(
        fixedMaxHeight: true,
        child: SvgWidget.graphic(
          R.assets.graphics.audio,
          height: 80,
        ),
        onPressed: () {},
      ),
      ButtonSecondary(
        onPressed: () {},
        fixedMaxHeight: false,
        child: SvgWidget.graphic(
          R.assets.graphics.audio,
          height: 80,
        ),
      ),
      ButtonSecondary.icon(R.assets.icons.heart, onPressed: () {}),
      ButtonSecondary.text(btnTitle, onPressed: () {}),
      buildTextWithIcon(),
      SizedBox(
        width: double.infinity,
        child: buildTextWithIcon(),
      ),
      SizedBox(
        width: double.infinity,
        child: buildTextWithIcon(positionIconAtEdge: true),
      ),
    ].withBottomPadding;
    return DebugPageSection(
      title: 'Secondary buttons',
      children: list,
    );
  }

  DebugPageSection _buildGhost() {
    ButtonGhost buildTextWithIcon({
      bool positionIconAtEdge = false,
    }) =>
        ButtonGhost.textWithIcon(
          btnTitle,
          R.assets.icons.heart,
          iconColor: R.palette.doneColor,
          onPressed: () {},
          positionIconAtEdge: positionIconAtEdge,
        );
    final list = <Widget>[
      ButtonGhost.icon(R.assets.icons.heart, onPressed: () {}),
      ButtonGhost.text(btnTitle, onPressed: () {}),
      buildTextWithIcon(),
      SizedBox(
        width: double.infinity,
        child: buildTextWithIcon(),
      ),
      SizedBox(
        width: double.infinity,
        child: buildTextWithIcon(positionIconAtEdge: true),
      ),
    ].withBottomPadding;
    return DebugPageSection(
      title: 'Ghost buttons',
      children: list,
    );
  }

  DebugPageSection _buildIconButton() {
    final list = <Widget>[
      ButtonIcon(R.assets.icons.audio, onPressed: () {}),
      ButtonIcon(
        R.assets.icons.audio,
        onPressed: () {},
        size: R.dimen.unit2,
        color: R.palette.doneColor,
      ),
      ButtonIcon(
        R.assets.icons.audio,
        onPressed: () {},
        size: R.dimen.unit5,
      ),
    ].withRightPadding;
    return DebugPageSection(
      title: 'Icon buttons',
      children: [
        Row(children: list),
      ],
    );
  }
}
