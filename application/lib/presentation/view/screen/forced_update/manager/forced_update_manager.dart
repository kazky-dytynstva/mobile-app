import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/helper/app_update_helper.dart';
import 'package:mobile_app/domain/tracking/tracker.dart';
import 'package:mobile_app/presentation/navigation/screen/screen_controller.dart';

@injectable
class ForcedUpdateManager extends Cubit<Unit> {
  final ScreenController _screenController;
  final AppUpdateHelper _appUpdateHelper;
  final Tracker _tracker;

  ForcedUpdateManager(
    this._screenController,
    this._appUpdateHelper,
    this._tracker,
  ) : super(unit);

  void onSkipPressed() {
    _tracker.event(TrackingEvents.forcedUpdateSkipPressed);
    _screenController.openHome();
  }

  void onUpdatePressed() {
    _tracker.event(TrackingEvents.forcedUpdateUpdatePressed);
    _appUpdateHelper.openStore();
  }
}
