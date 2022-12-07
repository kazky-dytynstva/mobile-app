import 'package:flutter/material.dart';

abstract class ActiveScreenNotifier {
  NavigatorObserver get screenObserver;

  ///[screenName] - should be one from [Routes]
  void waitingFor({
    required String screen,
    required Type requester,
    required VoidCallback action,
  });
}
