import 'package:mobile_app/domain/model/app_theme/app_theme.dart';
import 'package:mobile_app/domain/model/settings/text_scale_factor.dart';
import 'package:mobile_app/domain/model/tale_crew/tale_crew_role.dart';

part 'tracking_platform.dart';

part 'tracking_event.dart';

part 'tracking_view.dart';

abstract class Tracker {
  void event(TrackingEvent event, [Map<String, dynamic>? params]);

  void view(TrackingView view);
}
