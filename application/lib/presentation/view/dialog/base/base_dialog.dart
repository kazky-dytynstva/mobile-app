import 'package:flutter/material.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_graphic.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_icon.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/button/button_ghost.dart';
import 'package:mobile_app/presentation/widget/button/button_primary.dart';
import 'package:mobile_app/presentation/widget/svg_widget.dart';

abstract class BaseDialog extends StatefulWidget {
  const BaseDialog({super.key});

  @override
  BaseDialogState createState();
}

class BaseDialogState<T extends BaseDialog> extends State<T> {
  late final double _spaceL = R.dimen.unit3;
  late final double _spaceM = R.dimen.unit2;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];

    void addSpace2({
      double notAlone = 0,
      double alone = 24,
    }) {
      assert(notAlone >= 0 && alone >= 0);
      assert(notAlone > 0 || alone > 0);
      final height = children.isEmpty ? alone : notAlone;
      final space = SizedBox(height: height);
      children.add(space);
    }

    // icon
    final iconView = _buildIconView();
    if (iconView != null) {
      addSpace2();
      children.add(iconView);
    }

    // title
    final titleView = _buildTitleView();
    if (titleView != null) {
      addSpace2(
        notAlone: _spaceL,
      );
      children.add(titleView);
    }

    // message
    final messageView = _buildMessageView();
    if (messageView != null) {
      addSpace2(notAlone: _spaceM);
      children.add(messageView);
    }

    // content
    final contentView = content;
    if (contentView != null) {
      addSpace2(notAlone: _spaceM, alone: _spaceM);
      children.add(contentView);
    }

    final buttonViews = _buildButtonViews();
    if (buttonViews != null) {
      addSpace2(notAlone: _spaceL);
      children.addAll(buttonViews);
    } else {
      final positiveBtnView = _buildPositiveBtnView();
      final negativeBtnVIew = _buildNegativeBtnView();
      if (positiveBtnView != null || negativeBtnVIew != null) {
        addSpace2(notAlone: _spaceL);
        if (positiveBtnView != null) {
          children.add(positiveBtnView);
        }
        if (negativeBtnVIew != null) {
          children.add(negativeBtnVIew);
        }
      }
    }

    assert(children.isNotEmpty);

    addSpace2(notAlone: _spaceL);

    final column = Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
    return column;
  }

  //region title
  @protected
  String? get title => null;

  @protected
  bool get alignTitleToCenter => true;

  //endregion title

  //region msg
  @protected
  String? get message => null;

  @protected
  bool get alignMsgToCenter => true;

  //endregion msg

  //region content
  @protected
  Widget? get content => null;

  @protected
  SvgAssetGraphic? get image => null;

  //endregion content

  //region buttons
  @protected
  DialogBtnData? get positiveBtnData => null;

  @protected
  DialogBtnData? get negativeBtnData => null;

  VoidCallback? get getCloseBtnCallback => null;

  VoidCallback? get getCancelBtnCallback => null;

  @protected
  List<DialogBtnData>? get buttonList => null;

  //endregion buttons

  Widget? _buildTitleView() {
    final value = title;
    if (value == null) {
      return null;
    }
    final text = Text(
      value,
      style: R.styles.textHeadline,
      textAlign: alignTitleToCenter ? TextAlign.center : null,
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: R.dimen.unit3),
      child: text,
    );
  }

  Widget? _buildIconView() {
    final value = image;
    if (value == null) {
      return null;
    }
    final size = R.dimen.bottomDialogGraphicSize;
    final svg = SvgWidget.graphic(
      value,
      width: size,
      height: size,
    );
    return Padding(
      padding: EdgeInsets.all(R.dimen.unit),
      child: svg,
    );
  }

  Widget? _buildMessageView() {
    final msgStr = message;
    if (msgStr == null) {
      return null;
    }
    final msg = Text(
      msgStr,
      style: R.styles.textBody,
      textAlign: alignMsgToCenter ? TextAlign.center : null,
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: R.dimen.unit2),
      child: msg,
    );
  }

  List<Widget>? _buildButtonViews() {
    final data = buttonList;
    if (data == null) return null;

    return data.map(_buildRowBtnItem).toList();
  }

  Widget? _buildPositiveBtnView() {
    final data = positiveBtnData;
    if (data == null) {
      return null;
    }
    final icon = data.icon;
    final button = (icon == null)
        ? ButtonPrimary.text(data.text, onPressed: data.onPressed)
        : ButtonPrimary.textWithIcon(
            data.text,
            icon,
            onPressed: data.onPressed,
            positionIconAtEdge: data.positionIconAtEdge,
          );

    return _buildSizedBtn(button);
  }

  Widget? _buildNegativeBtnView() {
    final data = _closeBtnData ?? _cancelBtnData ?? negativeBtnData;
    if (data == null) {
      return null;
    }
    final icon = data.icon;
    final button = (icon == null)
        ? ButtonGhost.text(data.text, onPressed: data.onPressed)
        : ButtonGhost.textWithIcon(
            data.text,
            icon,
            onPressed: data.onPressed,
            positionIconAtEdge: data.positionIconAtEdge,
          );

    return _buildSizedBtn(button);
  }

  Widget _buildRowBtnItem(DialogBtnData data) {
    final icon = data.icon;
    final button = icon == null
        ? ButtonGhost.text(data.text, onPressed: data.onPressed)
        : ButtonGhost.textWithIcon(
            data.text,
            icon,
            onPressed: data.onPressed,
            positionIconAtEdge: data.positionIconAtEdge,
          );
    return _buildSizedBtn(button);
  }

  DialogBtnData? get _closeBtnData {
    final callback = getCloseBtnCallback;
    if (callback == null) return null;

    return DialogBtnData(
      text: R.strings.general.close,
      onPressed: callback,
    );
  }

  DialogBtnData? get _cancelBtnData {
    final callback = getCancelBtnCallback;
    if (callback == null) return null;

    return DialogBtnData(
      text: R.strings.general.cancel,
      onPressed: callback,
    );
  }

  Widget _buildSizedBtn(Widget btnChild) => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) => SizedBox(
          width: constraints.maxWidth / 6 * 5,
          child: btnChild,
        ),
      );
}

class DialogBtnData {
  final String text;
  final VoidCallback onPressed;
  final SvgAssetIcon? icon;
  final bool positionIconAtEdge;

  DialogBtnData({
    required this.text,
    required this.onPressed,
    this.icon,
    this.positionIconAtEdge = true,
  });
}
