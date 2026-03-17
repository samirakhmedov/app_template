import 'package:auto_route/auto_route.dart';
import 'package:debug_presentation/src/root/debug_entry.dart';
import 'package:debug_presentation/src/screens/debug_settings_component.dart';
import 'package:debug_presentation/src/screens/easter_egg/easter_egg_component.dart';

// Paths

/// The debug route path.
const debugPath = '/debug';

/// The debug settings route path (relative).
const debugSettingsPath = 'settings';

/// The easter egg route path (relative).
const easterEggPath = 'easter-egg';

/// The full debug easter egg path.
const debugEasterEggPath = '$debugPath/$easterEggPath';

// Route names

/// The debug route name.
const debugRouteName = 'DebugRoute';

/// The debug settings route name.
const debugSettingsRouteName = 'DebugSettingsRoute';

/// The easter egg route name.
const easterEggRouteName = 'EasterEggRoute';

// Restoration IDs

/// The debug route restoration ID.
const debugRestorationId = 'debug_route';

/// The debug settings route restoration ID.
const debugSettingsRestorationId = 'debug_settings_route';

/// The easter egg route restoration ID.
const easterEggRestorationId = 'easter_egg_route';

/// Debug feature routes to inject into `AppRouter.featureRoutes`.
final List<AutoRoute> debugRoutes = [
  NamedRouteDef(
    name: debugRouteName,
    path: debugPath,
    restorationId: (_) => debugRestorationId,
    builder: (context, data) => WrappedRoute(child: const DebugEntry()),
    children: [
      NamedRouteDef(
        name: debugSettingsRouteName,
        path: debugSettingsPath,
        restorationId: (_) => debugSettingsRestorationId,
        initial: true,
        builder: (context, data) => DebugSettingsComponent(
          onOpenEasterEgg: () => context.router.pushPath(easterEggPath),
        ),
      ),
      NamedRouteDef(
        name: easterEggRouteName,
        path: easterEggPath,
        restorationId: (_) => easterEggRestorationId,
        builder: (context, data) => const EasterEggComponent(),
      ),
    ],
  ),
];
