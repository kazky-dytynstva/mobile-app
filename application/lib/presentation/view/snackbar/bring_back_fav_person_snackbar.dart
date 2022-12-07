import 'package:mobile_app/domain/model/person/value_objects/person_name.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/snackbar/undo_snackbar.dart';

class BringBackFavPersonSnackbar extends UndoSnackbar {
  BringBackFavPersonSnackbar({
    required PersonName name,
    required super.onUndoPressed,
  }) : super(
          title: name.get(),
          message: R.strings.talesList.bringBackFavPersonMessage,
        );
}
