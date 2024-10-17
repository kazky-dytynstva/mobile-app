import 'package:flutter/material.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/debug/page/base_debug_page.dart';

class DebugPageTextStyles extends BaseDebugPage {
  const DebugPageTextStyles({super.key});

  @override
  BaseDebugPageState createState() => _DebugPageState();
}

class _DebugPageState extends BaseDebugPageState<DebugPageTextStyles> {
  @override
  List<DebugPageSection> getSections() => [
        _buildBaseStyles(),
      ];

  DebugPageSection _buildBaseStyles() {
    final list = <Widget>[
      Text('Headline', style: R.styles.textHeadline),
      Text('SubTitle', style: R.styles.textSubTitle),
      Text('Body', style: R.styles.textBody),
      Text('Caption', style: R.styles.textCaption),
      Text('Button', style: R.styles.textButton),
    ].withBottomPadding;
    return DebugPageSection(
      title: 'Base styles',
      children: list,
    );
  }
}
