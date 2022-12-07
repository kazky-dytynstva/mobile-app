import 'package:flutter/material.dart';
import 'package:mobile_app/presentation/resource/r.dart';

class AppDivider extends StatelessWidget {
  final Axis axis;
  final EdgeInsets? padding;
  final double thickness;

  const AppDivider({
    this.axis = Axis.horizontal,
    this.padding,
    this.thickness = 1,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      axis == Axis.horizontal ? _horizontal() : _vertical();

  Widget _horizontal() => Padding(
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: R.dimen.unit2,
              vertical: R.dimen.unit0_5,
            ),
        child: Divider(
          height: thickness,
          thickness: thickness,
        ),
      );

  Widget _vertical() => Padding(
        padding: padding ?? EdgeInsets.all(R.dimen.unit0_5),
        child: VerticalDivider(
          width: thickness,
          thickness: thickness,
        ),
      );
}
