import 'package:mobile_app/domain/model/tale/value_object/tale_name.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/snackbar/undo_snackbar.dart';

class BringBackFavTaleSnackbar extends UndoSnackbar {
  BringBackFavTaleSnackbar({
    required TaleName name,
    required super.onUndoPressed,
  }) : super(
          title: '"${name.get()}"',
          message: R.strings.talesList.bringBackFavTaleMessage,
        );
}
