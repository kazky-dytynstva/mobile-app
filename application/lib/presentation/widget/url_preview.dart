import 'package:flutter/material.dart' hide NetworkImage;
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;
import 'package:mobile_app/domain/value_objects/url_string.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/button/button_secondary.dart';

class UrlPreview extends StatefulWidget {
  final UrlString url;
  final VoidCallback onPressed;

  const UrlPreview({
    required this.url,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  State<UrlPreview> createState() => _UrlPreviewState();
}

class _UrlPreviewState extends State<UrlPreview> {
  PreviewData? previewData;

  late final authority = Uri.parse(widget.url.get()).authority;

  @override
  Widget build(BuildContext context) {
    final authorityText = Text(
      authority,
      style: R.styles.textCaption.copyWith(
        color: R.palette.accent,
        decoration: TextDecoration.underline,
      ),
    );
    final preview = LinkPreview(
      padding: EdgeInsets.zero,
      metadataTitleStyle: R.styles.textBody,
      metadataTextStyle: R.styles.textBodySecondary,
      animationDuration: R.durations.animLong,
      hideImage: true,
      enableAnimation: true,
      onPreviewDataFetched: (data) {
        setState(() => previewData = data);
      },
      previewData: previewData,
      text: Uri.parse(widget.url.get()).toString(),
      textWidget: authorityText,
      width: double.maxFinite,
    );

    final clickIgnored = IgnorePointer(child: preview);

    return ButtonSecondary(
      onPressed: widget.onPressed,
      fixedMaxHeight: false,
      child: SizedBox(
        width: double.infinity,
        child: clickIgnored,
      ),
    );
  }
}
