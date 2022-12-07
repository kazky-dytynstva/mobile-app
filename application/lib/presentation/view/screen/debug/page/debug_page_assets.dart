import 'package:flutter/material.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_graphic.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_icon.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/debug/page/base_debug_page.dart';
import 'package:mobile_app/presentation/widget/svg_widget.dart';

class DebugPageAssets extends BaseDebugPage {
  const DebugPageAssets({Key? key}) : super(key: key);

  @override
  BaseDebugPageState createState() => _DebugPageState();
}

class _DebugPageState extends BaseDebugPageState<DebugPageAssets> {
  double get nameMaxHeight => R.dimen.unit4;

  @override
  List<DebugPageSection> getSections() => [
        _buildIconsSection(),
        _buildGraphicsSection(),
      ];

  DebugPageSection _buildIconsSection() {
    Widget buildItem(SvgAssetIcon item) {
      final iconSize = R.dimen.iconSize;
      final icon = SvgWidget.icon(
        item,
        width: iconSize,
        height: iconSize,
      );
      final size = iconSize + nameMaxHeight + R.dimen.unit;
      return SizedBox(
          height: size,
          width: size,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [icon, _buildName(item.name)],
          ));
    }

    final children = R.assets.icons.getAll().map(buildItem).toList();
    final wrap = Wrap(
      alignment: WrapAlignment.spaceEvenly,
      runAlignment: WrapAlignment.spaceEvenly,
      children: children,
    );
    return DebugPageSection(
      title: 'Icons',
      children: [wrap],
    );
  }

  DebugPageSection _buildGraphicsSection() {
    Widget buildItem(SvgAssetGraphic item) {
      const graphicSize = 70.0;
      final svg = SvgWidget.graphic(
        item,
        width: graphicSize,
        height: graphicSize,
      );
      final size = graphicSize + nameMaxHeight + R.dimen.unit;
      return SizedBox(
          height: size,
          width: size,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [svg, _buildName(item.name)],
          ));
    }

    final children = R.assets.graphics.getAll().map(buildItem).toList();
    final wrap = Wrap(
      alignment: WrapAlignment.spaceEvenly,
      runAlignment: WrapAlignment.spaceEvenly,
      children: children,
    );
    return DebugPageSection(
      title: 'Graphics',
      children: [wrap],
    );
  }

  Widget _buildName(String name) {
    final text = Text(
      name.replaceAll('_', ' '),
      style: R.styles.textCaption,
      maxLines: 2,
      textAlign: TextAlign.center,
    );
    return SizedBox(
      height: nameMaxHeight,
      child: Center(child: text),
    );
  }
}
