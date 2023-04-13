part of 'tracker.dart';

class TrackingEvent {
  final String name;
  final List<TrackingPlatform> platforms;

  const TrackingEvent._(
    this.name, [
    // ignore:unused_element
    this.platforms = TrackingPlatform.values,
  ]) : assert(name.length > 0 && name.length <= 40);
}

abstract class TrackingEvents {
  TrackingEvents._();

  //region splashScreen
  static const TrackingEvent splashInitFailed =
      TrackingEvent._("splash_init_failed");
  static const TrackingEvent splashInitRetryClicked =
      TrackingEvent._("splash_init_retry_clicked");

//endregion splashScreen

  //region sortAndFilter
  static const TrackingEvent sortAndFilterSortSelected =
      TrackingEvent._("sort_and_filter_sort_selected");
  static const TrackingEvent sortAndFilterFilterSelected =
      TrackingEvent._("sort_and_filter_sort_selected");
  static const TrackingEvent sortAndFilterApplyPressed =
      TrackingEvent._("sort_and_filter_apply_pressed");

  //endregion sortAndFilter

  //region taleScreen
  static const TrackingEvent taleBottomChangeTypePressed =
      TrackingEvent._("tale_bottom_action_change_type_pressed");
  static const TrackingEvent taleBottomFavPressed =
      TrackingEvent._("tale_bottom_action_fav_pressed");
  static const TrackingEvent taleBottomMorePressed =
      TrackingEvent._("tale_bottom_action_more_pressed");
  static const TrackingEvent taleBottomCrewPressed =
      TrackingEvent._("tale_bottom_action_crew_pressed");
  static const TrackingEvent taleBottomRatingPressed =
      TrackingEvent._("tale_bottom_action_rating_pressed");
  static const TrackingEvent taleMoreMenuSettingsPressed =
      TrackingEvent._("tale_more_menu_settings_pressed");
  static const TrackingEvent taleMoreMenuReportPressed =
      TrackingEvent._("tale_more_menu_report_pressed");
  static const TrackingEvent taleReportConfirmPressed =
      TrackingEvent._("tale_report_confirm_pressed");
  static const TrackingEvent taleReadRatePressed =
      TrackingEvent._("tale_read_rate_pressed");
  static const TrackingEvent taleReadRateConfirmPressed =
      TrackingEvent._("tale_read_rate_confirm_pressed");
  static const TrackingEvent taleListenCountdownOnPressed =
      TrackingEvent._("tale_listen_countdown_on_pressed");
  static const TrackingEvent taleListenCountdownOffPressed =
      TrackingEvent._("tale_listen_countdown_off_pressed");
  static const TrackingEvent taleListenCountdownCompleted =
      TrackingEvent._("tale_listen_countdown_completed");
  static const TrackingEvent taleListenLoopModePressed =
      TrackingEvent._("tale_listen_loop_mode_pressed");
  static const TrackingEvent taleListenRatePressed =
      TrackingEvent._("tale_listen_rate_pressed");
  static const TrackingEvent taleListenRateConfirmPressed =
      TrackingEvent._("tale_listen_rate_confirm_pressed");

//endregion taleScreen

  //region mainScreen
  static const TrackingEvent mainCurrentAudioTalePressed =
      TrackingEvent._("main_current_audio_tale_pressed");
  static const TrackingEvent mainCurrentAudioTaleStopPressed =
      TrackingEvent._("main_current_audio_tale_stop_pressed");

  //endregion mainScreen

  //region talePage
  static const TrackingEvent talesPageFavPressed =
      TrackingEvent._("tales_page_fav_pressed");
  static const TrackingEvent talesPageFavUndoPressed =
      TrackingEvent._("tales_page_fav_undo_pressed");
  static const TrackingEvent talesPageFilterPressed =
      TrackingEvent._("tales_page_filter_pressed");
  static const TrackingEvent talesPageSortPressed =
      TrackingEvent._("tales_page_sort_pressed");
  static const TrackingEvent talesPageSearchPressed =
      TrackingEvent._("tales_page_search_pressed");
  static const TrackingEvent talesPageTalePressed =
      TrackingEvent._("tales_page_tale_pressed");
  static const TrackingEvent talesPageTaleRatingPressed =
      TrackingEvent._("tales_page_tale_rating_pressed");

  //endregion talePage
  static const TrackingEvent homePageTalePressed =
      TrackingEvent._("home_page_tale_pressed");
  static const TrackingEvent homePageTaleRatingPressed =
      TrackingEvent._("home_page_tale_rating_pressed");
  static const TrackingEvent homePageFavTalePressed =
      TrackingEvent._("home_page_fav_tale_pressed");
  static const TrackingEvent homePageUserAppUpdatePressed =
      TrackingEvent._("home_page_user_app_update_pressed");
  static const TrackingEvent homePageUserRatePressed =
      TrackingEvent._("home_page_user_rate_pressed");
  static const TrackingEvent homePageUserSharePressed =
      TrackingEvent._("home_page_user_share_pressed");
  static const TrackingEvent homePageUserSupportPressed =
      TrackingEvent._("home_page_user_support_pressed");
  static const TrackingEvent homePageUserDynamicPressed =
      TrackingEvent._("home_page_user_dynamic_pressed");

  //endregion homePage

  //region favPage
  static const TrackingEvent favPageTalePressed =
      TrackingEvent._("fav_page_tale_pressed");
  static const TrackingEvent favPagePersonPressed =
      TrackingEvent._("fav_page_person_pressed");
  static const TrackingEvent favPageFavTalePressed =
      TrackingEvent._("fav_page_fav_tale_pressed");
  static const TrackingEvent favPageFavTaleUndoPressed =
      TrackingEvent._("fav_page_fav_tale_undo_pressed");
  static const TrackingEvent favPagePersonFavPressed =
      TrackingEvent._("fav_page_person_fav_pressed");
  static const TrackingEvent favPagePersonFavUndoPressed =
      TrackingEvent._("fav_page_person_fav_undo_pressed");
  static const TrackingEvent favPageTaleRatingPressed =
      TrackingEvent._("fav_page_tale_rating_pressed");

  //endregion favPage

  //region peoplePage
  static const TrackingEvent peoplePageFavPressed =
      TrackingEvent._("people_page_fav_pressed");
  static const TrackingEvent peoplePagePersonPressed =
      TrackingEvent._("people_page_person_pressed");

  static TrackingEvent getPeoplePagePersonPressedByRole(TaleCrewRole role) =>
      TrackingEvent._("people_page_${role.name}_person_pressed");

  //endregion peoplePage

//region menuPage
  static const TrackingEvent menuPageDonatePressed =
      TrackingEvent._("menu_page_donate_pressed");
  static const TrackingEvent menuPageAddTalePressed =
      TrackingEvent._("menu_page_add_tale_pressed");
  static const TrackingEvent menuPageWriteDevPressed =
      TrackingEvent._("menu_page_write_dev_pressed");
  static const TrackingEvent menuPageShareAppPressed =
      TrackingEvent._("menu_page_share_app_pressed");
  static const TrackingEvent menuPageSettingsPressed =
      TrackingEvent._("menu_page_settings_pressed");
  static const TrackingEvent menuPageWhatsNewPressed =
      TrackingEvent._("menu_page_whats_news_pressed");
  static const TrackingEvent menuPageDynamicItemPressed =
      TrackingEvent._("menu_page_dynamic_item_pressed");

//endregion menuPage

//region settingsScreen
  static TrackingEvent getSettingsThemePressed(AppTheme theme) =>
      TrackingEvent._("settings_theme_${theme.name}_pressed");

  static TrackingEvent getSettingsTextScaleFactorPressed(
          TextScaleFactor scaleFactor) =>
      TrackingEvent._("settings_text_scale_factor_${scaleFactor.name}_pressed");
  static const TrackingEvent settingsDeleteAllAudioPressed =
      TrackingEvent._("settings_delete_audio_pressed");
  static const TrackingEvent settingsDeleteAllAudioConfirmPressed =
      TrackingEvent._("settings_delete_audio_confirm_pressed");
  static const TrackingEvent settingsCacheAudioPressed =
      TrackingEvent._("settings_cache_audio_pressed");
  static const TrackingEvent settingsStopCachingAudioPressed =
      TrackingEvent._("settings_stop_caching_audio_pressed");

//endregion settingsScreen

//region personScreen
  static const TrackingEvent personTaleFavPressed =
      TrackingEvent._("person_tale_fav_pressed");
  static const TrackingEvent personFavPressed =
      TrackingEvent._("person_fav_pressed");
  static const TrackingEvent personInfoUrlPressed =
      TrackingEvent._("person_info_url_pressed");
  static const TrackingEvent personTaleRatingPressed =
      TrackingEvent._("person_tale_rating_pressed");
  static const TrackingEvent personTalePressed =
      TrackingEvent._("person_tale_pressed");

//endregion personScreen

//region searchScreen
  static const TrackingEvent searchTaleFavPressed =
      TrackingEvent._("search_tale_fav_pressed");
  static const TrackingEvent searchTaleRatingPressed =
      TrackingEvent._("search_tale_rating_pressed");
  static const TrackingEvent searchTalePressed =
      TrackingEvent._("search_tale_pressed");
  static const TrackingEvent searchSuggestionPressed =
      TrackingEvent._("search_suggestion_pressed");

//endregion searchScreen

//region taleCrewScreen
  static const TrackingEvent taleCrewPersonFavPressed =
      TrackingEvent._("tale_crew_person_fav_pressed");
  static const TrackingEvent taleCrewPersonPressed =
      TrackingEvent._("tale_crew_person_pressed");

//endregion taleCrewScreen

//region forcedUpdateScreen
  static const TrackingEvent forcedUpdateSkipPressed =
      TrackingEvent._("forced_update_skip_pressed");
  static const TrackingEvent forcedUpdateUpdatePressed =
      TrackingEvent._("forced_update_update_pressed");

//endregion forcedUpdateScreen

//region dynamicItemScreen
  static const TrackingEvent dynamicItemCTAPressed =
      TrackingEvent._("dynamic_item_cta_pressed");
//endregion dynamicItemScreen
}
