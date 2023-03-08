import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/version_changes/version_changes.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/label_with_line.dart';

class WhatsNewsChanges extends StatelessWidget {
  final VersionChanges changes;

  const WhatsNewsChanges({
    required this.changes,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          LabelWithLine(label: 'v. ${changes.version.name.get()}'),
          ...changes.items.map(_buildChange),
          R.spaces.verticalUnit,
        ],
      );

  Widget _buildChange(VersionChangeItem change) {
    final title = Text(
      change.title.get(),
      style: R.styles.textSubTitle,
    );
    final subtitle = change.description == null
        ? null
        : Padding(
            padding: EdgeInsets.only(left: R.dimen.unit, top: R.dimen.unit0_5),
            child: Text(
              change.description!.get(),
              style: R.styles.textBody,
            ),
          );
    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        title,
        if (subtitle != null) R.spaces.verticalUnit0_5,
        if (subtitle != null) subtitle,
        R.spaces.verticalUnit2,
      ],
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: R.dimen.screenPaddingSide),
      child: column,
    );
  }
}
