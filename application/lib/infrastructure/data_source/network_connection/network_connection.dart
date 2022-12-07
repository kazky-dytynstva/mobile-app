import 'package:mobile_app/domain/model/connection_type/connection_type.dart';

abstract class NetworkConnection {
  Future<bool> isConnected();

  Future<ConnectionType> getType();

  void notifyWhenOnline(Function callback);
}
