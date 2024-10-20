import 'package:flutter/material.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/label_with_line.dart';
import 'package:mobile_app/presentation/widget/custom_theme.dart';

abstract class BaseDebugPage extends StatefulWidget {
  const BaseDebugPage({super.key});

  @override
  BaseDebugPageState createState();
}

abstract class BaseDebugPageState<T extends BaseDebugPage> extends State<T>
    with CustomThemeStatefulMixin {
  @override
  Widget build(BuildContext context) {
    final column = Column(
      children: [
        R.spaces.verticalUnit2,
        ...getSections(),
        R.spaces.verticalUnit2,
        R.spaces.verticalBottomNotch,
      ],
    );
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: R.dimen.screenPaddingSide),
      child: column,
    );
  }

  List<DebugPageSection> getSections();
}

class DebugPageSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const DebugPageSection({
    required this.title,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSectionTitle(title),
          R.spaces.verticalUnit,
          ...children,
          R.spaces.verticalUnit2,
        ],
      );

  Widget _buildSectionTitle(String title) => LabelWithLine(label: title);
}

extension ListWithWidgetExtension on List<Widget> {
  List<Widget> get withBottomPadding => map((e) => Padding(
        padding: EdgeInsets.only(bottom: R.dimen.unit1_5),
        child: e,
      )).toList();

  List<Widget> get withRightPadding => map((e) => Padding(
        padding: EdgeInsets.only(right: R.dimen.unit1_5),
        child: e,
      )).toList();
}
