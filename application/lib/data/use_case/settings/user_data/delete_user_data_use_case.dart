import 'package:equatable/equatable.dart';
import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/data/use_case/settings/user_data/set_crash_logging_enabled_use_case.dart';
import 'package:mobile_app/data/use_case/settings/user_data/set_tracking_enabled_use_case.dart';

@Injectable(as: UseCase)
class DeleteUserDataUseCase extends UseCase<Dry, DeleteUserDataUseCaseOutput> {
  final FirebaseInstallations _firebaseInstallations;
  final UseCase<bool, SetCrashLoggingEnabledOutput>
      _setCrashLoggingEnabledUseCase;
  final UseCase<bool, SetTrackingEnabledOutput> _setTrackingEnabledUseCase;

  DeleteUserDataUseCase(
    this._firebaseInstallations,
    this._setCrashLoggingEnabledUseCase,
    this._setTrackingEnabledUseCase,
  );

  @override
  Stream<DeleteUserDataUseCaseOutput> transaction(Dry input) async* {
    await _firebaseInstallations.delete();

    final crashLoggingOutput = await _setCrashLoggingEnabledUseCase.call(false);
    final trackingOutput = await _setTrackingEnabledUseCase.call(false);

    yield DeleteUserDataUseCaseOutput(
      isCrashLoggingEnabled: crashLoggingOutput.isEnabled,
      isTrackingEnabled: trackingOutput.isEnabled,
    );
  }
}

@immutable
class DeleteUserDataUseCaseOutput extends Equatable {
  final bool isTrackingEnabled;
  final bool isCrashLoggingEnabled;

  const DeleteUserDataUseCaseOutput({
    required this.isTrackingEnabled,
    required this.isCrashLoggingEnabled,
  });

  @override
  List<Object> get props => [
        isTrackingEnabled,
        isCrashLoggingEnabled,
      ];
}
