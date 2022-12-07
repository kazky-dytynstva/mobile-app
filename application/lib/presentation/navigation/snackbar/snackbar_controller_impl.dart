import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_name.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_name.dart';
import 'package:mobile_app/domain/navigation/snackbar_controller.dart';
import 'package:mobile_app/presentation/navigation/screen/context_keeper/screen_context_keeper.dart';
import 'package:mobile_app/presentation/view/snackbar/base_snackbar.dart';
import 'package:mobile_app/presentation/view/snackbar/bring_back_fav_person_snackbar.dart';
import 'package:mobile_app/presentation/view/snackbar/bring_back_fav_tale_snackbar.dart';
import 'package:mobile_app/presentation/view/snackbar/error_snackbar.dart';
import 'package:mobile_app/presentation/view/snackbar/cache_audio_failed_snackbar.dart';
import 'package:mobile_app/presentation/view/snackbar/info_snackbar.dart';
import 'package:mobile_app/presentation/view/snackbar/network_error_snackbar.dart';
import 'package:mobile_app/presentation/view/snackbar/thanks_for_rating_tale_snackbar.dart';
import 'package:mobile_app/presentation/view/snackbar/undo_snackbar.dart';

@LazySingleton(as: SnackbarController)
class SnackbarControllerImpl implements SnackbarController {
  final ScreenContextKeeper _contextKeeper;

  SnackbarControllerImpl(
    this._contextKeeper,
  );

  @override
  void showInfo({
    required String message,
    String? title,
    VoidCallback? onDismiss,
  }) =>
      _show(InfoSnackbar(message: message, title: title, onDismiss: onDismiss));

  @override
  void showError({
    required String message,
    String? title,
  }) =>
      _show(ErrorSnackbar(message: message, title: title));

  @override
  void showCacheAudioFailed() => _show(CacheAudioFailedSnackbar());

  @override
  void showNetworkError() => _show(NetworkErrorErrorSnackbar());

  @override
  void showThanksForRating() => _show(ThanksForRatingTaleSnackbar());

  @override
  void showBringBackFavTale({
    required TaleName name,
    required VoidCallback onBringBackPressed,
  }) {
    final snack = BringBackFavTaleSnackbar(
      name: name,
      onUndoPressed: onBringBackPressed,
    );
    _show(snack);
  }

  @override
  void showBringBackFavPerson({
    required PersonName name,
    required VoidCallback onBringBackPressed,
  }) {
    final snack = BringBackFavPersonSnackbar(
      name: name,
      onUndoPressed: onBringBackPressed,
    );
    _show(snack);
  }

  @override
  void showUndo({
    required String message,
    required VoidCallback onUndoPressed,
    String? title,
  }) {
    final snack = UndoSnackbar(
      message: message,
      title: title,
      onUndoPressed: onUndoPressed,
    );
    _show(snack);
  }

  void _show(
    BaseSnackbar snackbar,
  ) =>
      snackbar.show(_contextKeeper.topScreenContext!);
}
