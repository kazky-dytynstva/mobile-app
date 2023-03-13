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
    return _mapper.map(result);
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
      if (!_mapper.map(event).isNone) {
        _notifyAllWaiters();
        _subscription!.cancel();
        _subscription = null;
      }
    });
  }

  void _notifyAllWaiters() {
    for (final callback in _listOfWaiters) {
      callback();
    }
    _listOfWaiters.clear();
  }
}
