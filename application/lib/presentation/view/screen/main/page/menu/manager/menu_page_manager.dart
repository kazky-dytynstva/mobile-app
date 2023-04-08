import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/data_source/remote_configs.dart';
import 'package:mobile_app/domain/model/app_version/app_version.dart';
import 'package:mobile_app/domain/model/menu_dynamic_item/menu_dynamic_item_data.dart';
import 'package:mobile_app/domain/model/show_dot/show_dot_type.dart';
import 'package:mobile_app/domain/tracking/tracker.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/url_string.dart';
import 'package:mobile_app/data/env_config/env_config.dart';
import 'package:mobile_app/data/use_case/email/add_tale_use_case.dart';
import 'package:mobile_app/data/use_case/email/write_dev_use_case.dart';
import 'package:mobile_app/data/use_case/helper/open_url_use_case.dart';
import 'package:mobile_app/data/use_case/share/share_app_use_case.dart';
import 'package:mobile_app/presentation/navigation/screen/screen_controller.dart';
import 'package:mobile_app/presentation/view/screen/main/page/menu/model/menu_page_item_type.dart';

part 'menu_page_manager.freezed.dart';

part 'menu_page_state.dart';

@injectable
class MenuPageManager extends Cubit<MenuPageState> {
  final ScreenController _screenController;
  final UseCase<UrlString, OpenUrlOutput> _openUrlUseCase;
  final UseCase<Dry, WriteDevOutput> _writeDevUseCase;
  final UseCase<Dry, AddTaleOutput> _addTaleUseCase;
  final UseCase<Dry, ShareAppOutput> _shareAppUseCase;
  final UseCase<Dry, AppVersion> _getAppVersionUseCase;
  final UseCase<ShowDotType, Dry> _setShowDotTypeWatchedUseCase;
  final UseCase<ShowDotType, bool> _listenShowDotTypeUseCase;
  final UseCase<Dry, Option<MenuDynamicItemData>> _getMenuDynamicItemUseCase;
  final RemoteConfigs _remoteConfigs;
  final UseCase<MenuDynamicItemData, Dry> _onDynamicItemClickedUseCase;
  final Tracker _tracker;

  MenuPageManager(
    this._screenController,
    this._writeDevUseCase,
    this._addTaleUseCase,
    this._shareAppUseCase,
    this._getAppVersionUseCase,
    this._openUrlUseCase,
    this._remoteConfigs,
    this._listenShowDotTypeUseCase,
    this._setShowDotTypeWatchedUseCase,
    this._getMenuDynamicItemUseCase,
    this._onDynamicItemClickedUseCase,
    this._tracker,
  ) : super(const MenuPageState.initial()) {
    _init();
  }

  final _subscriptionGroup = UseCaseSubscriptionGroup();

  MenuPageStateReady get _stateReady => state as MenuPageStateReady;

  @override
  Future<void> close() async {
    await _subscriptionGroup.cancel();
    return super.close();
  }

  void _init() async {
    final version = await _getAppVersionUseCase.call(dry);
    final dynamicItemOption = await _getMenuDynamicItemUseCase.call(dry);

    emit(MenuPageState.ready(
      appVersion: version,
      showDotWhatsNew: false,
      showDotDonation: false,
      dynamicItemDataOption: dynamicItemOption,
    ));
    _addListeners();
  }

  void onItemPressed(MenuPageItemType itemType) {
    TrackingEvent? event;
    switch (itemType) {
      case MenuPageItemType.donate:
        event = TrackingEvents.menuPageDonatePressed;
        _donatePressed();
        break;
      case MenuPageItemType.addTale:
        event = TrackingEvents.menuPageDonatePressed;
        _addTalePressed();
        break;
      case MenuPageItemType.writeDev:
        event = TrackingEvents.menuPageWriteDevPressed;
        _writeDevPressed();
        break;
      case MenuPageItemType.shareApp:
        event = TrackingEvents.menuPageShareAppPressed;
        _shareAppPressed();
        break;
      case MenuPageItemType.settings:
        event = TrackingEvents.menuPageSettingsPressed;
        _screenController.openSettings();
        break;
      case MenuPageItemType.debug:
        if (EnvConfig.isProd) return;
        _screenController.openDebug();
        break;
      case MenuPageItemType.whatsNew:
        event = TrackingEvents.menuPageWhatsNewPressed;
        _screenController.openWhatsNew();
        break;
      case MenuPageItemType.dynamic:
        event = TrackingEvents.menuPageDynamicItemPressed;
        _dynamicItemPressed();
        break;
    }
    if (event != null) {
      _tracker.event(event);
    }
  }

  void _writeDevPressed() => _writeDevUseCase.call(dry);

  void _addTalePressed() => _addTaleUseCase.call(dry);

  void _shareAppPressed() => _shareAppUseCase.call(dry);

  void _dynamicItemPressed() {
    if (_stateReady.dynamicItemDataOption.isNone()) return;
    final data =
        (_stateReady.dynamicItemDataOption as Some<MenuDynamicItemData>).value;

    _onDynamicItemClickedUseCase.call(data);
  }

  void _donatePressed() {
    _openUrlUseCase.call(_remoteConfigs.getDonateUrl());
    _setShowDotTypeWatchedUseCase.call(ShowDotType.donation);
  }

  void _addListeners() {
    final whatsNewSubscription = _listenShowDotTypeUseCase.listen(
      ShowDotType.whatsNew,
      (showDot) => emit(_stateReady.copyWith(showDotWhatsNew: showDot)),
    );
    _subscriptionGroup.add(whatsNewSubscription);

    final donationSubscription = _listenShowDotTypeUseCase.listen(
      ShowDotType.donation,
      (showDot) => emit(_stateReady.copyWith(showDotDonation: showDot)),
    );
    _subscriptionGroup.add(donationSubscription);
  }
}
