import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'screen_context_keeper.dart';

@LazySingleton(as: ScreenContextKeeper)
class ScreenContextKeeperImpl implements ScreenContextKeeper {
  final _states = <State>[];

  @override
  BuildContext? get topScreenContext {
    final reversed = _states.reversed;
    for (final state in reversed) {
      if (state.mounted) {
        return state.context;
      } else {
        _states.removeLast();
      }
    }
    return null;
  }

  @override
  void addState(State<StatefulWidget> state) {
    if (_states.contains(state)) return;
    _states.add(state);
  }

  @override
  void removeState(State<StatefulWidget> state) {
    _states.remove(state);
  }
}
