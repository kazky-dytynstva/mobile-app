import 'package:flutter/foundation.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/debug/page/base_debug_page.dart';
import 'package:mobile_app/presentation/widget/flip_down_timer.dart';

class DebugPageFlipDownTimer extends BaseDebugPage {
  const DebugPageFlipDownTimer({Key? key}) : super(key: key);

  @override
  BaseDebugPageState createState() => _DebugPageState();
}

class _DebugPageState extends BaseDebugPageState<DebugPageFlipDownTimer> {
  @override
  List<DebugPageSection> getSections() => [
        _buildDefault(),
        _buildVersion1(),
        _buildVersion2(),
      ];

  DebugPageSection _buildDefault() {
    const child = FlipDownTimer(
      duration: Duration(seconds: 70),
    );
    return const DebugPageSection(
      title: 'Default one',
      children: [child],
    );
  }

  DebugPageSection _buildVersion1() {
    final child = FlipDownTimer(
      duration: const Duration(seconds: 75),
      digitSize: 50,
      onDone: () {
        if (kDebugMode) {
          print('TADA 🎉');
        }
      },
    );
    return DebugPageSection(
      title: 'Variant 1',
      children: [child],
    );
  }

  DebugPageSection _buildVersion2() {
    final child = FlipDownTimer(
      duration: const Duration(seconds: 75),
      digitSize: 30,
      cardColor: R.palette.doneColor,
      digitColor: R.palette.ratingColor,
      onDone: () {
        if (kDebugMode) {
          print('TADA 🎉');
        }
      },
    );
    return DebugPageSection(
      title: 'Variant 2',
      children: [child],
    );
  }
}
