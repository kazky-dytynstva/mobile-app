import 'package:flutter/material.dart';
import 'package:mobile_app/presentation/view/screen/debug/page/base_debug_page.dart';
import 'package:mobile_app/presentation/widget/loading_bar.dart';

class DebugPageProgress extends BaseDebugPage {
  const DebugPageProgress({super.key});

  @override
  BaseDebugPageState createState() => _DebugPageState();
}

class _DebugPageState extends BaseDebugPageState<DebugPageProgress> {
  @override
  List<DebugPageSection> getSections() => [
        _buildBaseStyles(),
      ];

  DebugPageSection _buildBaseStyles() {
    final list = <Widget>[
      const LoadingBar(),
      const LoadingBar(size: 50),
    ].withBottomPadding;
    return DebugPageSection(
      title: 'Circular loading',
      children: list,
    );
  }
}
