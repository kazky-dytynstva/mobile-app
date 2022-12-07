import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/snackbar/error_snackbar.dart';

class CacheAudioFailedSnackbar extends ErrorSnackbar {
  CacheAudioFailedSnackbar()
      : super(
          title: R.strings.general.oops,
          message: R.strings.settings.canNotCacheAudioCheckNetwork,
        );

  @override
  Duration get duration => const Duration(seconds: 5);
}
