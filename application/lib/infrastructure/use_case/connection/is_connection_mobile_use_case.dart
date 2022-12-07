import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/connection_type/connection_type.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/infrastructure/data_source/network_connection/network_connection.dart';

@Injectable(as: UseCase)
class IsConnectionMobileUseCase extends UseCase<Dry, IsConnectionMobileOutput> {
  final NetworkConnection _connection;

  IsConnectionMobileUseCase(this._connection);

  @override
  Stream<IsConnectionMobileOutput> transaction(Dry input) async* {
    final type = await _connection.getType();

    yield IsConnectionMobileOutput(type.isMobile);
  }
}

@immutable
class IsConnectionMobileOutput {
  final bool isMobile;

  const IsConnectionMobileOutput(this.isMobile);
}
