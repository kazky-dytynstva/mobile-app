import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mobile_app/domain/value_objects/image_url.dart';
import 'package:mobile_app/data/data_source/network_connection/network_connection.dart';
import 'package:mobile_app/data/di/dependency_injection.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/svg_widget.dart';

typedef WidgetBuilder = Widget Function(BuildContext context);

class NetworkImage extends StatefulWidget {
  final ImageUrl url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final WidgetBuilder? createPlaceholder;
  final WidgetBuilder? createError;

  const NetworkImage(
    this.url, {
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.createPlaceholder,
    this.createError,
    Key? key,
  }) : super(key: key);

  @override
  State<NetworkImage> createState() => _NetworkImageState();
}

class _NetworkImageState extends State<NetworkImage> {
  final Key _keyFailed = const ValueKey("failed");
  final Key _keyLoading = const ValueKey("loading");

  late Key _imageKey;

  @override
  void initState() {
    _imageKey = _keyLoading;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => CachedNetworkImage(
        key: _keyLoading,
        imageUrl: widget.url.get(),
        width: widget.width,
        height: widget.height,
        placeholder: _createPlaceholder,
        errorWidget: _createError,
        fit: widget.fit,
      );

  Widget _createPlaceholder(BuildContext _, String __) {
    if (widget.createPlaceholder != null) {
      return widget.createPlaceholder!.call(_);
    }
    return Container(color: R.palette.background);
  }

  Widget _createError(BuildContext _, String __, ___) {
    if (_imageKey != _keyFailed) {
      _wait();
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _imageKey = _keyFailed;
        setState(() {});
      });
    }
    if (widget.createError != null) {
      return widget.createError!.call(_);
    }
    return SvgWidget.graphic(R.assets.graphics.error);
  }

  void _wait() {
    getIt<NetworkConnection>().notifyWhenOnline(() {
      if (!mounted) return;
      _imageKey = _keyLoading;
      setState(() {});
    });
  }
}
