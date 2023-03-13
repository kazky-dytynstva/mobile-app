import 'package:flutter/material.dart';
import 'package:mobile_app/domain/navigation/snackbar_controller.dart';
import 'package:mobile_app/data/di/dependency_injection.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/debug/page/base_debug_page.dart';
import 'package:mobile_app/presentation/widget/app_rich_text.dart';

class DebugPageAppRichText extends BaseDebugPage {
  const DebugPageAppRichText({Key? key}) : super(key: key);

  @override
  BaseDebugPageState createState() => _State();
}

class _State extends BaseDebugPageState<DebugPageAppRichText> {
  late final SnackbarController _controller = getIt();

  @override
  List<DebugPageSection> getSections() => [
        _buildNonClickable(),
        _buildClickable(),
      ];

  DebugPageSection _buildNonClickable() {
    final List<Widget> items = [];
    items
      ..addAll(RichMarker.values.map(
          (e) => AppRichText('Text with ${e.value}${e.name}${e.value} word')))
      ..add(
        AppRichText(
          'Text with _a_accent_a_, _i_italic_i_ and _b_bold_b_ words together',
        ),
      )
      ..add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: R.dimen.unit2),
          child: AppRichText(
            '_a_BUT!!!_a_ _b__i__a_markers not working together_b__i__a_.\nKeep in mind.',
            style: R.styles.textHeadline,
          ),
        ),
      );
    return DebugPageSection(
      title: 'Non clickable rich text items',
      children: items,
    );
  }

  DebugPageSection _buildClickable() {
    final List<Widget> items = [
      AppRichText.clickable(
        '${RichMarker.accent.value}Accent${RichMarker.accent.value} is clickable',
        callbacks: [() => _controller.showInfo(message: '>ACCENT< clicked')],
      ),
      AppRichText.clickable(
        'Now ${RichMarker.bold.value}bold${RichMarker.bold.value} is clickable',
        callbacks: [() => _controller.showInfo(message: '>BOLD< clicked')],
        clickableMarker: RichMarker.bold,
      ),
      AppRichText.clickable(
        'Here _i_multiple_i_ words are _i_clickable_i_',
        callbacks: [
          () => _controller.showInfo(message: '>MULTIPLE< clicked'),
          () => _controller.showInfo(message: '>CLICKABLE< clicked'),
        ],
        clickableMarker: RichMarker.italic,
      ),
      AppRichText.clickable(
        'Here only _a_THE ONE_a_ is clickable, but _i_different_i_ markers _b_are used_b_',
        callbacks: [
          () => _controller.showInfo(message: '>THE ONE< clicked'),
        ],
        clickableMarker: RichMarker.accent,
      ),
    ];
    return DebugPageSection(
      title: 'Clickable rich text items',
      children: items,
    );
  }
}
