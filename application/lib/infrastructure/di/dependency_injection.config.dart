// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i130;

import 'package:auto_route/auto_route.dart' as _i70;
import 'package:connectivity_plus/connectivity_plus.dart' as _i9;
import 'package:dartz/dartz.dart' as _i170;
import 'package:dio/dio.dart' as _i16;
import 'package:dto/dto.dart' as _i26;
import 'package:firebase_analytics/firebase_analytics.dart' as _i151;
import 'package:firebase_app_installations/firebase_app_installations.dart'
    as _i14;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i136;
import 'package:firebase_database/firebase_database.dart' as _i13;
import 'package:firebase_remote_config/firebase_remote_config.dart' as _i137;
import 'package:flutter/material.dart' as _i154;
import 'package:flutter/services.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i15;
import 'package:injectable/injectable.dart' as _i2;
import 'package:just_audio/just_audio.dart' as _i8;
import 'package:mobile_app/domain/data_source/remote_configs.dart' as _i157;
import 'package:mobile_app/domain/data_source/storage_local/app_state_storage.dart'
    as _i135;
import 'package:mobile_app/domain/data_source/storage_local/people_storage.dart'
    as _i66;
import 'package:mobile_app/domain/data_source/storage_local/settings_storage.dart'
    as _i73;
import 'package:mobile_app/domain/data_source/storage_local/tale_list_storage.dart'
    as _i83;
import 'package:mobile_app/domain/data_source/storage_local/tale_storage.dart'
    as _i89;
import 'package:mobile_app/domain/feature_flag/feature_flag_provider.dart'
    as _i104;
import 'package:mobile_app/domain/helper/app_update_helper.dart' as _i5;
import 'package:mobile_app/domain/helper/countdown_service.dart' as _i194;
import 'package:mobile_app/domain/helper/email_sender.dart' as _i10;
import 'package:mobile_app/domain/helper/person_sorter.dart' as _i68;
import 'package:mobile_app/domain/helper/share_helper.dart' as _i75;
import 'package:mobile_app/domain/helper/tale_filter.dart' as _i81;
import 'package:mobile_app/domain/helper/tale_sorter.dart' as _i87;
import 'package:mobile_app/domain/mapper/mapper.dart' as _i17;
import 'package:mobile_app/domain/model/app_theme/app_theme.dart' as _i55;
import 'package:mobile_app/domain/model/app_version/app_version.dart' as _i45;
import 'package:mobile_app/domain/model/changed_data/changed_data.dart'
    as _i119;
import 'package:mobile_app/domain/model/connection_type/connection_type.dart'
    as _i21;
import 'package:mobile_app/domain/model/forced_update_info/forced_update_info.dart'
    as _i51;
import 'package:mobile_app/domain/model/menu_dynamic_item/menu_dynamic_item_data.dart'
    as _i42;
import 'package:mobile_app/domain/model/person/person.dart' as _i100;
import 'package:mobile_app/domain/model/person/value_objects/person_id.dart'
    as _i116;
import 'package:mobile_app/domain/model/player/loop_mode.dart' as _i32;
import 'package:mobile_app/domain/model/player/playlist_data.dart' as _i129;
import 'package:mobile_app/domain/model/rating/rating_data.dart' as _i59;
import 'package:mobile_app/domain/model/rating/rating_type.dart' as _i61;
import 'package:mobile_app/domain/model/settings/text_scale_factor.dart'
    as _i57;
import 'package:mobile_app/domain/model/show_dot/show_dot_type.dart' as _i47;
import 'package:mobile_app/domain/model/sort_and_filter/filter_type.dart'
    as _i18;
import 'package:mobile_app/domain/model/sort_and_filter/sort_type.dart' as _i23;
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart'
    as _i96;
import 'package:mobile_app/domain/model/tale/tale.dart' as _i108;
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart'
    as _i133;
import 'package:mobile_app/domain/model/tale_crew/tale_crew.dart' as _i125;
import 'package:mobile_app/domain/model/tale_crew/tale_crew_role.dart' as _i36;
import 'package:mobile_app/domain/model/tale_tag/tale_tag.dart' as _i34;
import 'package:mobile_app/domain/navigation/snackbar_controller.dart' as _i77;
import 'package:mobile_app/domain/repository/people_repository.dart' as _i112;
import 'package:mobile_app/domain/repository/tale_repository.dart' as _i85;
import 'package:mobile_app/domain/tracking/tracker.dart' as _i201;
import 'package:mobile_app/domain/use_case/usecase.dart' as _i93;
import 'package:mobile_app/domain/value_objects/file_path.dart' as _i12;
import 'package:mobile_app/domain/value_objects/int_positive.dart' as _i53;
import 'package:mobile_app/domain/value_objects/string_single_line.dart'
    as _i24;
import 'package:mobile_app/domain/value_objects/svg_asset_graphic.dart' as _i19;
import 'package:mobile_app/domain/value_objects/url_string.dart' as _i186;
import 'package:mobile_app/infrastructure/data_source/network_connection/network_connection.dart'
    as _i63;
import 'package:mobile_app/infrastructure/data_source/network_connection/network_connection_impl.dart'
    as _i64;
import 'package:mobile_app/infrastructure/data_source/package_data/package_data.dart'
    as _i110;
import 'package:mobile_app/infrastructure/data_source/package_data/package_data_impl.dart'
    as _i111;
import 'package:mobile_app/infrastructure/data_source/remote_api/api_client_impl.dart'
    as _i191;
import 'package:mobile_app/infrastructure/data_source/remote_api/base/api_client.dart'
    as _i190;
import 'package:mobile_app/infrastructure/data_source/remote_api/parser/network_response_parser.dart'
    as _i155;
import 'package:mobile_app/infrastructure/data_source/remote_api/parser/network_response_parser_impl.dart'
    as _i156;
import 'package:mobile_app/infrastructure/data_source/remote_configs/dto/forced_update_info/forced_update_info_dto.dart'
    as _i50;
import 'package:mobile_app/infrastructure/data_source/remote_configs/dto/menu_dynamic_item/menu_dynamic_item_dto.dart'
    as _i41;
import 'package:mobile_app/infrastructure/data_source/remote_configs/remote_configs_impl.dart'
    as _i158;
import 'package:mobile_app/infrastructure/data_source/storage_local/people/entity/person_entity.dart'
    as _i38;
import 'package:mobile_app/infrastructure/data_source/storage_local/people/people_storage_impl.dart'
    as _i67;
import 'package:mobile_app/infrastructure/data_source/storage_local/settings/settings_storage_impl.dart'
    as _i74;
import 'package:mobile_app/infrastructure/data_source/storage_local/tale/entity/crew/crew_entity.dart'
    as _i124;
import 'package:mobile_app/infrastructure/data_source/storage_local/tale/entity/rating/rating_entity.dart'
    as _i27;
import 'package:mobile_app/infrastructure/data_source/storage_local/tale/entity/tale_entity.dart'
    as _i30;
import 'package:mobile_app/infrastructure/data_source/storage_local/tale/helper/tale_entity_update_helper.dart'
    as _i79;
import 'package:mobile_app/infrastructure/data_source/storage_local/tale/helper/tale_entity_update_helper_impl.dart'
    as _i80;
import 'package:mobile_app/infrastructure/data_source/storage_local/tale/tale_storage_impl.dart'
    as _i90;
import 'package:mobile_app/infrastructure/data_source/storage_local/tale_list/tale_list_storage_impl.dart'
    as _i84;
import 'package:mobile_app/infrastructure/di/module/firebase.dart' as _i232;
import 'package:mobile_app/infrastructure/di/module/network.dart' as _i231;
import 'package:mobile_app/infrastructure/di/module/storage.dart' as _i229;
import 'package:mobile_app/infrastructure/di/module/utils.dart' as _i230;
import 'package:mobile_app/infrastructure/feature_flag/dev_feature_provider.dart'
    as _i105;
import 'package:mobile_app/infrastructure/feature_flag/prod_feature_provider.dart'
    as _i150;
import 'package:mobile_app/infrastructure/helper/analytic/crash_analytic.dart'
    as _i148;
import 'package:mobile_app/infrastructure/helper/analytic/crash_analytic_impl.dart'
    as _i149;
import 'package:mobile_app/infrastructure/helper/app_update_helper_impl.dart'
    as _i6;
import 'package:mobile_app/infrastructure/helper/audio_cache/audio_cache_helper.dart'
    as _i102;
import 'package:mobile_app/infrastructure/helper/audio_cache/audio_cache_helper_impl.dart'
    as _i103;
import 'package:mobile_app/infrastructure/helper/countdown_service/countdown_service_impl.dart'
    as _i195;
import 'package:mobile_app/infrastructure/helper/email/email_sender_impl.dart'
    as _i11;
import 'package:mobile_app/infrastructure/helper/logger/logger.dart' as _i152;
import 'package:mobile_app/infrastructure/helper/logger/logger_impl.dart'
    as _i153;
import 'package:mobile_app/infrastructure/helper/person_sorter/person_sorter.dart'
    as _i69;
import 'package:mobile_app/infrastructure/helper/player/audio_player.dart'
    as _i192;
import 'package:mobile_app/infrastructure/helper/player/audio_player_impl.dart'
    as _i193;
import 'package:mobile_app/infrastructure/helper/share/share_helper_impl.dart'
    as _i76;
import 'package:mobile_app/infrastructure/helper/tale_filter_and_sort/tale_filter.dart'
    as _i82;
import 'package:mobile_app/infrastructure/helper/tale_filter_and_sort/tale_sorter.dart'
    as _i88;
import 'package:mobile_app/infrastructure/helper/tracking/tracker_group.dart'
    as _i159;
import 'package:mobile_app/infrastructure/helper/url_creator/url_creator.dart'
    as _i91;
import 'package:mobile_app/infrastructure/helper/url_creator/url_creator_impl.dart'
    as _i92;
import 'package:mobile_app/infrastructure/mapper/app_theme/app_theme_to_db_key_mapper.dart'
    as _i56;
import 'package:mobile_app/infrastructure/mapper/connectivity_type/connection_type_mapper.dart'
    as _i22;
import 'package:mobile_app/infrastructure/mapper/filter_type/filter_type_to_string_mapper.dart'
    as _i49;
import 'package:mobile_app/infrastructure/mapper/menu/menu_dynamic_item_dto_to_model_mapper.dart'
    as _i43;
import 'package:mobile_app/infrastructure/mapper/other/file_size_to_string_mapper.dart'
    as _i54;
import 'package:mobile_app/infrastructure/mapper/other/forced_update_info_dto_to_model_mapper.dart'
    as _i52;
import 'package:mobile_app/infrastructure/mapper/people/crew_role_to_plural_label_mapper.dart'
    as _i40;
import 'package:mobile_app/infrastructure/mapper/people/crew_role_to_singular_label_mapper.dart'
    as _i37;
import 'package:mobile_app/infrastructure/mapper/people/dto_to_entity_mapper.dart'
    as _i39;
import 'package:mobile_app/infrastructure/mapper/people/entity_to_model_mapper.dart'
    as _i109;
import 'package:mobile_app/infrastructure/mapper/player/loop_mode_to_db_key_mapper.dart'
    as _i33;
import 'package:mobile_app/infrastructure/mapper/player/tale_audio_to_audio_source_mapper.dart'
    as _i131;
import 'package:mobile_app/infrastructure/mapper/rating/rating_dto_to_entity_mapper.dart'
    as _i28;
import 'package:mobile_app/infrastructure/mapper/rating/rating_entity_to_data_mapper.dart'
    as _i60;
import 'package:mobile_app/infrastructure/mapper/rating/rating_type_to_name_mapper.dart'
    as _i62;
import 'package:mobile_app/infrastructure/mapper/sort_type/sort_type_to_string_mapper.dart'
    as _i44;
import 'package:mobile_app/infrastructure/mapper/storage/app_version_to_string_mapper.dart'
    as _i46;
import 'package:mobile_app/infrastructure/mapper/storage/show_dot_type_to_db_key_mapper.dart'
    as _i48;
import 'package:mobile_app/infrastructure/mapper/tale/data/tale_entity_to_tales_page_item_data_mapper.dart'
    as _i138;
import 'package:mobile_app/infrastructure/mapper/tale/dto_to_entity_mapper.dart'
    as _i31;
import 'package:mobile_app/infrastructure/mapper/tale/tale_chapter_entity_to_tale_chapter_mapper.dart'
    as _i107;
import 'package:mobile_app/infrastructure/mapper/tale/tale_crew_entity_to_tale_crew_mapper.dart'
    as _i126;
import 'package:mobile_app/infrastructure/mapper/tale/tale_entity_to_author_mapper.dart'
    as _i128;
import 'package:mobile_app/infrastructure/mapper/tale/tale_entity_to_tale_mapper.dart'
    as _i127;
import 'package:mobile_app/infrastructure/mapper/tale_tag/string_to_tale_tag_mapper.dart'
    as _i35;
import 'package:mobile_app/infrastructure/mapper/text_scale_factor/text_scale_factor_to_db_key_mapper.dart'
    as _i58;
import 'package:mobile_app/infrastructure/repository/people_repository_impl.dart'
    as _i113;
import 'package:mobile_app/infrastructure/repository/tale_repository_impl.dart'
    as _i86;
import 'package:mobile_app/infrastructure/use_case/app_start_count/get_app_start_count.dart'
    as _i180;
import 'package:mobile_app/infrastructure/use_case/app_start_count/increment_app_starts_count_use_case.dart'
    as _i167;
import 'package:mobile_app/infrastructure/use_case/audio/cache_all_audio_use_case.dart'
    as _i227;
import 'package:mobile_app/infrastructure/use_case/audio/cache_audio_use_case.dart'
    as _i208;
import 'package:mobile_app/infrastructure/use_case/audio/delete_all_audio_tales_use_case.dart'
    as _i160;
import 'package:mobile_app/infrastructure/use_case/audio/get_cached_all_audio_info_use_case.dart'
    as _i114;
import 'package:mobile_app/infrastructure/use_case/audio/get_next_playlist_item_use_case.dart'
    as _i209;
import 'package:mobile_app/infrastructure/use_case/audio/stop_playing_use_case.dart'
    as _i207;
import 'package:mobile_app/infrastructure/use_case/connection/is_connection_mobile_use_case.dart'
    as _i97;
import 'package:mobile_app/infrastructure/use_case/email/add_tale_use_case.dart'
    as _i178;
import 'package:mobile_app/infrastructure/use_case/email/report_tale_use_case.dart'
    as _i179;
import 'package:mobile_app/infrastructure/use_case/email/write_dev_use_case.dart'
    as _i181;
import 'package:mobile_app/infrastructure/use_case/helper/open_url_use_case.dart'
    as _i187;
import 'package:mobile_app/infrastructure/use_case/init_remote_configs/get_forced_update_info_use_case.dart'
    as _i162;
import 'package:mobile_app/infrastructure/use_case/init_remote_configs/init_remote_configs.dart'
    as _i161;
import 'package:mobile_app/infrastructure/use_case/loop_mode/save_loop_mode_use_case.dart'
    as _i189;
import 'package:mobile_app/infrastructure/use_case/loop_mode/set_initial_loop_mode_use_case.dart'
    as _i215;
import 'package:mobile_app/infrastructure/use_case/menu/get_menu_dynamic_item_data_use_case.dart'
    as _i171;
import 'package:mobile_app/infrastructure/use_case/menu/listen_show_dot_type_use_case.dart'
    as _i143;
import 'package:mobile_app/infrastructure/use_case/menu/listen_show_menu_dot_use_case.dart'
    as _i139;
import 'package:mobile_app/infrastructure/use_case/menu/set_shot_doty_type_watched_use_case.dart'
    as _i144;
import 'package:mobile_app/infrastructure/use_case/people/get_all_fav_people_use_case.dart'
    as _i122;
import 'package:mobile_app/infrastructure/use_case/people/get_people_by_role_use_case.dart'
    as _i188;
import 'package:mobile_app/infrastructure/use_case/people/get_people_page_tab_data_list_use_case.dart'
    as _i120;
import 'package:mobile_app/infrastructure/use_case/people/get_person_tab_data_use_case.dart'
    as _i142;
import 'package:mobile_app/infrastructure/use_case/people/get_person_tales_use_case.dart'
    as _i185;
import 'package:mobile_app/infrastructure/use_case/people/listen_people_changes_use_case.dart'
    as _i123;
import 'package:mobile_app/infrastructure/use_case/people/sort_people_use_case.dart'
    as _i101;
import 'package:mobile_app/infrastructure/use_case/person/change_person_fav_use_case.dart'
    as _i166;
import 'package:mobile_app/infrastructure/use_case/person/get_person_use_case.dart'
    as _i117;
import 'package:mobile_app/infrastructure/use_case/person/listen_person_changes_use_case.dart'
    as _i118;
import 'package:mobile_app/infrastructure/use_case/prepare_content/prepare_content_use_case.dart'
    as _i206;
import 'package:mobile_app/infrastructure/use_case/settings/listen_app_theme_changes_use_case.dart'
    as _i174;
import 'package:mobile_app/infrastructure/use_case/settings/listen_text_scale_factor_changes_use_case.dart'
    as _i175;
import 'package:mobile_app/infrastructure/use_case/settings/set_app_theme_use_case.dart'
    as _i99;
import 'package:mobile_app/infrastructure/use_case/settings/set_text_scale_factor_use_case.dart'
    as _i98;
import 'package:mobile_app/infrastructure/use_case/settings/user_data/delete_user_data_use_case.dart'
    as _i212;
import 'package:mobile_app/infrastructure/use_case/settings/user_data/get_crash_logging_enabled_use_case.dart'
    as _i145;
import 'package:mobile_app/infrastructure/use_case/settings/user_data/get_tracking_enabled_use_case.dart'
    as _i146;
import 'package:mobile_app/infrastructure/use_case/settings/user_data/set_crash_logging_enabled_use_case.dart'
    as _i147;
import 'package:mobile_app/infrastructure/use_case/settings/user_data/set_tracking_enabled_use_case.dart'
    as _i173;
import 'package:mobile_app/infrastructure/use_case/share/share_app_use_case.dart'
    as _i168;
import 'package:mobile_app/infrastructure/use_case/storage/check_app_version_changed_use_case.dart'
    as _i140;
import 'package:mobile_app/infrastructure/use_case/tale/change_tale_fav.dart'
    as _i176;
import 'package:mobile_app/infrastructure/use_case/tale/get_random_tale_name_and_author_use_case.dart'
    as _i121;
import 'package:mobile_app/infrastructure/use_case/tale/get_tale_use_case.dart'
    as _i134;
import 'package:mobile_app/infrastructure/use_case/tale/listen_current_playing_use_case.dart'
    as _i211;
import 'package:mobile_app/infrastructure/use_case/tale/listen_playlist_tale_changed_use_case.dart'
    as _i213;
import 'package:mobile_app/infrastructure/use_case/tale/listen_tale_changes_use_case.dart'
    as _i132;
import 'package:mobile_app/infrastructure/use_case/tale/mark_tale_watched_use_case.dart'
    as _i177;
import 'package:mobile_app/infrastructure/use_case/tale/rate_tale_use_case.dart'
    as _i210;
import 'package:mobile_app/infrastructure/use_case/tale/save_last_read_position.dart'
    as _i169;
import 'package:mobile_app/infrastructure/use_case/tale/search_tales_use_case.dart'
    as _i172;
import 'package:mobile_app/infrastructure/use_case/tale/set_audio_playlist_use_case.dart'
    as _i214;
import 'package:mobile_app/infrastructure/use_case/tale_list/get_all_tales.dart'
    as _i184;
import 'package:mobile_app/infrastructure/use_case/tale_list/get_random_tale_use_case.dart'
    as _i183;
import 'package:mobile_app/infrastructure/use_case/tale_list/listen_all_tales_change.dart'
    as _i182;
import 'package:mobile_app/infrastructure/use_case/tale_sort_and_filter/filter_and_sort_tales_use_case.dart'
    as _i95;
import 'package:mobile_app/infrastructure/use_case/tale_sort_and_filter/get_sort_and_filter_items_use_case.dart'
    as _i141;
import 'package:mobile_app/infrastructure/use_case/tale_sort_and_filter/get_tale_sort_and_filter_type.dart'
    as _i164;
import 'package:mobile_app/infrastructure/use_case/tale_sort_and_filter/listen_tale_filter_type_change.dart'
    as _i163;
import 'package:mobile_app/infrastructure/use_case/tale_sort_and_filter/listen_tale_sort_type_change.dart'
    as _i165;
import 'package:mobile_app/infrastructure/use_case/tale_sort_and_filter/save_sort_and_filter_use_case.dart'
    as _i94;
import 'package:mobile_app/infrastructure/use_case/utils/get_app_version_use_case.dart'
    as _i115;
import 'package:mobile_app/presentation/navigation/dialog/dialog_controller.dart'
    as _i196;
import 'package:mobile_app/presentation/navigation/dialog/dialog_controller_impl.dart'
    as _i197;
import 'package:mobile_app/presentation/navigation/screen/active_screen_notifier/active_screen_notifier.dart'
    as _i3;
import 'package:mobile_app/presentation/navigation/screen/active_screen_notifier/active_screen_notifier_impl.dart'
    as _i4;
import 'package:mobile_app/presentation/navigation/screen/context_keeper/screen_context_keeper.dart'
    as _i71;
import 'package:mobile_app/presentation/navigation/screen/context_keeper/screen_context_keeper_impl.dart'
    as _i72;
import 'package:mobile_app/presentation/navigation/screen/screen_controller.dart'
    as _i198;
import 'package:mobile_app/presentation/navigation/screen/screen_controller_impl.dart'
    as _i199;
import 'package:mobile_app/presentation/navigation/snackbar/snackbar_controller_impl.dart'
    as _i78;
import 'package:mobile_app/presentation/util/mapper/filter_type/filter_type_to_icon_path_mapper.dart'
    as _i20;
import 'package:mobile_app/presentation/util/mapper/filter_type/filter_type_to_name_mapper.dart'
    as _i29;
import 'package:mobile_app/presentation/util/mapper/sort_type/sort_type_to_name_mapper.dart'
    as _i25;
import 'package:mobile_app/presentation/view/screen/dynamic_item/manager/dynamic_item_screen_manager.dart'
    as _i217;
import 'package:mobile_app/presentation/view/screen/feature_flags/manager/feature_flags_screen_manager.dart'
    as _i106;
import 'package:mobile_app/presentation/view/screen/forced_update/manager/forced_update_manager.dart'
    as _i219;
import 'package:mobile_app/presentation/view/screen/home/manager/home_screen_manager.dart'
    as _i220;
import 'package:mobile_app/presentation/view/screen/home/page/fav/manager/fav_page_manager.dart'
    as _i218;
import 'package:mobile_app/presentation/view/screen/home/page/menu/manager/menu_page_manager.dart'
    as _i222;
import 'package:mobile_app/presentation/view/screen/home/page/people/manager/people_page_manager.dart'
    as _i223;
import 'package:mobile_app/presentation/view/screen/home/page/tales/manager/tales_page_manager.dart'
    as _i205;
import 'package:mobile_app/presentation/view/screen/person/manager/person_screen_manager.dart'
    as _i224;
import 'package:mobile_app/presentation/view/screen/search_tale/manager/search_tale_manager.dart'
    as _i200;
import 'package:mobile_app/presentation/view/screen/settings/manager/settings_screen_manager.dart'
    as _i228;
import 'package:mobile_app/presentation/view/screen/splash/manager/splash_screen_manager.dart'
    as _i202;
import 'package:mobile_app/presentation/view/screen/tale/manager/tale_screen_manager.dart'
    as _i226;
import 'package:mobile_app/presentation/view/screen/tale/page/listen/manager/listen_page_manager.dart'
    as _i221;
import 'package:mobile_app/presentation/view/screen/tale/page/read/manager/read_page_manager.dart'
    as _i225;
import 'package:mobile_app/presentation/view/screen/tale_crew/manager/tale_crew_screen_manager.dart'
    as _i203;
import 'package:mobile_app/presentation/view/screen/tale_sort_and_filter/manager/tale_sort_and_filter_manager.dart'
    as _i204;
import 'package:mobile_app/presentation/view/screen/whats_new/manager/whats_new_screen_manager.dart'
    as _i216;
import 'package:package_info/package_info.dart' as _i65;

const String _dev = 'dev';
const String _internal = 'internal';
const String _prod = 'prod';

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final moduleUtils = _$ModuleUtils();
    final networkModule = _$NetworkModule();
    final storageModule = _$StorageModule();
    final moduleFirebase = _$ModuleFirebase();
    gh.lazySingleton<_i3.ActiveScreenNotifier>(
        () => _i4.ActiveScreenNotifierImpl());
    gh.lazySingleton<_i5.AppUpdateHelper>(() => _i6.AppUpdateHelperImpl());
    gh.lazySingleton<_i7.AssetBundle>(() => moduleUtils.assetBundle);
    gh.singleton<_i8.AudioPlayer>(moduleUtils.audioPlayer);
    gh.factory<_i9.Connectivity>(() => networkModule.connectivity());
    gh.lazySingleton<_i10.EmailSender>(() => _i11.EmailSenderImpl());
    await gh.singletonAsync<_i12.FilePath>(
      () => storageModule.cacheDirPath,
      instanceName: 'cacheDirPath',
      preResolve: true,
    );
    gh.lazySingleton<_i13.FirebaseDatabase>(
        () => moduleFirebase.firebaseDatabase);
    gh.lazySingleton<_i14.FirebaseInstallations>(
        () => moduleFirebase.firebaseInstallations);
    await gh.singletonAsync<_i15.HiveInterface>(
      () => storageModule
          .getHive(gh<_i12.FilePath>(instanceName: 'cacheDirPath')),
      preResolve: true,
    );
    gh.lazySingleton<List<_i16.Interceptor>>(
        () => networkModule.createDioInterceptors());
    gh.lazySingleton<_i17.Mapper<_i18.TaleFilterType, _i19.SvgAssetGraphic>>(
        () => _i20.FilterTypeToStringMapper());
    gh.singleton<_i17.Mapper<_i9.ConnectivityResult, _i21.ConnectionType>>(
        _i22.ConnectionTypeMapper());
    gh.lazySingleton<_i17.Mapper<_i23.TaleSortType, _i24.StringSingleLine>>(
        () => _i25.SortTypeToStringMapper());
    gh.lazySingleton<_i17.Mapper<_i26.RatingDto, _i27.RatingEntity>>(
        () => _i28.RatingDtoToEntityMapper());
    gh.lazySingleton<_i17.Mapper<_i18.TaleFilterType, _i24.StringSingleLine>>(
        () => _i29.FilterTypeToStringMapper());
    gh.lazySingleton<_i17.Mapper<_i26.TaleDto, _i30.TaleEntity>>(
        () => _i31.TaleDtoToEntityMapper());
    gh.singleton<_i17.Mapper<String?, _i32.PlayerLoopMode>>(
        _i33.DbKeyToLoopModeMapper());
    gh.singleton<_i17.Mapper<_i32.PlayerLoopMode, String>>(
        _i33.LoopModeToDbKeyMapper());
    gh.lazySingleton<_i17.Mapper<_i34.TaleTag, String>>(
        () => _i35.TaleTagToStringMapper());
    gh.lazySingleton<_i17.Mapper<String, _i34.TaleTag>>(
        () => _i35.StringToTaleCategoryMapper());
    gh.lazySingleton<_i17.Mapper<_i36.TaleCrewRole, _i24.StringSingleLine>>(
      () => _i37.CrewRoleToSingularLabelMapper(),
      instanceName: 'singular',
    );
    gh.lazySingleton<_i17.Mapper<_i26.PersonDto, _i38.PersonEntity>>(
        () => _i39.PersonDtoToEntityMapper());
    gh.lazySingleton<_i17.Mapper<_i36.TaleCrewRole, _i24.StringSingleLine>>(
      () => _i40.CrewRoleToPluralLabelMapper(),
      instanceName: 'plural',
    );
    gh.factory<_i17.Mapper<_i41.MenuDynamicItemDto, _i42.MenuDynamicItemData>>(
        () => _i43.MenuDynamicItemDtoToModelMapper());
    gh.singleton<_i17.Mapper<String?, _i23.TaleSortType>>(
        _i44.DbKeyToTaleSortTypeMapper());
    gh.singleton<_i17.Mapper<_i23.TaleSortType, String>>(
        _i44.TaleSortTypeToDbKeyMapper());
    gh.lazySingleton<_i17.Mapper<_i45.AppVersion, String>>(
        () => _i46.AppVersionToStringMapper());
    gh.singleton<_i17.Mapper<_i47.ShowDotType, String>>(
        _i48.ShowDotTypeToDbKeyMapper());
    gh.singleton<_i17.Mapper<String?, _i18.TaleFilterType>>(
        _i49.DbKeyToTaleFilterTypeMapper());
    gh.singleton<_i17.Mapper<_i18.TaleFilterType, String>>(
        _i49.TaleFilterTypeToDbKeyMapper());
    gh.factory<_i17.Mapper<_i50.ForcedUpdateInfoDto, _i51.ForcedUpdateInfo>>(
        () => _i52.ForcedUpdateInfoDtoToModelMapper());
    gh.lazySingleton<_i17.Mapper<_i53.IntPositive, String>>(
        () => _i54.FileSizeToStringMapper());
    gh.singleton<_i17.Mapper<String?, _i55.AppTheme>>(
        _i56.DbKeyToAppThemeMapper());
    gh.singleton<_i17.Mapper<_i55.AppTheme, String>>(
        _i56.AppThemeToDbKeyMapper());
    gh.singleton<_i17.Mapper<String?, _i57.TextScaleFactor>>(
        _i58.DbKeyToTextScaleFactorMapper());
    gh.singleton<_i17.Mapper<_i57.TextScaleFactor, String>>(
        _i58.TextScaleFactorToDbKeyMapper());
    gh.lazySingleton<_i17.Mapper<_i27.RatingEntity, _i59.RatingData>>(
        () => _i60.RatingEntityToDataMapper());
    gh.lazySingleton<_i17.Mapper<_i61.RatingType, String>>(
        () => _i62.RatingTypeToNameMapper());
    gh.singleton<_i63.NetworkConnection>(_i64.NetworkConnectionImpl(
      gh<_i9.Connectivity>(),
      gh<_i17.Mapper<_i9.ConnectivityResult, _i21.ConnectionType>>(),
    ));
    await gh.singletonAsync<_i65.PackageInfo>(
      () => moduleUtils.packageInfo,
      preResolve: true,
    );
    gh.lazySingleton<_i66.PeopleStorage>(
        () => _i67.PeopleStorageImpl(gh<_i15.HiveInterface>()));
    gh.lazySingleton<_i68.PersonSorter>(() => _i69.PersonSorterImpl());
    gh.singleton<_i70.RootStackRouter>(moduleUtils.appRouter);
    gh.lazySingleton<_i71.ScreenContextKeeper>(
        () => _i72.ScreenContextKeeperImpl());
    gh.lazySingleton<_i73.SettingsStorage>(() => _i74.SettingsStorageImpl(
          gh<_i15.HiveInterface>(),
          gh<_i17.Mapper<_i55.AppTheme, String>>(),
          gh<_i17.Mapper<String?, _i55.AppTheme>>(),
          gh<_i17.Mapper<String?, _i57.TextScaleFactor>>(),
          gh<_i17.Mapper<_i57.TextScaleFactor, String>>(),
        ));
    gh.lazySingleton<_i75.ShareHelper>(() => _i76.ShareHelperImpl());
    gh.lazySingleton<_i77.SnackbarController>(
        () => _i78.SnackbarControllerImpl(gh<_i71.ScreenContextKeeper>()));
    gh.factory<_i79.TaleEntityUpdateHelper>(
        () => _i80.TaleEntityUpdateHelperImpl());
    gh.lazySingleton<_i81.TaleFilter>(() => _i82.TaleFilterImpl());
    gh.lazySingleton<_i83.TaleListStorage>(() => _i84.TaleListStorageImpl(
          gh<_i15.HiveInterface>(),
          gh<_i17.Mapper<_i18.TaleFilterType, String>>(),
          gh<_i17.Mapper<String?, _i18.TaleFilterType>>(),
          gh<_i17.Mapper<_i23.TaleSortType, String>>(),
          gh<_i17.Mapper<String?, _i23.TaleSortType>>(),
        ));
    gh.lazySingleton<_i85.TaleRepository>(() => _i86.TaleRepositoryImpl());
    gh.lazySingleton<_i87.TaleSorter>(() => _i88.TaleSorterImpl());
    gh.lazySingleton<_i89.TaleStorage>(() => _i90.TaleStorageImpl(
          gh<_i15.HiveInterface>(),
          gh<_i79.TaleEntityUpdateHelper>(),
        ));
    gh.lazySingleton<_i91.UrlCreator>(() => _i92.UrlCreatorImpl());
    gh.factory<_i93.UseCase<_i94.SaveSortAndFilterInput, _i93.Dry>>(
        () => _i94.SaveSortAndFilterUseCase(
              gh<_i83.TaleListStorage>(),
              gh<_i87.TaleSorter>(),
            ));
    gh.factory<
        _i93.UseCase<_i95.FilterAndSortTalesInput,
            List<_i96.TalesPageItemData>>>(() => _i95.FilterAndSortTalesUseCase(
          gh<_i81.TaleFilter>(),
          gh<_i87.TaleSorter>(),
        ));
    gh.factory<_i93.UseCase<_i93.Dry, _i97.IsConnectionMobileOutput>>(
        () => _i97.IsConnectionMobileUseCase(gh<_i63.NetworkConnection>()));
    gh.factory<_i93.UseCase<_i57.TextScaleFactor, _i93.Dry>>(
        () => _i98.SetTextScaleFactorUseCase(gh<_i73.SettingsStorage>()));
    gh.factory<_i93.UseCase<_i55.AppTheme, _i93.Dry>>(
        () => _i99.SetAppThemeUseCase(gh<_i73.SettingsStorage>()));
    gh.lazySingleton<_i93.UseCase<List<_i100.Person>, _i93.Dry>>(
        () => _i101.SortPeopleUseCase(gh<_i68.PersonSorter>()));
    gh.lazySingleton<_i102.AudioCacheHelper>(() => _i103.AudioCacheHelperImpl(
        gh<_i12.FilePath>(instanceName: 'cacheDirPath')));
    gh.lazySingleton<_i16.Dio>(() => networkModule.createDio(
          gh<List<_i16.Interceptor>>(),
          gh<_i91.UrlCreator>(),
        ));
    gh.lazySingleton<_i104.FeatureFlagProvider>(
      () => _i105.DevFeatureFlagProvider(gh<_i15.HiveInterface>()),
      registerFor: {
        _dev,
        _internal,
      },
    );
    gh.factory<_i106.FeatureFlagsScreenManager>(
        () => _i106.FeatureFlagsScreenManager(gh<_i104.FeatureFlagProvider>()));
    gh.lazySingleton<
            _i17.Mapper<_i107.TaleChapterEntityMapperInput, _i108.TaleChapter>>(
        () => _i107.TaleChapterEntityToTaleChapterMapper(
              gh<_i91.UrlCreator>(),
              gh<_i102.AudioCacheHelper>(),
            ));
    gh.lazySingleton<_i17.Mapper<_i38.PersonEntity, _i100.Person>>(
        () => _i109.PersonEntityToModelMapper(gh<_i91.UrlCreator>()));
    gh.lazySingleton<_i110.PackageData>(
        () => _i111.PackageDataImpl(gh<_i65.PackageInfo>()));
    gh.lazySingleton<_i112.PeopleRepository>(() => _i113.PeopleRepositoryImpl(
          gh<_i66.PeopleStorage>(),
          gh<_i17.Mapper<_i38.PersonEntity, _i100.Person>>(),
        ));
    gh.factory<_i93.UseCase<_i93.Dry, _i114.GetCachedAudioInfoOutput>>(
        () => _i114.GetCachedAudioInfoUseCase(
              gh<_i17.Mapper<_i53.IntPositive, String>>(),
              gh<_i17.Mapper<_i34.TaleTag, String>>(),
              gh<_i102.AudioCacheHelper>(),
              gh<_i89.TaleStorage>(),
            ));
    gh.factory<_i93.UseCase<_i93.Dry, _i45.AppVersion>>(
        () => _i115.GetAppVersionUseCase(gh<_i110.PackageData>()));
    gh.factory<_i93.UseCase<_i116.PersonId, _i117.GetPersonOutput>>(
        () => _i117.GetPersonUseCase(
              gh<_i66.PeopleStorage>(),
              gh<_i17.Mapper<_i38.PersonEntity, _i100.Person>>(),
            ));
    gh.factory<
            _i93.UseCase<_i118.ListenPersonChangesInput,
                _i119.ChangedData<_i100.Person, _i116.PersonId>>>(
        () => _i118.ListenPersonChangesUseCase(
              gh<_i66.PeopleStorage>(),
              gh<_i17.Mapper<_i38.PersonEntity, _i100.Person>>(),
            ));
    gh.factory<
            _i93.UseCase<_i120.GetPeoplePageTabDataListInput,
                _i120.GetPeoplePageTabDataListOutput>>(
        () => _i120.GetPeoplePageTabDataListUseCase(
              gh<_i17.Mapper<_i36.TaleCrewRole, _i24.StringSingleLine>>(
                  instanceName: 'plural'),
              gh<_i93.UseCase<List<_i100.Person>, _i93.Dry>>(),
            ));
    gh.factory<_i93.UseCase<_i93.Dry, _i121.GetRandomTaleNameAndAuthorOutput>>(
        () => _i121.GetRandomTaleNameAndAuthorUseCase(
              gh<_i89.TaleStorage>(),
              gh<_i112.PeopleRepository>(),
            ));
    gh.factory<_i93.UseCase<_i93.Dry, _i122.GetAllFavPeopleOutput>>(
        () => _i122.GetAllFavPeopleUseCase(
              gh<_i66.PeopleStorage>(),
              gh<_i17.Mapper<_i38.PersonEntity, _i100.Person>>(),
            ));
    gh.factory<_i93.UseCase<_i93.Dry, _i123.ListenPeopleChangesOutput>>(
        () => _i123.ListenPeopleChangesUseCase(
              gh<_i66.PeopleStorage>(),
              gh<_i17.Mapper<_i38.PersonEntity, _i100.Person>>(),
            ));
    gh.lazySingleton<_i17.Mapper<_i124.TaleCrewEntity?, _i125.TaleCrew?>>(
        () => _i126.TaleCrewEntityToTaleCrew(gh<_i112.PeopleRepository>()));
    gh.lazySingleton<_i17.Mapper<_i30.TaleEntity, _i108.Tale>>(
        () => _i127.TaleEntityToTaleMapper(
              gh<_i17.Mapper<String, _i34.TaleTag>>(),
              gh<_i17.Mapper<_i124.TaleCrewEntity?, _i125.TaleCrew?>>(),
              gh<
                  _i17.Mapper<_i107.TaleChapterEntityMapperInput,
                      _i108.TaleChapter>>(),
              gh<_i17.Mapper<_i27.RatingEntity, _i59.RatingData>>(),
            ));
    gh.singleton<_i17.Mapper<_i30.TaleEntity, _i24.StringSingleLine>>(
        _i128.TaleEntityToAuthorMapper(gh<_i112.PeopleRepository>()));
    gh.lazySingleton<
            _i17.Mapper<_i129.PlaylistItemData,
                _i130.Future<_i8.IndexedAudioSource>>>(
        () => _i131.TaleAudioToAudioSourceMapper(
              gh<_i89.TaleStorage>(),
              gh<_i17.Mapper<_i30.TaleEntity, _i24.StringSingleLine>>(),
            ));
    gh.lazySingleton<_i17.Mapper<String, _i45.AppVersion>>(
        () => _i46.StringToAppVersionToMapper(gh<_i110.PackageData>()));
    gh.factory<
            _i93.UseCase<_i132.ListenTaleChangesInput,
                _i119.ChangedData<_i108.Tale, _i133.TaleId>>>(
        () => _i132.ListenTaleChangesUseCase(
              gh<_i89.TaleStorage>(),
              gh<_i17.Mapper<_i30.TaleEntity, _i108.Tale>>(),
            ));
    gh.factory<_i93.UseCase<_i133.TaleId, _i134.GetTaleOutput>>(
        () => _i134.GetTaleUseCase(
              gh<_i89.TaleStorage>(),
              gh<_i17.Mapper<_i30.TaleEntity, _i108.Tale>>(),
            ));
    gh.lazySingleton<_i135.AppStateStorage>(() => storageModule.getAppStorage(
          gh<_i15.HiveInterface>(),
          gh<_i17.Mapper<_i32.PlayerLoopMode, String>>(),
          gh<_i17.Mapper<String?, _i32.PlayerLoopMode>>(),
          gh<_i17.Mapper<_i45.AppVersion, String>>(),
          gh<_i17.Mapper<String, _i45.AppVersion>>(),
          gh<_i17.Mapper<_i47.ShowDotType, String>>(),
        ));
    await gh.lazySingletonAsync<_i136.FirebaseCrashlytics>(
      () => moduleFirebase.getFirebaseCrashlytics(gh<_i135.AppStateStorage>()),
      preResolve: true,
    );
    await gh.lazySingletonAsync<_i137.FirebaseRemoteConfig>(
      () =>
          moduleFirebase.firebaseRemoteConfig(gh<_i136.FirebaseCrashlytics>()),
      preResolve: true,
    );
    gh.singleton<_i17.Mapper<_i30.TaleEntity, _i96.TalesPageItemData>>(
        _i138.TaleEntityToTaleListItemMapper(
      gh<_i17.Mapper<String, _i34.TaleTag>>(),
      gh<_i17.Mapper<_i30.TaleEntity, _i24.StringSingleLine>>(),
      gh<_i91.UrlCreator>(),
      gh<_i102.AudioCacheHelper>(),
      gh<_i17.Mapper<_i27.RatingEntity, _i59.RatingData>>(),
    ));
    gh.factory<_i93.UseCase<_i93.Dry, _i139.ListenShowMenuDotOutput>>(
        () => _i139.ListenShowMenuDotUseCase(
              gh<_i135.AppStateStorage>(),
              gh<_i104.FeatureFlagProvider>(),
            ));
    gh.factory<_i93.UseCase<_i93.Dry, _i140.CheckAppVersionChangedOutput>>(
        () => _i140.CheckAppVersionChangedUseCase(
              gh<_i135.AppStateStorage>(),
              gh<_i93.UseCase<_i93.Dry, _i45.AppVersion>>(),
            ));
    gh.factory<_i93.UseCase<_i93.Dry, _i141.GetSortAndFilterItemsOutput>>(
        () => _i141.GetSortAndFilterItemsUseCase(
              gh<_i17.Mapper<_i30.TaleEntity, _i96.TalesPageItemData>>(),
              gh<_i89.TaleStorage>(),
              gh<_i17.Mapper<_i18.TaleFilterType, _i24.StringSingleLine>>(),
              gh<_i17.Mapper<_i23.TaleSortType, _i24.StringSingleLine>>(),
              gh<_i17.Mapper<_i18.TaleFilterType, _i19.SvgAssetGraphic>>(),
              gh<_i81.TaleFilter>(),
            ));
    gh.factory<
        _i93.UseCase<_i142.GetPersonTabDataInput,
            _i142.GetPersonTabDataOutput>>(() => _i142.GetPersonTabDataUseCase(
          gh<_i17.Mapper<_i30.TaleEntity, _i96.TalesPageItemData>>(),
          gh<_i17.Mapper<_i36.TaleCrewRole, _i24.StringSingleLine>>(
              instanceName: 'singular'),
        ));
    gh.factory<_i93.UseCase<_i47.ShowDotType, bool>>(
        () => _i143.ListenShowDotTypeUseCase(gh<_i135.AppStateStorage>()));
    gh.factory<_i93.UseCase<_i47.ShowDotType, _i93.Dry>>(
        () => _i144.SetShowDotTypeWatchedUseCase(gh<_i135.AppStateStorage>()));
    gh.factory<_i93.UseCase<_i93.Dry, _i145.GetCrashLoggingEnabledOutput>>(
        () => _i145.GetCrashLoggingEnabledUseCase(gh<_i135.AppStateStorage>()));
    gh.factory<_i93.UseCase<_i93.Dry, _i146.GetTrackingEnabledOutput>>(
        () => _i146.GetTrackingEnabledUseCase(gh<_i135.AppStateStorage>()));
    gh.factory<_i93.UseCase<bool, _i147.SetCrashLoggingEnabledOutput>>(
        () => _i147.SetCrashLoggingEnabledUseCase(
              gh<_i136.FirebaseCrashlytics>(),
              gh<_i135.AppStateStorage>(),
            ));
    gh.singleton<_i148.CrashAnalytic>(
        _i149.CrashAnalyticIml(gh<_i136.FirebaseCrashlytics>()));
    gh.lazySingleton<_i104.FeatureFlagProvider>(
      () => _i150.StoreFeatureFlagProvider(gh<_i137.FirebaseRemoteConfig>()),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i151.FirebaseAnalytics>(
        () => moduleFirebase.firebaseAnalytics(
              gh<_i136.FirebaseCrashlytics>(),
              gh<_i135.AppStateStorage>(),
            ));
    gh.lazySingleton<_i152.Logger>(
        () => _i153.LoggerImpl(gh<_i148.CrashAnalytic>()));
    gh.factory<_i154.NavigatorObserver>(() => moduleFirebase
        .analyticsNavigationObserver(gh<_i151.FirebaseAnalytics>()));
    gh.lazySingleton<_i155.NetworkResponseParser>(
        () => _i156.NetworkResponseParserImpl(gh<_i148.CrashAnalytic>()));
    gh.lazySingleton<_i157.RemoteConfigs>(() => _i158.RemoteConfigsImpl(
          gh<_i137.FirebaseRemoteConfig>(),
          gh<_i152.Logger>(),
          gh<_i148.CrashAnalytic>(),
        ));
    gh.lazySingleton<_i159.Tracker>(
        () => moduleUtils.tracker(gh<_i151.FirebaseAnalytics>()));
    gh.factory<_i93.UseCase<_i93.Dry, _i160.DeleteAllAudioTalesOutput>>(
        () => _i160.DeleteAllAudioTalesUseCase(
              gh<_i102.AudioCacheHelper>(),
              gh<_i17.Mapper<_i34.TaleTag, String>>(),
              gh<_i89.TaleStorage>(),
              gh<_i152.Logger>(),
            ));
    gh.factory<_i93.UseCase<_i93.Dry, _i161.InitRemoteConfigsOutput>>(
        () => _i161.InitRemoteConfigsUseCase(
              gh<_i157.RemoteConfigs>(),
              gh<_i152.Logger>(),
            ));
    gh.factory<_i93.UseCase<_i93.Dry, _i51.ForcedUpdateInfo?>>(() =>
        _i162.GetForcedUpdateInfoUseCase(
          gh<_i157.RemoteConfigs>(),
          gh<_i152.Logger>(),
          gh<_i17.Mapper<_i50.ForcedUpdateInfoDto, _i51.ForcedUpdateInfo>>(),
          gh<_i110.PackageData>(),
          gh<_i5.AppUpdateHelper>(),
        ));
    gh.factory<_i93.UseCase<_i93.Dry, _i18.TaleFilterType>>(
        () => _i163.ListenFilterChangeUseCase(
              gh<_i83.TaleListStorage>(),
              gh<_i152.Logger>(),
            ));
    gh.factory<_i93.UseCase<_i93.Dry, _i164.GetTaleSortAndFilterTypesOutput>>(
        () => _i164.GetTaleSortAndFilterTypesUseCase(
              gh<_i83.TaleListStorage>(),
              gh<_i152.Logger>(),
            ));
    gh.factory<_i93.UseCase<_i93.Dry, _i23.TaleSortType>>(
        () => _i165.ListenSortChangeUseCase(
              gh<_i83.TaleListStorage>(),
              gh<_i152.Logger>(),
            ));
    gh.factory<_i93.UseCase<_i166.ChangePersonFavInput, _i93.Dry>>(
        () => _i166.ChangePersonFavUseCase(
              gh<_i66.PeopleStorage>(),
              gh<_i152.Logger>(),
            ));
    gh.factory<_i93.UseCase<_i93.Dry, _i167.IncrementAppStartsCountOutput>>(
        () => _i167.IncrementAppStartsCountUseCase(
              gh<_i135.AppStateStorage>(),
              gh<_i152.Logger>(),
            ));
    gh.factory<_i93.UseCase<_i93.Dry, _i168.ShareAppOutput>>(
        () => _i168.ShareAppUseCase(
              gh<_i75.ShareHelper>(),
              gh<_i157.RemoteConfigs>(),
            ));
    gh.factory<_i93.UseCase<_i169.SaveLastReadPositionUseCaseInput, _i93.Dry>>(
        () => _i169.SaveLastReadPositionUseCase(
              gh<_i89.TaleStorage>(),
              gh<_i152.Logger>(),
            ));
    gh.factory<
        _i93
            .UseCase<_i93.Dry, _i170.Option<_i42.MenuDynamicItemData>>>(() =>
        _i171.GetMenuDynamicItemDataUseCase(
          gh<_i157.RemoteConfigs>(),
          gh<_i152.Logger>(),
          gh<_i17.Mapper<_i41.MenuDynamicItemDto, _i42.MenuDynamicItemData>>(),
        ));
    gh.factory<_i93.UseCase<_i24.StringSingleLine, _i172.SearchTalesOutput>>(
        () => _i172.SearchTalesUseCase(
              gh<_i89.TaleStorage>(),
              gh<_i17.Mapper<_i30.TaleEntity, _i96.TalesPageItemData>>(),
              gh<_i152.Logger>(),
            ));
    gh.factory<_i93.UseCase<bool, _i173.SetTrackingEnabledOutput>>(
        () => _i173.SetTrackingEnabledUseCase(
              gh<_i151.FirebaseAnalytics>(),
              gh<_i135.AppStateStorage>(),
            ));
    gh.factory<_i93.UseCase<_i174.ListenAppThemeChangesInput, _i55.AppTheme>>(
        () => _i174.ListenAppThemeChangesUseCase(
              gh<_i73.SettingsStorage>(),
              gh<_i152.Logger>(),
            ));
    gh.factory<
            _i93.UseCase<_i175.ListenTextScaleFactorChangesInput,
                _i57.TextScaleFactor>>(
        () => _i175.ListenTextScaleFactorChangesUseCase(
              gh<_i73.SettingsStorage>(),
              gh<_i152.Logger>(),
            ));
    gh.factory<_i93.UseCase<_i176.ChangeTaleFavInput, _i93.Dry>>(
        () => _i176.ChangeTaleFavUseCase(
              gh<_i89.TaleStorage>(),
              gh<_i152.Logger>(),
            ));
    gh.factory<_i93.UseCase<_i133.TaleId, _i177.MarkTaleWatchedOutput>>(
        () => _i177.MarkTaleWatchedUseCase(
              gh<_i89.TaleStorage>(),
              gh<_i152.Logger>(),
            ));
    gh.factory<_i93.UseCase<_i93.Dry, _i178.AddTaleOutput>>(
        () => _i178.AddTaleUseCase(
              gh<_i157.RemoteConfigs>(),
              gh<_i10.EmailSender>(),
            ));
    gh.factory<_i93.UseCase<_i108.Tale, _i179.ReportTaleOutput>>(
        () => _i179.ReportTaleUseCase(
              gh<_i157.RemoteConfigs>(),
              gh<_i10.EmailSender>(),
            ));
    gh.factory<_i93.UseCase<_i93.Dry, _i53.IntPositive>>(
        () => _i180.GetAppStartCount(
              gh<_i135.AppStateStorage>(),
              gh<_i152.Logger>(),
            ));
    gh.factory<_i93.UseCase<_i93.Dry, _i181.WriteDevOutput>>(
        () => _i181.WriteDevUseCase(
              gh<_i157.RemoteConfigs>(),
              gh<_i10.EmailSender>(),
            ));
    gh.factory<
            _i93.UseCase<_i93.Dry,
                _i119.ChangedData<_i96.TalesPageItemData, _i133.TaleId>>>(
        () => _i182.ListenAllTalesChangeUseCase(
              gh<_i89.TaleStorage>(),
              gh<_i17.Mapper<_i30.TaleEntity, _i96.TalesPageItemData>>(),
              gh<_i152.Logger>(),
            ));
    gh.factory<_i93.UseCase<_i93.Dry, _i96.TalesPageItemData>>(
        () => _i183.GetRandomTalePageItemDataUseCase(
              gh<_i89.TaleStorage>(),
              gh<_i152.Logger>(),
              gh<_i17.Mapper<_i30.TaleEntity, _i96.TalesPageItemData>>(),
            ));
    gh.factory<_i93.UseCase<_i93.Dry, Iterable<_i96.TalesPageItemData>>>(
        () => _i184.GetAllTalesUseCase(
              gh<_i89.TaleStorage>(),
              gh<_i17.Mapper<_i30.TaleEntity, _i96.TalesPageItemData>>(),
              gh<_i152.Logger>(),
            ));
    gh.factory<_i93.UseCase<_i116.PersonId, _i185.GetPersonTalesOutput>>(
        () => _i185.GetPersonTalesUseCase(
              gh<_i89.TaleStorage>(),
              gh<_i152.Logger>(),
            ));
    gh.factory<_i93.UseCase<_i186.UrlString, _i187.OpenUrlOutput>>(
        () => _i187.OpenUrlUseCase(gh<_i152.Logger>()));
    gh.factory<_i93.UseCase<_i93.Dry, _i188.GetPeopleByRoleOutput>>(
        () => _i188.GetPeopleByRoleUseCase(
              gh<_i112.PeopleRepository>(),
              gh<_i89.TaleStorage>(),
              gh<_i148.CrashAnalytic>(),
            ));
    gh.factory<_i93.UseCase<_i32.PlayerLoopMode, _i189.SaveLoopModeOutput>>(
        () => _i189.SaveLoopModeUseCase(
              gh<_i135.AppStateStorage>(),
              gh<_i152.Logger>(),
            ));
    gh.lazySingleton<_i190.ApiClient>(() => _i191.ApiClientImpl(
          gh<_i16.Dio>(),
          gh<_i13.FirebaseDatabase>(),
          gh<_i91.UrlCreator>(),
          gh<_i155.NetworkResponseParser>(),
          gh<_i148.CrashAnalytic>(),
        ));
    gh.lazySingleton<_i192.AudioPlayer>(() => _i193.AudioPlayerImpl(
          gh<_i8.AudioPlayer>(),
          gh<_i152.Logger>(),
          gh<_i148.CrashAnalytic>(),
          gh<
              _i17.Mapper<_i129.PlaylistItemData,
                  _i130.Future<_i8.IndexedAudioSource>>>(),
        ));
    gh.lazySingleton<_i194.CountdownService>(
        () => _i195.CountdownServiceImpl(gh<_i192.AudioPlayer>()));
    gh.lazySingleton<_i196.DialogController>(() => _i197.DialogControllerImpl(
          gh<_i71.ScreenContextKeeper>(),
          gh<_i159.Tracker>(),
        ));
    gh.lazySingleton<_i198.ScreenController>(() => _i199.ScreenControllerImpl(
          gh<_i159.Tracker>(),
          gh<_i70.RootStackRouter>(),
          gh<_i154.NavigatorObserver>(),
          gh<_i3.ActiveScreenNotifier>(),
        ));
    gh.factory<_i200.SearchTaleManager>(() => _i200.SearchTaleManager(
          gh<_i198.ScreenController>(),
          gh<_i93.UseCase<_i93.Dry, _i121.GetRandomTaleNameAndAuthorOutput>>(),
          gh<_i93.UseCase<_i133.TaleId, _i134.GetTaleOutput>>(),
          gh<_i93.UseCase<_i176.ChangeTaleFavInput, _i93.Dry>>(),
          gh<_i93.UseCase<_i24.StringSingleLine, _i172.SearchTalesOutput>>(),
          gh<
              _i93.UseCase<_i93.Dry,
                  _i119.ChangedData<_i96.TalesPageItemData, _i133.TaleId>>>(),
          gh<_i196.DialogController>(),
          gh<_i201.Tracker>(),
        ));
    gh.factory<_i202.SplashScreenManager>(() => _i202.SplashScreenManager(
          gh<_i198.ScreenController>(),
          gh<_i159.Tracker>(),
          gh<_i93.UseCase<_i93.Dry, _i161.InitRemoteConfigsOutput>>(),
          gh<_i93.UseCase<_i93.Dry, _i53.IntPositive>>(),
          gh<_i93.UseCase<_i93.Dry, _i167.IncrementAppStartsCountOutput>>(),
          gh<_i93.UseCase<_i93.Dry, _i51.ForcedUpdateInfo?>>(),
          gh<_i93.UseCase<_i93.Dry, _i140.CheckAppVersionChangedOutput>>(),
        ));
    gh.factory<_i203.TaleCrewScreenManager>(() => _i203.TaleCrewScreenManager(
          gh<_i198.ScreenController>(),
          gh<_i201.Tracker>(),
          gh<_i93.UseCase<_i166.ChangePersonFavInput, _i93.Dry>>(),
          gh<
              _i93.UseCase<_i118.ListenPersonChangesInput,
                  _i119.ChangedData<_i100.Person, _i116.PersonId>>>(),
          gh<_i17.Mapper<_i36.TaleCrewRole, _i24.StringSingleLine>>(
              instanceName: 'singular'),
          gh<_i17.Mapper<_i36.TaleCrewRole, _i24.StringSingleLine>>(
              instanceName: 'plural'),
        ));
    gh.factory<_i204.TaleSortAndFilterManager>(
        () => _i204.TaleSortAndFilterManager(
              gh<_i93.UseCase<_i94.SaveSortAndFilterInput, _i93.Dry>>(),
              gh<_i93.UseCase<_i93.Dry, _i141.GetSortAndFilterItemsOutput>>(),
              gh<_i198.ScreenController>(),
              gh<_i201.Tracker>(),
            ));
    gh.factory<_i205.TalesPageManager>(() => _i205.TalesPageManager(
          gh<_i77.SnackbarController>(),
          gh<_i198.ScreenController>(),
          gh<_i196.DialogController>(),
          gh<_i93.UseCase<_i93.Dry, Iterable<_i96.TalesPageItemData>>>(),
          gh<_i93.UseCase<_i93.Dry, _i164.GetTaleSortAndFilterTypesOutput>>(),
          gh<_i93.UseCase<_i176.ChangeTaleFavInput, _i93.Dry>>(),
          gh<
              _i93.UseCase<_i93.Dry,
                  _i119.ChangedData<_i96.TalesPageItemData, _i133.TaleId>>>(),
          gh<
              _i93.UseCase<_i95.FilterAndSortTalesInput,
                  List<_i96.TalesPageItemData>>>(),
          gh<_i93.UseCase<_i133.TaleId, _i134.GetTaleOutput>>(),
          gh<_i93.UseCase<_i93.Dry, _i96.TalesPageItemData>>(),
          gh<_i93.UseCase<_i93.Dry, _i23.TaleSortType>>(),
          gh<_i93.UseCase<_i93.Dry, _i18.TaleFilterType>>(),
          gh<_i17.Mapper<_i18.TaleFilterType, _i24.StringSingleLine>>(),
          gh<_i17.Mapper<_i23.TaleSortType, _i24.StringSingleLine>>(),
          gh<_i17.Mapper<_i18.TaleFilterType, _i19.SvgAssetGraphic>>(),
          gh<_i201.Tracker>(),
        ));
    gh.factory<
        _i93.UseCase<_i206.PrepareContentInput,
            _i206.PrepareContentOutput>>(() => _i206.PrepareContentUseCase(
          gh<_i66.PeopleStorage>(),
          gh<_i135.AppStateStorage>(),
          gh<_i89.TaleStorage>(),
          gh<_i112.PeopleRepository>(),
          gh<_i190.ApiClient>(),
          gh<_i17.Mapper<_i26.PersonDto, _i38.PersonEntity>>(),
          gh<_i17.Mapper<_i26.TaleDto, _i30.TaleEntity>>(),
          gh<_i17.Mapper<_i26.RatingDto, _i27.RatingEntity>>(),
          gh<_i152.Logger>(),
        ));
    gh.factory<_i93.UseCase<_i93.Dry, _i207.StopPlayingOutput>>(
        () => _i207.StopPlayingUseCase(gh<_i192.AudioPlayer>()));
    gh.factory<_i93.UseCase<_i129.PlaylistItemData, bool>>(
        () => _i208.CacheAudioUseCase(
              gh<_i91.UrlCreator>(),
              gh<_i190.ApiClient>(),
              gh<_i102.AudioCacheHelper>(),
              gh<_i89.TaleStorage>(),
              gh<_i192.AudioPlayer>(),
              gh<
                  _i17.Mapper<_i107.TaleChapterEntityMapperInput,
                      _i108.TaleChapter>>(),
            ));
    gh.factory<_i93.UseCase<_i93.Dry, _i170.Option<_i129.PlaylistItemData>>>(
        () => _i209.GetNextPlaylistItemUseCase(gh<_i192.AudioPlayer>()));
    gh.factory<_i93.UseCase<_i210.RateTaleInput, bool>>(
        () => _i210.RateTaleUseCase(
              gh<_i190.ApiClient>(),
              gh<_i89.TaleStorage>(),
              gh<_i135.AppStateStorage>(),
              gh<_i152.Logger>(),
            ));
    gh.factory<_i93.UseCase<_i93.Dry, _i170.Option<_i96.TalesPageItemData>>>(
        () => _i211.ListenCurrentPlayingUseCase(
              gh<_i89.TaleStorage>(),
              gh<_i17.Mapper<_i30.TaleEntity, _i96.TalesPageItemData>>(),
              gh<_i192.AudioPlayer>(),
            ));
    gh.factory<_i93.UseCase<_i93.Dry, _i212.DeleteUserDataUseCaseOutput>>(
        () => _i212.DeleteUserDataUseCase(
              gh<_i14.FirebaseInstallations>(),
              gh<_i93.UseCase<bool, _i147.SetCrashLoggingEnabledOutput>>(),
              gh<_i93.UseCase<bool, _i173.SetTrackingEnabledOutput>>(),
            ));
    gh.factory<_i93.UseCase<_i93.Dry, _i213.ListenPlaylistChangedOutput>>(
        () => _i213.ListenPlaylistChangedUseCase(
              gh<_i89.TaleStorage>(),
              gh<_i17.Mapper<_i30.TaleEntity, _i108.Tale>>(),
              gh<_i192.AudioPlayer>(),
              gh<_i152.Logger>(),
            ));
    gh.factory<_i93.UseCase<_i214.SetAudioPlaylistInput, _i93.Dry>>(() =>
        _i214.SetAudioPlaylistUseCase(
          gh<_i89.TaleStorage>(),
          gh<
              _i17.Mapper<_i107.TaleChapterEntityMapperInput,
                  _i108.TaleChapter>>(),
          gh<_i17.Mapper<_i30.TaleEntity, _i96.TalesPageItemData>>(),
          gh<_i192.AudioPlayer>(),
          gh<_i17.Mapper<String, _i34.TaleTag>>(),
          gh<
              _i93.UseCase<_i95.FilterAndSortTalesInput,
                  List<_i96.TalesPageItemData>>>(),
          gh<_i93.UseCase<_i93.Dry, _i164.GetTaleSortAndFilterTypesOutput>>(),
          gh<_i17.Mapper<_i18.TaleFilterType, _i24.StringSingleLine>>(),
          gh<_i17.Mapper<_i18.TaleFilterType, _i19.SvgAssetGraphic>>(),
          gh<_i17.Mapper<_i23.TaleSortType, _i24.StringSingleLine>>(),
        ));
    gh.factory<_i93.UseCase<_i93.Dry, _i215.SetInitialLoopModeOutput>>(
        () => _i215.SetInitialLoopModeUseCase(
              gh<_i135.AppStateStorage>(),
              gh<_i192.AudioPlayer>(),
            ));
    gh.factory<_i216.WhatsNewScreenManager>(() => _i216.WhatsNewScreenManager(
          gh<_i198.ScreenController>(),
          gh<_i93.UseCase<_i47.ShowDotType, _i93.Dry>>(),
        ));
    gh.factory<_i217.DynamicItemScreenManager>(
        () => _i217.DynamicItemScreenManager(
              gh<_i93.UseCase<_i186.UrlString, _i187.OpenUrlOutput>>(),
              gh<_i201.Tracker>(),
              gh<_i198.ScreenController>(),
            ));
    gh.factory<_i218.FavPageManager>(() => _i218.FavPageManager(
          gh<_i198.ScreenController>(),
          gh<_i196.DialogController>(),
          gh<_i77.SnackbarController>(),
          gh<_i93.UseCase<_i93.Dry, Iterable<_i96.TalesPageItemData>>>(),
          gh<_i93.UseCase<_i93.Dry, _i122.GetAllFavPeopleOutput>>(),
          gh<
              _i93.UseCase<_i95.FilterAndSortTalesInput,
                  List<_i96.TalesPageItemData>>>(),
          gh<_i93.UseCase<List<_i100.Person>, _i93.Dry>>(),
          gh<
              _i93.UseCase<_i93.Dry,
                  _i119.ChangedData<_i96.TalesPageItemData, _i133.TaleId>>>(),
          gh<_i93.UseCase<_i93.Dry, _i123.ListenPeopleChangesOutput>>(),
          gh<_i93.UseCase<_i133.TaleId, _i134.GetTaleOutput>>(),
          gh<_i93.UseCase<_i176.ChangeTaleFavInput, _i93.Dry>>(),
          gh<_i93.UseCase<_i166.ChangePersonFavInput, _i93.Dry>>(),
          gh<_i201.Tracker>(),
        ));
    gh.factory<_i219.ForcedUpdateManager>(() => _i219.ForcedUpdateManager(
          gh<_i198.ScreenController>(),
          gh<_i5.AppUpdateHelper>(),
          gh<_i201.Tracker>(),
        ));
    gh.factory<_i220.HomeScreenManager>(() => _i220.HomeScreenManager(
          gh<_i198.ScreenController>(),
          gh<_i159.Tracker>(),
          gh<_i192.AudioPlayer>(),
          gh<_i93.UseCase<_i93.Dry, _i170.Option<_i96.TalesPageItemData>>>(),
          gh<_i93.UseCase<_i93.Dry, _i207.StopPlayingOutput>>(),
          gh<_i93.UseCase<_i133.TaleId, _i134.GetTaleOutput>>(),
          gh<_i93.UseCase<_i93.Dry, _i139.ListenShowMenuDotOutput>>(),
        ));
    gh.factory<_i221.ListenPageManager>(() => _i221.ListenPageManager(
          gh<_i192.AudioPlayer>(),
          gh<_i194.CountdownService>(),
          gh<_i196.DialogController>(),
          gh<_i77.SnackbarController>(),
          gh<_i93.UseCase<_i93.Dry, _i215.SetInitialLoopModeOutput>>(),
          gh<_i93.UseCase<_i210.RateTaleInput, bool>>(),
          gh<_i93.UseCase<_i32.PlayerLoopMode, _i189.SaveLoopModeOutput>>(),
          gh<_i201.Tracker>(),
        ));
    gh.factory<_i222.MenuPageManager>(() => _i222.MenuPageManager(
          gh<_i198.ScreenController>(),
          gh<_i93.UseCase<_i93.Dry, _i181.WriteDevOutput>>(),
          gh<_i93.UseCase<_i93.Dry, _i178.AddTaleOutput>>(),
          gh<_i93.UseCase<_i93.Dry, _i168.ShareAppOutput>>(),
          gh<_i93.UseCase<_i93.Dry, _i45.AppVersion>>(),
          gh<_i93.UseCase<_i186.UrlString, _i187.OpenUrlOutput>>(),
          gh<_i157.RemoteConfigs>(),
          gh<_i93.UseCase<_i47.ShowDotType, bool>>(),
          gh<_i93.UseCase<_i47.ShowDotType, _i93.Dry>>(),
          gh<_i93.UseCase<_i93.Dry, _i170.Option<_i42.MenuDynamicItemData>>>(),
          gh<_i201.Tracker>(),
        ));
    gh.factory<_i223.PeoplePageManager>(() => _i223.PeoplePageManager(
          gh<_i198.ScreenController>(),
          gh<_i93.UseCase<_i93.Dry, _i188.GetPeopleByRoleOutput>>(),
          gh<
              _i93.UseCase<_i120.GetPeoplePageTabDataListInput,
                  _i120.GetPeoplePageTabDataListOutput>>(),
          gh<_i93.UseCase<_i93.Dry, _i123.ListenPeopleChangesOutput>>(),
          gh<_i93.UseCase<_i166.ChangePersonFavInput, _i93.Dry>>(),
          gh<_i201.Tracker>(),
        ));
    gh.factory<_i224.PersonScreenManager>(() => _i224.PersonScreenManager(
          gh<_i198.ScreenController>(),
          gh<_i93.UseCase<_i116.PersonId, _i117.GetPersonOutput>>(),
          gh<_i93.UseCase<_i116.PersonId, _i185.GetPersonTalesOutput>>(),
          gh<
              _i93.UseCase<_i142.GetPersonTabDataInput,
                  _i142.GetPersonTabDataOutput>>(),
          gh<_i93.UseCase<_i176.ChangeTaleFavInput, _i93.Dry>>(),
          gh<_i93.UseCase<_i133.TaleId, _i134.GetTaleOutput>>(),
          gh<
              _i93.UseCase<_i93.Dry,
                  _i119.ChangedData<_i96.TalesPageItemData, _i133.TaleId>>>(),
          gh<
              _i93.UseCase<_i118.ListenPersonChangesInput,
                  _i119.ChangedData<_i100.Person, _i116.PersonId>>>(),
          gh<_i93.UseCase<_i186.UrlString, _i187.OpenUrlOutput>>(),
          gh<_i93.UseCase<_i166.ChangePersonFavInput, _i93.Dry>>(),
          gh<_i196.DialogController>(),
          gh<_i201.Tracker>(),
        ));
    gh.factory<_i225.ReadTalePageManager>(() => _i225.ReadTalePageManager(
          gh<_i196.DialogController>(),
          gh<_i77.SnackbarController>(),
          gh<_i93.UseCase<_i169.SaveLastReadPositionUseCaseInput, _i93.Dry>>(),
          gh<_i93.UseCase<_i210.RateTaleInput, bool>>(),
          gh<
              _i93.UseCase<_i175.ListenTextScaleFactorChangesInput,
                  _i57.TextScaleFactor>>(),
          gh<_i201.Tracker>(),
        ));
    gh.lazySingleton<_i226.TaleScreenManager>(() => _i226.TaleScreenManager(
          gh<_i198.ScreenController>(),
          gh<_i196.DialogController>(),
          gh<_i93.UseCase<_i176.ChangeTaleFavInput, _i93.Dry>>(),
          gh<
              _i93.UseCase<_i132.ListenTaleChangesInput,
                  _i119.ChangedData<_i108.Tale, _i133.TaleId>>>(),
          gh<_i93.UseCase<_i214.SetAudioPlaylistInput, _i93.Dry>>(),
          gh<_i148.CrashAnalytic>(),
          gh<_i93.UseCase<_i93.Dry, _i213.ListenPlaylistChangedOutput>>(),
          gh<_i93.UseCase<_i93.Dry, _i170.Option<_i129.PlaylistItemData>>>(),
          gh<_i93.UseCase<_i129.PlaylistItemData, bool>>(),
          gh<_i93.UseCase<_i133.TaleId, _i177.MarkTaleWatchedOutput>>(),
          gh<_i93.UseCase<_i108.Tale, _i179.ReportTaleOutput>>(),
          gh<_i201.Tracker>(),
        ));
    gh.factory<_i93.UseCase<_i93.Dry, _i227.CacheAllAudioOutput>>(
        () => _i227.CacheAllAudioUseCase(
              gh<_i93.UseCase<_i129.PlaylistItemData, bool>>(),
              gh<_i89.TaleStorage>(),
              gh<_i17.Mapper<_i34.TaleTag, String>>(),
              gh<
                  _i17.Mapper<_i107.TaleChapterEntityMapperInput,
                      _i108.TaleChapter>>(),
            ));
    gh.factory<_i228.SettingsScreenManager>(() => _i228.SettingsScreenManager(
          gh<_i201.Tracker>(),
          gh<_i198.ScreenController>(),
          gh<_i196.DialogController>(),
          gh<_i77.SnackbarController>(),
          gh<_i157.RemoteConfigs>(),
          gh<_i93.UseCase<_i55.AppTheme, _i93.Dry>>(),
          gh<_i93.UseCase<_i174.ListenAppThemeChangesInput, _i55.AppTheme>>(),
          gh<_i93.UseCase<_i93.Dry, _i160.DeleteAllAudioTalesOutput>>(),
          gh<_i93.UseCase<_i93.Dry, _i114.GetCachedAudioInfoOutput>>(),
          gh<_i93.UseCase<_i93.Dry, _i227.CacheAllAudioOutput>>(),
          gh<_i93.UseCase<_i93.Dry, _i97.IsConnectionMobileOutput>>(),
          gh<_i93.UseCase<_i93.Dry, _i145.GetCrashLoggingEnabledOutput>>(),
          gh<_i93.UseCase<bool, _i147.SetCrashLoggingEnabledOutput>>(),
          gh<_i93.UseCase<_i93.Dry, _i146.GetTrackingEnabledOutput>>(),
          gh<_i93.UseCase<bool, _i173.SetTrackingEnabledOutput>>(),
          gh<_i93.UseCase<_i93.Dry, _i212.DeleteUserDataUseCaseOutput>>(),
          gh<_i93.UseCase<_i186.UrlString, _i187.OpenUrlOutput>>(),
          gh<_i93.UseCase<_i57.TextScaleFactor, _i93.Dry>>(),
          gh<
              _i93.UseCase<_i175.ListenTextScaleFactorChangesInput,
                  _i57.TextScaleFactor>>(),
        ));
    return this;
  }
}

class _$StorageModule extends _i229.StorageModule {}

class _$ModuleUtils extends _i230.ModuleUtils {}

class _$NetworkModule extends _i231.NetworkModule {}

class _$ModuleFirebase extends _i232.ModuleFirebase {}
