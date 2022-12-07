import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/app_tab/app_tab_data.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_icon.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/svg_widget.dart';

class AppTab extends StatelessWidget {
  final AppTabData data;

  /// 1 - fully selected, 0 - unselected
  final double selectPercent;

  const AppTab({
    required this.data,
    required this.selectPercent,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Tab(
        child: Stack(
          children: [
            _buildContent(R.palette.tabLabelColorInActive),
            Opacity(
              opacity: max(0, min(selectPercent, 1)),
              child: _buildContent(R.palette.tabLabelColorActive),
            ),
          ],
        ),
      );

  Widget _buildContent(Color color) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (data.icon != null) _buildIcon(data.icon!, color),
          _buildText(color),
        ],
      );

  Widget _buildText(Color color) => Text(
        data.label.get(),
        style: R.styles.textSubTitle.copyWith(color: color),
      );

  Widget _buildIcon(SvgAssetIcon icon, Color color) => Padding(
        padding: EdgeInsets.only(right: R.dimen.unit2),
        child: SvgWidget.icon(
          icon,
          color: color,
        ),
      );
}
