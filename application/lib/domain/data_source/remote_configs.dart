import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/domain/value_objects/url_string.dart';
import 'package:mobile_app/data/data_source/remote_configs/dto/forced_update_info/forced_update_info_dto.dart';
import 'package:mobile_app/data/data_source/remote_configs/dto/menu_dynamic_item/menu_dynamic_item_dto.dart';

abstract class RemoteConfigs {
  Future<bool> init({required Duration expiration});

  ForcedUpdateInfoDto? getForcedUpdateInfo();

  MenuDynamicItemDto? getMenuDynamicItem();

  UrlString getDonateUrl();

  UrlString getPrivacyPolicyUrl();

  UrlString getTermsAndConditionsUrl();

  StringSingleLine getDevEmail();

  UrlString shareAppLink();
}
