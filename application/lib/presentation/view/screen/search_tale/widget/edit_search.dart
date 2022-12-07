import 'package:dartz/dartz.dart' as d;
import 'package:flutter/material.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/fade_animated_switcher.dart';
import 'package:mobile_app/presentation/widget/svg_widget.dart';

typedef OnSearchChanged = Function(String text);

class EditSearch extends StatefulWidget {
  final OnSearchChanged onSearchChanged;
  final d.Option<StringSingleLine> searchOption;

  const EditSearch({
    required this.onSearchChanged,
    required this.searchOption,
    Key? key,
  }) : super(key: key);

  @override
  State<EditSearch> createState() => _EditSearchState();
}

class _EditSearchState extends State<EditSearch> {
  late final controller = TextEditingController();

  String _text = '';

  bool get _showClear => _text.isNotEmpty;

  @override
  void didUpdateWidget(covariant EditSearch oldWidget) {
    if (oldWidget.searchOption.isNone() && widget.searchOption.isSome()) {
      widget.searchOption.fold(() => null, (a) {
        controller.text = a.get();
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length),
        );
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    controller.addListener(() {
      widget.onSearchChanged(controller.value.text);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          _text = controller.value.text;
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(child: _buildSearchField()),
          _buildClearIcon(),
        ],
      );

  Widget _buildSearchField() => TextField(
        controller: controller,
        autofocus: true,
        cursorColor: R.palette.accent,
        style: R.styles.textSubTitle,
        decoration: _getDecoration(),
        textInputAction: TextInputAction.search,
        maxLines: 1,
        maxLength: 30,
      );

  InputDecoration _getDecoration() => InputDecoration(
        border: InputBorder.none,
        counterText: '',
        hintText: R.strings.searchTale.searchHint,
      );

  Widget _buildClearIcon() {
    Widget buildBtn() => InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: controller.clear,
          child: SvgWidget.icon(R.assets.icons.circleCross),
        );
    final child = _showClear ? buildBtn() : R.spaces.empty;
    return FadeAnimatedSwitcher.short(child: child);
  }
}
