import 'package:auto_route/auto_route.dart';
import 'package:mobile_app/presentation/navigation/screen/router/router.gr.dart';

@AutoRouterConfig(
  generateForDir: ['lib/presentation/view/screen'],
)
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.cupertino();

  @override
  List<AutoRoute> get routes => [
        CupertinoRoute(
          page: SplashRoute.page,
          initial: true,
        ),
        CupertinoRoute(page: DebugRoute.page),
        CupertinoRoute(page: TaleSortAndFilterRoute.page),
        CupertinoRoute(page: TaleRoute.page),
        CupertinoRoute(
          page: MainRoute.page,
          children: [
            MaterialRoute(page: HomeRoute.page),
            MaterialRoute(page: TalesRoute.page),
            MaterialRoute(page: FavRoute.page),
            MaterialRoute(page: PeopleRoute.page),
            MaterialRoute(page: MenuRoute.page),
          ],
        ),
        CupertinoRoute(page: SettingsRoute.page),
        CupertinoRoute(page: PersonRoute.page),
        CupertinoRoute(page: SearchTaleRoute.page),
        CupertinoRoute(page: TaleCrewRoute.page),
        CupertinoRoute(page: ForcedUpdateRoute.page),
        CupertinoRoute(page: FeatureFlagsRoute.page),
        CupertinoRoute(page: WhatsNewRoute.page),
        CupertinoRoute(page: DynamicItemRoute.page),
      ];
}
