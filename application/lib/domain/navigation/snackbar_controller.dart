import 'package:flutter/foundation.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_name.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_name.dart';

abstract class SnackbarController {
  void showInfo({
    required String message,
    String? title,
    VoidCallback? onDismiss,
    bool? blurBackground,
    Duration? duration,
  });

  void showError({
    required String message,
    String? title,
  });

  void showCacheAudioFailed();

  void showNetworkError();

  void showThanksForRating();

  void showUndo({
    required String message,
    required VoidCallback onUndoPressed,
    String? title,
  });

  void showBringBackFavTale({
    required TaleName name,
    required VoidCallback onBringBackPressed,
  });

  void showBringBackFavPerson({
    required PersonName name,
    required VoidCallback onBringBackPressed,
  });
}
