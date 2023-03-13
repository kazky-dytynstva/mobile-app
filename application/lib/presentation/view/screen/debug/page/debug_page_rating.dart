import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/rating/rating_type.dart';
import 'package:mobile_app/domain/navigation/snackbar_controller.dart';
import 'package:mobile_app/data/di/dependency_injection.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/screen/debug/page/base_debug_page.dart';
import 'package:mobile_app/presentation/widget/rate_the_tale.dart';
import 'package:mobile_app/presentation/widget/rating_item.dart';

class DebugPageRating extends BaseDebugPage {
  const DebugPageRating({Key? key}) : super(key: key);

  @override
  BaseDebugPageState createState() => _DebugPageState();
}

class _DebugPageState extends BaseDebugPageState<DebugPageRating> {
  late final SnackbarController _controller = getIt();

  double get nameMaxHeight => R.dimen.unit4;
  var showRateTale = true;

  @override
  List<DebugPageSection> getSections() => [
        _buildItems(),
        _buildButtons(),
        _buildRateTaleView(),
      ];

  DebugPageSection _buildItems() {
    final items = RatingType.values
        .map(
          (e) => Padding(
              padding: EdgeInsets.symmetric(horizontal: R.dimen.unit),
              child: RatingItem(type: e)),
        )
        .toList();
    return DebugPageSection(
      title: 'Rating items',
      children: [Row(children: items)],
    );
  }

  DebugPageSection _buildButtons() {
    final btnFab = RatingItemButton(
      type: RatingType.awesome,
      asFab: true,
      onPressed: () {},
    );
    final btnSimple = RatingItemButton(
      type: RatingType.terrible,
      asFab: false,
      onPressed: () {},
    );
    return DebugPageSection(
      title: 'Rating buttons',
      children: [
        Row(children: [btnFab, btnSimple])
      ],
    );
  }

  DebugPageSection _buildRateTaleView() {
    final view = RateTheTaleView(
        show: showRateTale,
        onPressed: (RatingType type) {
          setState(() {
            showRateTale = false;
          });
          _controller.showInfo(
              message: 'RateTaleView will appear when the snackbar hides',
              title: '${type.name} selected',
              onDismiss: () {
                setState(() {
                  showRateTale = true;
                });
              });
        });
    return DebugPageSection(
      title: 'Rate tale view',
      children: [view],
    );
  }
}
