import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/forced_update_info/forced_update_info.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/forced_update/manager/forced_update_manager.dart';
import 'package:mobile_app/presentation/view/screen/screen_mixin.dart';
import 'package:mobile_app/presentation/widget/button/button_ghost.dart';
import 'package:mobile_app/presentation/widget/button/button_primary.dart';
import 'package:mobile_app/presentation/widget/divider.dart';

class ForcedUpdateScreen extends StatefulWidget {
  final ForcedUpdateInfo info;

  const ForcedUpdateScreen({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  State<ForcedUpdateScreen> createState() => _ForcedUpdateScreenState();
}

class _ForcedUpdateScreenState
    extends ScreenWidgetState<ForcedUpdateScreen, ForcedUpdateManager> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
        bottomNavigationBar: _buildBottomButtons(),
      );

  AppBar _buildAppBar() {
    final title = Text(
      widget.info.title.get(),
      style: R.styles.toolbarTitle,
      textAlign: TextAlign.center,
    );
    return AppBar(
      backgroundColor: R.palette.primary,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: title,
      toolbarHeight: R.dimen.toolbarHeightBig,
    );
  }

  Widget _buildBody() {
    final msg = Text(
      widget.info.msg.get(),
      style: R.styles.textSubTitle,
      textAlign: TextAlign.center,
    );

    final column = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        R.spaces.verticalUnit4,
        msg,
        R.spaces.verticalUnit4,
        _buildItems(),
        R.spaces.verticalUnit4,
        R.spaces.verticalUnit4,
        R.spaces.verticalUnit4,
      ],
    );
    return Center(
      child: SingleChildScrollView(
        child: column,
      ),
    );
  }

  Widget _buildItems() => widget.info.pointsOption.fold(
        () => R.spaces.empty,
        (pointItems) {
          Widget buildItem(point) => Text(
                '- ${point.get()}',
                style: R.styles.textBody,
              );
          final items = pointItems.map(buildItem).toList();
          final column = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: items,
          );
          return Padding(
            padding:
                EdgeInsets.symmetric(horizontal: R.dimen.screenPaddingSide),
            child: column,
          );
        },
      );

  Widget _buildBottomButtons() {
    final updateBtn = ButtonPrimary.text(
      R.strings.general.updateAppBtn,
      onPressed: manager.onUpdatePressed,
    );
    final children = <Widget>[
      const AppDivider(),
      R.spaces.verticalUnit,
      updateBtn,
      R.spaces.verticalUnit,
    ];
    if (widget.info.canSkip) {
      final skipBtn = ButtonGhost.text(
        R.strings.general.cancel,
        onPressed: manager.onSkipPressed,
      );
      children.addAll([
        skipBtn,
        R.spaces.verticalUnit,
      ]);
    }
    children.addAll([
      const AppDivider(),
      R.spaces.verticalUnit4,
    ]);
    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}
