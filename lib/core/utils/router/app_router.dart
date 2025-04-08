import 'package:auto_route/auto_route.dart';
import 'package:nimbus/core/utils/enums/router.enums.dart';
import 'package:nimbus/core/utils/router/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: SplashPage.page,
      path: RouteEnums.splashPath.value,
      initial: true,
    ),
    AutoRoute(page: LoginPage.page, path: RouteEnums.loginPath.value),
    AutoRoute(page: Homepage.page, path: RouteEnums.homepagePath.value),
    AutoRoute(page: AddNimbusPage.page, path: RouteEnums.addNimbusPath.value),
    AutoRoute(page: SettingsPage.page, path: RouteEnums.settingsPath.value),
  ];
}
