import 'package:flutter/material.dart';
import 'package:mobile_app/presentation/extensions/post_callback.dart';
import 'package:mobile_app/presentation/resource/r.dart';

class ReadTalePageScrollProgress extends StatefulWidget {
  final ScrollController scrollController;

  const ReadTalePageScrollProgress({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<ReadTalePageScrollProgress> createState() =>
      _ReadTalePageScrollProgressState();
}

class _ReadTalePageScrollProgressState
    extends State<ReadTalePageScrollProgress> {
  double _progress = 0;

  @override
  void initState() {
    widget.scrollController.addListener(_updateProgress);
    postFrame(_updateProgress);
    super.initState();
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_updateProgress);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LinearProgressIndicator(
        value: _progress,
        backgroundColor: R.palette.transparent,
        color: R.palette.accent,
      );

  void _updateProgress() {
    if (!widget.scrollController.hasClients) {
      Future.delayed(R.durations.animShort, _updateProgress);
      return;
    }
    final value = widget.scrollController.offset /
        widget.scrollController.position.maxScrollExtent;

    _progress = value;
    setState(() {});
  }
}
