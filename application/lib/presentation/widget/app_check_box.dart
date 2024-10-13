import 'package:flutter/material.dart';
import 'package:mobile_app/presentation/resource/r.dart';

class AppCheckBox extends StatelessWidget {
  final bool value;
  final Color? fillColor;
  final Color? checkColor;
  final ValueChanged<bool> onChanged;

  const AppCheckBox({
    required this.value,
    required this.onChanged,
    this.fillColor,
    this.checkColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Checkbox(
        fillColor: WidgetStateProperty.all(fillColor ?? R.palette.accent),
        checkColor: checkColor ?? R.palette.checkBoxCheck,
        value: value,
        shape: RoundedRectangleBorder(borderRadius: R.styles.roundBorder0_5),
        onChanged: (value) => onChanged(value!),
      );
}
