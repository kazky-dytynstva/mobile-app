import 'package:auto_route/auto_route.dart';
import 'package:mobile_app/presentation/view/screen/dynamic_item/dynamic_item_screen.dart';
import 'package:mobile_app/presentation/view/screen/feature_flags/feature_flags_screen.dart';
import 'package:mobile_app/presentation/view/screen/forced_update/forced_update_screen.dart';
import 'package:mobile_app/presentation/view/screen/main/main_screen.dart';
import 'package:mobile_app/presentation/view/screen/main/page/fav/fav_page.dart';
import 'package:mobile_app/presentation/view/screen/main/page/home/home_page.dart';
import 'package:mobile_app/presentation/view/screen/main/page/menu/menu_page.dart';
import 'package:mobile_app/presentation/view/screen/main/page/people/people_page.dart';
import 'package:mobile_app/presentation/view/screen/main/page/tales/tales_page.dart';
import 'package:mobile_app/presentation/view/screen/debug/debug_screen.dart';
import 'package:mobile_app/presentation/view/screen/person/person_screen.dart';
import 'package:mobile_app/presentation/view/screen/search_tale/search_tale_screen.dart';
import 'package:mobile_app/presentation/view/screen/settings/settings_screen.dart';
import 'package:mobile_app/presentation/view/screen/splash/splash_screen.dart';
import 'package:mobile_app/presentation/view/screen/tale/tale_screen.dart';
import 'package:mobile_app/presentation/view/screen/tale_crew/tale_crew_screen.dart';
import 'package:mobile_app/presentation/view/screen/tale_sort_and_filter/tale_sort_and_filter_screen.dart';
import 'package:mobile_app/presentation/view/screen/whats_new/whats_new_screen.dart';

@CupertinoAutoRouter(
  routes: [
    CupertinoRoute(
      page: SplashScreen,
      initial: true,
    ),
    CupertinoRoute(page: DebugScreen),
    CupertinoRoute(page: TaleSortAndFilterScreen),
    CupertinoRoute(page: TaleScreen),
    CupertinoRoute(
      page: MainScreen,
      children: [
        MaterialRoute(page: HomePage),
        MaterialRoute(page: TalesPage),
        MaterialRoute(page: FavPage),
        MaterialRoute(page: PeoplePage),
        MaterialRoute(page: MenuPage),
      ],
    ),
    CupertinoRoute(page: SettingsScreen),
    CupertinoRoute(page: PersonScreen),
    CupertinoRoute(page: SearchTaleScreen),
    CupertinoRoute(page: TaleCrewScreen),
    CupertinoRoute(page: ForcedUpdateScreen),
    CupertinoRoute(page: FeatureFlagsScreen),
    CupertinoRoute(page: WhatsNewScreen),
    CupertinoRoute(page: DynamicItemScreen),
  ],
)
class $AppRouter {}
