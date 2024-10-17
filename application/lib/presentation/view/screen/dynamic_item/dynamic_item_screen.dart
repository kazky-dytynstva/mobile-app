import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/menu_dynamic_item/menu_dynamic_item_data.dart';
import 'package:mobile_app/domain/value_objects/string_not_empty.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/dynamic_item/manager/dynamic_item_screen_manager.dart';
import 'package:mobile_app/presentation/view/screen/screen_mixin.dart';
import 'package:mobile_app/presentation/widget/app_rich_text.dart';
import 'package:mobile_app/presentation/widget/bottom_bar_with_actions.dart';
import 'package:mobile_app/presentation/widget/button/button_primary.dart';

@RoutePage()
class DynamicItemScreen extends StatefulWidget {
  final MenuDynamicItemData data;

  const DynamicItemScreen({
    required this.data,
    super.key,
  });

  @override
  State<DynamicItemScreen> createState() => _State();
}

class _State
    extends ScreenWidgetState<DynamicItemScreen, DynamicItemScreenManager> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      );

  AppBar _buildAppBar() {
    final title = Text(
      widget.data.title.get(),
      style: R.styles.toolbarTitle,
      textAlign: TextAlign.center,
    );
    final columnChildren = <Widget>[title];

    widget.data.subTitleOption.map((subTitle) {
      columnChildren.addAll([
        R.spaces.verticalUnit,
        Text(
          subTitle.get(),
          style: R.styles.toolbarSubTitle,
          textAlign: TextAlign.center,
        ),
      ]);
    });

    return AppBar(
      backgroundColor: R.palette.primary,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: columnChildren,
      ),
      toolbarHeight: R.dimen.toolbarHeightBig,
    );
  }

  Widget _buildBottomButtons() {
    final ctaButton = ButtonPrimary.text(
      widget.data.cta.get(),
      onPressed: () => manager.onCTAPressed(widget.data.url),
    );
    return BottomBarWithActions(
      onBackPressed: manager.onBackPressed,
      items: [ctaButton],
    );
  }

  Widget _buildBody() {
    final pointsData =
        (widget.data.pointsOption as Some<List<StringNonEmpty>>).value;

    Widget buildPoint(StringNonEmpty point) => Padding(
          padding: EdgeInsets.only(bottom: R.dimen.unit2),
          child: AppRichText(
            point.get(),
            style: R.styles.textSubTitle,
          ),
        );
    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        R.spaces.verticalUnit2,
        ...pointsData.map(buildPoint),
        SizedBox(height: R.dimen.bottomBarWithActionsHeight * 2),
      ],
    );
    final withPadding = Padding(
      padding: EdgeInsets.symmetric(horizontal: R.dimen.screenPaddingSide),
      child: column,
    );

    return Stack(
      children: [
        Positioned.fill(child: SingleChildScrollView(child: withPadding)),
        Positioned.fill(top: null, child: _buildBottomButtons()),
      ],
    );
  }
}
