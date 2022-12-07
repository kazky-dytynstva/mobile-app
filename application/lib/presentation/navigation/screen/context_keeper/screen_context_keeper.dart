import 'package:flutter/material.dart';
import 'package:mobile_app/presentation/view/screen/screen_mixin.dart';

abstract class ScreenContextKeeper {
  BuildContext? get topScreenContext;

  void addState(ScreenWidgetState state);

  void removeState(ScreenWidgetState state);
}
