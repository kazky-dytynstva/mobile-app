import 'package:mobile_app/domain/value_objects/svg_asset_icon.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/view/snackbar/base_snackbar.dart';

class ThanksForRatingTaleSnackbar extends BaseSnackbar {
  @override
  String? get title => R.strings.general.thankYou;

  @override
  String get message => R.strings.tale.thanksForRatingMsg;

  @override
  SvgAssetIcon get icon => R.assets.icons.info;

  @override
  Duration get duration => const Duration(seconds: 5);

  @override
  bool get routeBlur => true;
}
