import 'package:flutter/material.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/rating/rating_type.dart';
import 'package:mobile_app/domain/value_objects/svg_asset_graphic.dart';
import 'package:mobile_app/infrastructure/di/dependency_injection.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/dialog/base/base_dialog.dart';
import 'package:mobile_app/presentation/widget/rating_item.dart';

class ConfirmRateTaleDialog extends BaseDialog {
  final RatingType type;
  final VoidCallback onConfirmPressed;
  final VoidCallback _onClosePressed;

  const ConfirmRateTaleDialog({
    required this.type,
    required this.onConfirmPressed,
    required VoidCallback onClosePressed,
    Key? key,
  })  : _onClosePressed = onClosePressed,
        super(key: key);

  @override
  BaseDialogState<BaseDialog> createState() => _State();
}

class _State extends BaseDialogState<ConfirmRateTaleDialog> {
  late final nameMapper = getIt<Mapper<RatingType, String>>();

  @override
  String get title => nameMapper.map(widget.type);

  @override
  String get message => R.strings.dialog.confirmTaleRatingMessage;

  @override
  SvgAssetGraphic? get image => RatingItem(type: widget.type).graphic;

  @override
  DialogBtnData get positiveBtnData => DialogBtnData(
        text: R.strings.dialog.confirmTaleRatingPos,
        onPressed: widget.onConfirmPressed,
      );

  @override
  VoidCallback? get getCloseBtnCallback => widget._onClosePressed;
}
