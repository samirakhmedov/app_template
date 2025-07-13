import 'package:app_template/features/app/router/app_routes.dart';
import 'package:app_template/features/debug/presentation/screens/debug/debug_settings_component.dart';
import 'package:app_template/features/debug/presentation/screens/easter_egg/easter_egg_component.dart';
import 'package:app_template/features/debug/presentation/screens/root/debug_entry.dart';
import 'package:app_template/features/splash/presentation/root/splash_entry.dart';
import 'package:app_template/features/splash/presentation/screens/splash_central_component.dart';
import 'package:auto_route/auto_route.dart';

part 'app_router.gr.dart';

/// {@template router.class}
/// Main point of the application navigation.
/// {@endtemplate}
@AutoRouterConfig(replaceInRouteName: 'Entry|Component,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.adaptive(
    enablePredictiveBackGesture: true,
  );

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: SplashRoute.page,
      path: AppRoutes.splash,
      initial: true,
      children: [
        AutoRoute(
          page: SplashCentralRoute.page,
          initial: true,
        ),
      ],
    ),
    AutoRoute(
      page: DebugRoute.page,
      path: AppRoutes.debug,
      children: [
        AutoRoute(
          page: DebugSettingsRoute.page,
          path: AppRoutes.debugSettings,
          initial: true,
        ),
        AutoRoute(
          page: EasterEggRoute.page,
          path: AppRoutes.easterEgg,
        ),
      ],
    ),
  ];
}
