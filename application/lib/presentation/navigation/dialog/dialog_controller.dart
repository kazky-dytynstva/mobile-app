import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/rating/rating_data.dart';
import 'package:mobile_app/domain/model/rating/rating_type.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_name.dart';
import 'package:mobile_app/presentation/view/dialog/audio_countdown_dialog.dart';
import 'package:mobile_app/presentation/view/dialog/tale_more_dialog.dart';

abstract class DialogController {
  void showWIP();

  void showDevMsg(
    String msg, {
    VoidCallback? onDismiss,
  });

  void showConfirmDeleteAllAudio({
    required VoidCallback onConfirmPressed,
  });

  void showConfirmDeleteUseData({
    required VoidCallback onConfirmPressed,
  });

  void showSwitchToWiFi({
    required VoidCallback onContinuePressed,
  });

  void showAudioCountdown(
    Duration remainingTime,
    OnCountdownTimePressed onPressed,
  );

  void showConfirmRateTale(
    RatingType type, {
    required VoidCallback onConfirmPressed,
  });

  void showTaleMore({
    required OnTaleMoreItemPressed onTaleMoreItemPressed,
  });

  void showTaleReport({
    required VoidCallback onReportPressed,
  });

  void showRatingExplanation();

  void showTaleRating({
    required TaleName name,
    required RatingData data,
  });
}
