import 'package:flutter/material.dart';
import 'package:mobile_app/presentation/resource/r.dart';

class LabelWithLine extends StatelessWidget {
  final String label;
  final TextStyle? labelStyle;

  const LabelWithLine({
    super.key,
    required this.label,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    final style = labelStyle ?? R.styles.textCaption;
    final text = Text(
      label,
      style: style.copyWith(color: R.palette.accent),
    );
    final row = Row(
      children: [
        SizedBox(width: R.dimen.unit3, child: const Divider()),
        R.spaces.horizontalUnit,
        text,
        R.spaces.horizontalUnit,
        const Expanded(child: Divider()),
      ],
    );
    return Padding(
      padding: EdgeInsets.only(
        top: R.dimen.unit3,
        bottom: R.dimen.unit,
        left: R.dimen.unit,
        right: R.dimen.unit,
      ),
      child: row,
    );
  }
}
