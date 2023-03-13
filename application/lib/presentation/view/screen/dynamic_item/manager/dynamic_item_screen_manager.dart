import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/tracking/tracker.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/url_string.dart';
import 'package:mobile_app/data/use_case/helper/open_url_use_case.dart';
import 'package:mobile_app/presentation/navigation/screen/screen_controller.dart';

@injectable
class DynamicItemScreenManager extends Cubit<Unit> {
  final ScreenController _screenController;
  final Tracker _tracker;
  final UseCase<UrlString, OpenUrlOutput> _openUrlUseCase;

  DynamicItemScreenManager(
    this._openUrlUseCase,
    this._tracker,
    this._screenController,
  ) : super(unit);

  void onBackPressed() => _screenController.pop();

  void onCTAPressed(UrlString url) {
    _tracker.event(TrackingEvents.dynamicItemCTAPressed);
    _openUrlUseCase.call(url);
  }
}
