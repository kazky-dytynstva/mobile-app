import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/helper/app_update_helper.dart';
import 'package:open_store/open_store.dart';
import 'package:update_available/update_available.dart';

@LazySingleton(as: AppUpdateHelper)
class AppUpdateHelperImpl implements AppUpdateHelper {
  @override
  Future<bool> hasUpdates() async {
    try {
      final updateAvailability = await getUpdateAvailability();
      return updateAvailability.fold(
        available: () => true,
        notAvailable: () => false,
        unknown: () => false,
      );
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Unit> openStore() async {
    await OpenStore.instance.open(
      appStoreId: '1513020180',
      androidAppBundleId: 'ua.andriyantonov.tales',
    );
    return unit;
  }
}
