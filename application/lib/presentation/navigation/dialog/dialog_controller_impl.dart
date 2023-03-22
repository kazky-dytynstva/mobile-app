import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/rating/rating_data.dart';
import 'package:mobile_app/domain/model/rating/rating_type.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_name.dart';
import 'package:mobile_app/data/env_config/env_config.dart';
import 'package:mobile_app/data/helper/tracking/tracker_group.dart';
import 'package:mobile_app/presentation/navigation/dialog/dialog_controller.dart';
import 'package:mobile_app/presentation/navigation/screen/context_keeper/screen_context_keeper.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/dialog/audio_countdown_dialog.dart';
import 'package:mobile_app/presentation/view/dialog/confirm_delete_all_audio_dialog.dart';
import 'package:mobile_app/presentation/view/dialog/confirm_delete_user_data_dialog.dart';
import 'package:mobile_app/presentation/view/dialog/confirm_rate_tale_dialog.dart';
import 'package:mobile_app/presentation/view/dialog/dev_dialog.dart';
import 'package:mobile_app/presentation/view/dialog/rating_explanation_dialog.dart';
import 'package:mobile_app/presentation/view/dialog/report_tale_dialog.dart';
import 'package:mobile_app/presentation/view/dialog/switch_to_wifi_dialog.dart';
import 'package:mobile_app/presentation/view/dialog/tale_more_dialog.dart';
import 'package:mobile_app/presentation/view/dialog/tale_rating_dialog.dart';
import 'package:mobile_app/presentation/view/dialog/wip_dialog.dart';

@LazySingleton(as: DialogController)
class DialogControllerImpl implements DialogController {
  final ScreenContextKeeper _contextKeeper;
  final Tracker _tracker;

  DialogControllerImpl(
    this._contextKeeper,
    this._tracker,
  );

  @override
  void showWIP() {
    final content = WipDialog(_closeDialog);
    _showBottomDialog(content);
  }

  @override
  void showDevMsg(
    String msg, {
    VoidCallback? onDismiss,
  }) {
    if (EnvConfig.isProd) {
      throw Exception('Can be used only during development');
    }
    final content = DevDialog(msg, _closeDialog);
    _showBottomDialog(content, onDismiss: onDismiss);
  }

  @override
  void showConfirmDeleteAllAudio({
    required VoidCallback onConfirmPressed,
  }) {
    _tracker.view(TrackingViews.dialogConfirmDeleteAllAudio);
    final content = ConfirmDeleteAllAudioDialog(
      onClosePressed: _closeDialog,
      onConfirmPressed: () {
        _closeDialog();
        onConfirmPressed();
      },
    );
    _showBottomDialog(content);
  }

  @override
  void showConfirmDeleteUseData({
    required VoidCallback onConfirmPressed,
  }) {
    _tracker.view(TrackingViews.dialogConfirmDeleteUserData);
    final content = ConfirmDeleteUserDataDialog(
      onClosePressed: _closeDialog,
      onConfirmPressed: () {
        _closeDialog();
        onConfirmPressed();
      },
    );
    _showBottomDialog(content);
  }

  @override
  void showSwitchToWiFi({
    required VoidCallback onContinuePressed,
  }) {
    _tracker.view(TrackingViews.dialogSwitchToWiFi);
    final content = SwitchToWiFiDialog(
      onClosePressed: _closeDialog,
      onContinuePressed: () {
        _closeDialog();
        onContinuePressed();
      },
    );
    _showBottomDialog(content);
  }

  @override
  void showTaleMore({
    required OnTaleMoreItemPressed onTaleMoreItemPressed,
  }) {
    _tracker.view(TrackingViews.dialogTaleMoreMenu);
    final dialog = TaleMoreDialog(
      onTaleMoreItemPressed: (type) {
        _closeDialog();
        _delayedResponse(() => onTaleMoreItemPressed(type));
      },
    );
    _showBottomDialog(dialog);
  }

  @override
  void showTaleReport({
    required VoidCallback onReportPressed,
  }) {
    _tracker.view(TrackingViews.dialogTaleReportIssue);
    final dialog = ReportTaleDialog(
      onClosePressed: _closeDialog,
      onReportPressed: () {
        _closeDialog();
        onReportPressed();
      },
    );
    _showBottomDialog(dialog);
  }

  @override
  void showTaleRating({
    required TaleName name,
    required RatingData data,
  }) {
    _tracker.view(TrackingViews.dialogTaleRatingDetails);
    final dialog = TaleRatingDialog(
      name: name,
      data: data,
      onInfoPressed: showRatingExplanation,
      onClosePressed: _closeDialog,
    );
    _showBottomDialog(dialog);
  }

  @override
  void showRatingExplanation() {
    _tracker.view(TrackingViews.dialogRatingExplanations);
    final dialog = RatingExplanationDialog(
      onClosePressed: _closeDialog,
    );
    _showBottomDialog(dialog);
  }

  @override
  void showConfirmRateTale(
    RatingType type, {
    required VoidCallback onConfirmPressed,
  }) {
    _tracker.view(TrackingViews.dialogConfirmRateTale);
    final dialog = ConfirmRateTaleDialog(
      type: type,
      onConfirmPressed: () {
        _closeDialog();
        _delayedResponse(onConfirmPressed);
      },
      onClosePressed: _closeDialog,
    );
    _showBottomDialog(dialog);
  }

  @override
  void showAudioCountdown(
    Duration remainingTime,
    OnCountdownTimePressed onPressed,
  ) {
    final event = (remainingTime == Duration.zero)
        ? TrackingViews.dialogAudioCountdownChoose
        : TrackingViews.dialogAudioCountdownActive;
    _tracker.view(event);
    final dialog = AudiCountdownDialog(
      remainingTime,
      (time) {
        _closeDialog();
        _delayedResponse(() => onPressed(time));
      },
      _closeDialog,
    );
    _showBottomDialog(dialog);
  }

  void _closeDialog() {
    final context = _contextKeeper.topScreenContext;
    if (context == null) return;
    final router = AutoRouter.of(context);
    router.pop();
  }

  Future<void> _showBottomDialog(
    Widget content, {
    VoidCallback? onDismiss,
  }) async {
    final context = _contextKeeper.topScreenContext;
    if (context == null) return;
    final padding = EdgeInsets.symmetric(
      horizontal: R.dimen.dialogOutsidePadding,
    );

    final contentView = Container(
      margin: padding,
      decoration: BoxDecoration(
          color: R.palette.background,
          borderRadius: R.styles.dialogTopBorder,
          border: Border.all(color: R.palette.divider)),
      child: Material(
        color: Colors.transparent,
        child: SafeArea(
          child: content,
        ),
      ),
    );

    final transparent = R.palette.transparent;

    return showModalBottomSheet(
      context: context,
      backgroundColor: transparent,
      isScrollControlled: true,
      builder: (builder) => R.device.isMobile
          ? contentView
          : InkWell(
              splashColor: transparent,
              highlightColor: transparent,
              onTap: _closeDialog,
              child: contentView,
            ),
    ).then((_) {
      if (onDismiss != null) {
        _delayedResponse(onDismiss);
      }
    });
  }

  void _delayedResponse(VoidCallback callback) =>
      Future.delayed(R.durations.animShort).then((value) => callback());
}
