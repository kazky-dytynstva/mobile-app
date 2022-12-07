import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/connection_type/connection_type.dart';

@Singleton(as: Mapper)
class ConnectionTypeMapper
    implements Mapper<ConnectivityResult, ConnectionType> {
  @override
  ConnectionType map(ConnectivityResult input) {
    switch (input) {
      case ConnectivityResult.wifi:
        return ConnectionType.wifi;
      case ConnectivityResult.mobile:
        return ConnectionType.mobile;
      case ConnectivityResult.none:
        return ConnectionType.none;
      default:
        throw Exception();
    }
  }
}
