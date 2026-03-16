import 'package:app_router/src/app_routes.dart';
import 'package:auto_route/auto_route.dart';
import 'package:splash_presentation/splash_presentation.dart';

/// {@template router.class}
/// Main point of the application navigation.
///
/// Pass [featureRoutes] to inject feature-specific routes (e.g. debug routes)
/// without creating a compile-time dependency on those feature packages.
/// {@endtemplate}
class AppRouter extends RootStackRouter {
  /// Routes injected by the app target (e.g. debugRoutes from debug_presentation).
  final List<AutoRoute> featureRoutes;

  /// {@macro router.class}
  AppRouter({this.featureRoutes = const []});

  @override
  RouteType get defaultRouteType => RouteType.adaptive(
    enablePredictiveBackGesture: true,
  );

  @override
  List<AutoRoute> get routes => [
    NamedRouteDef(
      name: AppRoutes.splashRouteName,
      path: AppRoutes.splash,
      restorationId: (_) => AppRoutes.splashRestorationId,
      initial: true,
      builder: (context, data) => WrappedRoute(child: const SplashEntry()),
      children: [
        NamedRouteDef(
          name: AppRoutes.splashCentralRouteName,
          restorationId: (_) => AppRoutes.splashCentralRestorationId,
          initial: true,
          builder: (context, data) => const SplashCentralComponent(),
        ),
      ],
    ),
    ...featureRoutes,
  ];
}
