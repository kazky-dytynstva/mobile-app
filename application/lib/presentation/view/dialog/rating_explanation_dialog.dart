import 'package:flutter/material.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/rating/rating_type.dart';
import 'package:mobile_app/data/di/dependency_injection.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/dialog/base/base_dialog.dart';
import 'package:mobile_app/presentation/widget/rating_item.dart';

class RatingExplanationDialog extends BaseDialog {
  final VoidCallback onClosePressed;

  const RatingExplanationDialog({
    required this.onClosePressed,
    Key? key,
  }) : super(key: key);

  @override
  BaseDialogState<BaseDialog> createState() => _State();
}

class _State extends BaseDialogState<RatingExplanationDialog> {
  late final nameMapper = getIt<Mapper<RatingType, String>>();

  @override
  String? get title => R.strings.dialog.ratingExplanationsTitle;

  @override
  String? get message => R.strings.dialog.ratingExplanationsMsg;

  @override
  Widget? get content {
    Widget buildItem(RatingType type) => Padding(
          padding: EdgeInsets.symmetric(vertical: R.dimen.unit0_25),
          child: Row(children: [
            RatingItem(type: type),
            R.spaces.horizontalUnit2,
            Text(nameMapper.map(type), style: R.styles.textBody)
          ]),
        );

    final items = RatingType.values.map(buildItem).toList();
    final child = Column(
      mainAxisSize: MainAxisSize.min,
      children: items,
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: R.dimen.unit3),
      child: child,
    );
  }

  @override
  VoidCallback get getCloseBtnCallback => widget.onClosePressed;
}
