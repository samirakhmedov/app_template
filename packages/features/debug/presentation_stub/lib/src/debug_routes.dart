import 'package:auto_route/auto_route.dart';

/// Empty debug routes list for non-debug app targets.
///
/// The real `debugRoutes` in `debug_presentation` contains the full
/// debug/settings/easter-egg route tree. This stub provides an empty list
/// so `AppRouter` receives no debug routes.
const List<AutoRoute> debugRoutes = [];
