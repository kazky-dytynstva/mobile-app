part of 'tracker.dart';

class TrackingView {
  final String name;
  final List<TrackingPlatform> platforms;

  const TrackingView._(
    this.name, [
    // ignore:unused_element
    this.platforms = TrackingPlatform.values,
  ]) : assert(name.length > 0 && name.length <= 40);
}

abstract class TrackingViews {
  //region screen

  static const TrackingView screenHome = TrackingView._("view_home");
  static const TrackingView screenWhatsNew = TrackingView._("view_whats_new");
  static const TrackingView screenForcedUpdate =
      TrackingView._("view_forced_update");
  static const TrackingView screenSettings = TrackingView._("view_settings");
  static const TrackingView screenTaleSortAndFilter =
      TrackingView._("view_tale_sort_and_filter");
  static const TrackingView screenTale = TrackingView._("view_tale");
  static const TrackingView screenTaleCrew = TrackingView._("view_tale_crew");
  static const TrackingView screenPerson = TrackingView._("view_person");
  static const TrackingView screenSearchTale =
      TrackingView._("view_search_tale");
  static const TrackingView screenDynamicItem =
      TrackingView._("view_dynamic_item");

  //endregion screen

  //region dialog
  static const TrackingView dialogConfirmDeleteUserData =
      TrackingView._("dialog_confirm_delete_user_data");
  static const TrackingView dialogConfirmDeleteAllAudio =
      TrackingView._("dialog_confirm_delete_all_audio");
  static const TrackingView dialogSwitchToWiFi =
      TrackingView._("dialog_switch_to_wi_fi");
  static const TrackingView dialogRandomTale =
      TrackingView._("dialog_random_tale");
  static const TrackingView dialogTaleMoreMenu =
      TrackingView._("dialog_tale_more_menu");
  static const TrackingView dialogTaleReportIssue =
      TrackingView._("dialog_tale_report_issue");
  static const TrackingView dialogTaleRatingDetails =
      TrackingView._("dialog_tale_rating_details");
  static const TrackingView dialogRatingExplanations =
      TrackingView._("dialog_rating_explanations");
  static const TrackingView dialogConfirmRateTale =
      TrackingView._("dialog_confirm_rate_tale");
  static const TrackingView dialogAudioCountdownChoose =
      TrackingView._("dialog_audio_countdown_choose");
  static const TrackingView dialogAudioCountdownActive =
      TrackingView._("dialog_audio_countdown_active");

  //endregion dialog

  //region home page

  static const TrackingView pageHomeTales = TrackingView._("home_page_tales");
  static const TrackingView pageHomeFav = TrackingView._("home_page_fav");
  static const TrackingView pageHomePeople = TrackingView._("home_page_people");
  static const TrackingView pageHomeMenu = TrackingView._("home_page_menu");
//endregion home page
}
