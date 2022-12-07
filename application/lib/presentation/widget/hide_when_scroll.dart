import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mobile_app/infrastructure/util/debouncer.dart';
import 'package:mobile_app/infrastructure/util/throttling.dart';
import 'package:mobile_app/presentation/resource/r.dart';

enum HideDirection {
  bottom,
  top,
}

typedef ForceShowAction = VoidCallback Function();

class HideWhenScroll extends StatefulWidget {
  final ScrollController controller;
  final Widget child;
  final Duration? showBackTimeOut;
  final HideDirection hideDirection;
  final ValueNotifier<bool>? forceShowNotifier;
  final ValueNotifier<bool>? forceHideNotifier;

  const HideWhenScroll({
    required this.controller,
    required this.child,
    this.showBackTimeOut,
    this.hideDirection = HideDirection.bottom,
    this.forceShowNotifier,
    this.forceHideNotifier,
    Key? key,
  }) : super(key: key);

  @override
  State<HideWhenScroll> createState() => _HideWhenScrollState();
}

class _HideWhenScrollState extends State<HideWhenScroll>
    with SingleTickerProviderStateMixin {
  final _throttling = Throttler(R.durations.animMiddle);
  Debouncer? _debouncer;
  late final animationController = AnimationController(
    vsync: this,
    duration: R.durations.animShort,
  );
  late final offset = Tween<Offset>(
    begin: Offset.zero,
    end: Offset(0.0, widget.hideDirection == HideDirection.bottom ? 1.0 : -1.0),
  ).animate(animationController);

  @override
  void initState() {
    widget.controller.addListener(_scrollListener);
    if (widget.showBackTimeOut != null) {
      _debouncer = Debouncer(widget.showBackTimeOut!);
    }

    widget.forceShowNotifier?.addListener(_forcedToShowListener);
    widget.forceHideNotifier?.addListener(_forcedToHideListener);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    widget.forceShowNotifier?.removeListener(_forcedToShowListener);
    widget.forceHideNotifier?.removeListener(_forcedToHideListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SlideTransition(
        position: offset,
        child: widget.child,
      );

  void _notifyScrollUp() {
    _throttling.throttle(() {
      if (!mounted) return;
      animationController.reverse();
    });
  }

  void _notifyScrollDown() {
    _throttling.throttle(() {
      if (!mounted) return;
      animationController.forward();
    });
    _debouncer?.run(_notifyScrollUp);
  }

  void _scrollListener() {
    switch (widget.controller.position.userScrollDirection) {
      case ScrollDirection.forward:
        _notifyScrollUp();
        break;
      case ScrollDirection.reverse:
        _notifyScrollDown();
        break;
      default:
        break;
    }
  }

  void _forcedToShowListener() async {
    final showNotifier = widget.forceShowNotifier;
    if (showNotifier == null) return;
    if (!showNotifier.value) return;
    widget.controller.jumpTo(widget.controller.position.pixels);
    while (!_throttling.canDoAction()) {
      await Future.delayed(R.durations.animShort);
    }
    _notifyScrollUp();
    showNotifier.value = false;
  }

  void _forcedToHideListener() async {
    final notifier = widget.forceHideNotifier;
    if (notifier == null) return;
    if (!notifier.value) return;
    widget.controller.jumpTo(widget.controller.position.pixels);
    while (!_throttling.canDoAction()) {
      await Future.delayed(R.durations.animShort);
    }
    _notifyScrollDown();
    notifier.value = false;
  }
}
