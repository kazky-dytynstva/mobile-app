import 'package:flutter/material.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/settings_section_label.dart';

class LabeledChild extends StatelessWidget {
  final String label;
  final TextStyle? labelStyle;
  final Widget child;
  final double horizontalChildPadding;

  LabeledChild({
    required this.label,
    required this.child,
    double? horizontalChildPadding,
    this.labelStyle,
    super.key,
  })  : assert(label.isNotEmpty),
        horizontalChildPadding =
            horizontalChildPadding ?? R.dimen.screenPaddingSide;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SettingsSectionLabel(
            label: label,
            labelStyle: labelStyle,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalChildPadding,
            ),
            child: child,
          )
        ],
      );
}

class LabeledChildren extends LabeledChild {
  LabeledChildren({
    required super.label,
    required List<Widget> children,
    super.labelStyle,
    super.horizontalChildPadding,
    super.key,
  })  : assert(children.isNotEmpty),
        super(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
        );
}
