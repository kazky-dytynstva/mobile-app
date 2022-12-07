import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/dialog/base/base_dialog.dart';
import 'package:mobile_app/presentation/widget/tales_list_item.dart';

class RandomTaleDialog extends BaseDialog {
  final TalesPageItemData tale;
  final VoidCallback onClosePressed;
  final VoidCallback onReadPressed;
  final VoidCallback onNextPressed;
  final VoidCallback onFavPressed;
  final OnRatingPressed onRatingPressed;

  const RandomTaleDialog(
    this.tale, {
    required this.onReadPressed,
    required this.onNextPressed,
    required this.onFavPressed,
    required this.onClosePressed,
    required this.onRatingPressed,
    Key? key,
  }) : super(key: key);

  @override
  BaseDialogState<BaseDialog> createState() => _State();
}

class _State extends BaseDialogState<RandomTaleDialog> {
  @override
  String get title => R.strings.dialog.randomTaleTitle;

  @override
  Widget get content => TalesListItem(
        margin: EdgeInsets.symmetric(horizontal: R.dimen.unit),
        data: widget.tale,
        onTalePressed: widget.onReadPressed,
        onFavPressed: widget.onFavPressed,
        onRatingPressed: widget.onRatingPressed,
      );

  @override
  List<DialogBtnData> get buttonList => [
        _getNext(),
        _getClose(),
      ];

  DialogBtnData _getNext() => DialogBtnData(
        text: R.strings.dialog.randomTaleNext,
        onPressed: widget.onNextPressed,
      );

  DialogBtnData _getClose() => DialogBtnData(
        text: R.strings.general.close,
        onPressed: widget.onClosePressed,
      );
}
