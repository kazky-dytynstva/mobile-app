import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/connection_type/connection_type.dart';

import 'network_connection.dart';

@Singleton(as: NetworkConnection)
class NetworkConnectionImpl implements NetworkConnection {
  final Connectivity _connectivity;
  final Mapper<ConnectivityResult, ConnectionType> _mapper;

  NetworkConnectionImpl(
    this._connectivity,
    this._mapper,
  );

  final _listOfWaiters = <Function>[];

  StreamSubscription? _subscription;

  @override
  Future<ConnectionType> getType() async {
    final result = await _connectivity.checkConnectivity();
    final filtered = _filter(result);
    return _mapper.map(filtered);
  }

  @override
  Future<bool> isConnected() async => !(await getType()).isNone;

  @override
  void notifyWhenOnline(Function callback) {
    _listOfWaiters.add(callback);
    _startWaiting();
  }

  void _startWaiting() {
    if (_subscription != null) {
      return;
    }
    _subscription = _connectivity.onConnectivityChanged.listen((event) {
      final filtered = _filter(event);
      final type = _mapper.map(filtered);
      if (type.isNone == true) return;
      _notifyAllWaiters();
      _subscription!.cancel();
      _subscription = null;
    });
  }

  void _notifyAllWaiters() {
    for (final callback in _listOfWaiters) {
      callback();
    }
    _listOfWaiters.clear();
  }

  ConnectivityResult _filter(List<ConnectivityResult> results) {
    if (results.length == 1) {
      return results.first;
    }
    final hasWiFi = results.contains(ConnectivityResult.wifi);
    return hasWiFi ? ConnectivityResult.wifi : ConnectivityResult.mobile;
  }
}
