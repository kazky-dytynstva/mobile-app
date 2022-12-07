import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/snackbar/error_snackbar.dart';

class NetworkErrorErrorSnackbar extends ErrorSnackbar {
  NetworkErrorErrorSnackbar()
      : super(
          message: R.strings.splash.getInitialContentFailed.noInternet,
        );
}
