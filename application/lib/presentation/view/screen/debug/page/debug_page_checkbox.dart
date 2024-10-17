import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/debug/page/base_debug_page.dart';
import 'package:mobile_app/presentation/widget/app_check_box.dart';

class DebugPageCheckbox extends BaseDebugPage {
  const DebugPageCheckbox({super.key});

  @override
  BaseDebugPageState createState() => _DebugPageState();
}

class _DebugPageState extends BaseDebugPageState<DebugPageCheckbox> {
  var _simpleChecked = true;
  var _fillColorChecked = false;
  var _checkColorChecked = true;

  @override
  List<DebugPageSection> getSections() => [
        _buildSimple(),
        _buildFilledColor(),
        _buildCheckColor(),
      ];

  DebugPageSection _buildSimple() {
    final checkBox = AppCheckBox(
      value: _simpleChecked,
      onChanged: (value) => setState(() {
        _simpleChecked = value;
      }),
    );
    return DebugPageSection(
      title: 'Simple checkbox',
      children: [checkBox],
    );
  }

  DebugPageSection _buildFilledColor() {
    final checkBox = AppCheckBox(
      fillColor: R.palette.doneColor,
      value: _fillColorChecked,
      onChanged: (value) => setState(() {
        _fillColorChecked = value;
      }),
    );
    return DebugPageSection(
      title: 'With changed fill color',
      children: [checkBox],
    );
  }

  DebugPageSection _buildCheckColor() {
    final checkBox = AppCheckBox(
      checkColor: R.palette.background,
      value: _checkColorChecked,
      onChanged: (value) => setState(() {
        _checkColorChecked = value;
      }),
    );
    return DebugPageSection(
      title: 'With changed check color',
      children: [checkBox],
    );
  }
}
