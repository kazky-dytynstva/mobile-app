import 'package:flutter/material.dart';
import 'package:mobile_app/domain/extensions/string.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/rating/rating_data.dart';
import 'package:mobile_app/domain/model/rating/rating_type.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_name.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_graphic.dart';
import 'package:mobile_app/infrastructure/di/dependency_injection.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/dialog/base/base_dialog.dart';
import 'package:mobile_app/presentation/widget/rating_item.dart';

class TaleRatingDialog extends BaseDialog {
  final TaleName name;
  final RatingData data;
  final VoidCallback onInfoPressed;
  final VoidCallback onClosePressed;

  const TaleRatingDialog({
    required this.name,
    required this.data,
    required this.onInfoPressed,
    required this.onClosePressed,
    Key? key,
  }) : super(key: key);

  @override
  BaseDialogState<BaseDialog> createState() => _State();
}

class _State extends BaseDialogState<TaleRatingDialog> {
  late final nameMapper = getIt<Mapper<RatingType, String>>();

  @override
  SvgAssetGraphic get image => RatingItem(type: widget.data.type).graphic;

  @override
  String? get title => nameMapper.map(widget.data.type);

  @override
  String? get message => R.strings.dialog.taleRatingMsg.formats([
        widget.data.roundedNumber.toString(),
        widget.name.get(),
      ]);

  @override
  DialogBtnData? get positiveBtnData => DialogBtnData(
        text: R.strings.dialog.taleRatingBtnPos,
        onPressed: widget.onInfoPressed,
        icon: R.assets.icons.info,
      );

  @override
  VoidCallback get getCloseBtnCallback => widget.onClosePressed;
}
