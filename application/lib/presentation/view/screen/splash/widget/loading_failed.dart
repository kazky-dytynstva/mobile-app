import 'package:flutter/material.dart';
import 'package:mobile_app/domain/value_objects/string_not_empty.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/button/button_secondary.dart';
import 'package:mobile_app/presentation/widget/svg_widget.dart';

/// fullscreen widget when initial loading failed
class LoadingFailedWidget extends StatelessWidget {
  final StringNonEmpty errorMsg;
  final VoidCallback onRetryPressed;

  const LoadingFailedWidget({
    Key? key,
    required this.errorMsg,
    required this.onRetryPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final content = Positioned.fill(child: _createContent(context));
    final List<Widget> children = [content];
    return Stack(children: children);
  }

  Widget _createContent(BuildContext context) {
    final title = Text(
      R.strings.general.oops,
      style: R.styles.textHeadline,
    );
    final msg = Text(
      errorMsg.get(),
      textAlign: TextAlign.center,
      style: R.styles.textBody,
    );

    final List<Widget> columnChildren = [
      title,
      R.spaces.verticalUnit4,
      _createIcon(),
      R.spaces.verticalUnit4,
      msg,
    ];

    final btn = ButtonSecondary.text(
      R.strings.general.retry,
      onPressed: onRetryPressed,
    );
    final sized = SizedBox(
      width: R.dimen.screenWidth / 3,
      child: btn,
    );
    columnChildren
      ..add(R.spaces.verticalUnit4)
      ..add(R.spaces.verticalUnit4)
      ..add(sized);

    final column = Column(
      mainAxisSize: MainAxisSize.min,
      children: columnChildren,
    );

    final withPadding = Padding(
      padding: EdgeInsets.symmetric(horizontal: R.dimen.screenPaddingSide),
      child: column,
    );
    return Center(child: withPadding);
  }

  Widget _createIcon() {
    final size = R.dimen.bottomDialogGraphicSize;
    return SvgWidget.graphic(
      R.assets.graphics.error,
      width: size,
      height: size,
    );
  }
}
