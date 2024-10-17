import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/settings/settings_data_text.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/settings/page/text/settings_section_text_scale_factor.dart';
import 'package:mobile_app/presentation/widget/fade_animated_switcher.dart';

class SettingsPageText extends StatelessWidget {
  final SettingsDataText data;
  final OnTextScaleFactorPressed onTextScaleFactorPressed;

  const SettingsPageText({
    required this.data,
    required this.onTextScaleFactorPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      _buildExampleSandpit(),
      _buildSectionTextScaleFactor(),

      // we need to respect bottomBar height
      SliverToBoxAdapter(
        child: SizedBox(height: R.dimen.bottomBarWithActionsHeight),
      ),
    ];
    return CustomScrollView(
      slivers: children,
    );
    // return SingleChildScrollView(
    //   child: Column(children: children),
    // );
  }

  Widget _buildSectionTextScaleFactor() => SliverToBoxAdapter(
        child: SettingsSectionTextScaleFactor(
          currentFactor: data.textScaleFactor,
          onPressed: onTextScaleFactorPressed,
        ),
      );

  Widget _buildExampleSandpit() {
    final text = Text(
      key: ValueKey(data.textScaleFactor),
      R.strings.settings.textScaleFactorExample,
      style: R.styles.taleText,
      textAlign: TextAlign.center,
      textScaler: data.textScaleFactor.value,
    );
    final animated = FadeAnimatedSwitcher.long(child: text);

    final height = R.dimen.screenHeight / 7;
    final container = Container(
      margin: EdgeInsets.symmetric(
        horizontal: R.dimen.screenPaddingSide,
        vertical: R.dimen.unit2,
      ),
      padding: EdgeInsets.all(R.dimen.unit),
      decoration: BoxDecoration(
        color: R.palette.divider.withOpacity(0.2),
        borderRadius: R.styles.imageBorderRadiusSmall,
      ),
      height: height,
      child: Center(child: animated),
    );
    return SliverAppBar(
      pinned: true,
      backgroundColor: R.palette.background,
      automaticallyImplyLeading: false,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(height),
        child: container,
      ),
    );
  }
}
