import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'active_screen_notifier.dart';

@LazySingleton(as: ActiveScreenNotifier)
class ActiveScreenNotifierImpl
    extends NavigatorObserver
    implements ActiveScreenNotifier {
  final observer = NavigatorObserver();
  final _requests = List<_Request>.empty();

  String? _currentScreenName;

  @override
  NavigatorObserver get screenObserver => this;

  Future get _actionDelay => Future.delayed(const Duration(milliseconds: 300));

  @override
  void waitingFor({
    required Type requester,
    required String screen,
    required VoidCallback action,
  }) {
    if (_currentScreenName == screen) {
      _actionDelay.then((value) => action());
    } else if (_isRequesterUnique(requester)) {
      final data = _Request(requester, screen, action);
      _requests.add(data);
    }
  }

  @override
  void didPush(Route<dynamic> route, Route? previousRoute) {
    _check(route);
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _check(previousRoute);
    super.didPop(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    _check(newRoute);
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    _check(previousRoute);
    super.didRemove(route, previousRoute);
  }

  void _check(Route? route) {
    if (route == null || !_isScreenRoute(route)) {
      return;
    }
    _currentScreenName = route.settings.name;
    final requests = _getRequestsForScreen(_currentScreenName!);
    _notify(requests);
  }

  bool _isScreenRoute(Route? route) {
    final name = route?.settings.name;
    return route != null &&
        name != null &&
        name.isNotEmpty &&
        name.contains("/");
  }

  bool _isRequesterUnique(Type requester) =>
      _requests.firstWhereOrNull((it) => it.requester == requester) == null;

  Iterable<_Request> _getRequestsForScreen(String screenName) =>
      _requests.where((it) => it.screenName == screenName);

  void _notify(Iterable<_Request> requests) async {
    if (requests.isEmpty) {
      return;
    }
    await _actionDelay;
    requests.toList().reversed.forEach((element) {
      _requests.remove(element);
      element.action();
    });
  }
}

class _Request {
  final Type requester;
  final String screenName;
  final VoidCallback action;

  _Request(
    this.requester,
    this.screenName,
    this.action,
  );
}
