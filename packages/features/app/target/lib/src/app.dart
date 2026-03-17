import 'dart:async';

import 'package:app_assets/app_assets.dart';
import 'package:app_di/app_di.dart' as app_di;
import 'package:app_presentation/app_presentation.dart';
import 'package:app_router/app_router.dart';
import 'package:app_target/src/di/app_scope_container.dart';
import 'package:app_target/src/di/app_scope_registrar.dart';
import 'package:app_target/src/di/i_app_scope.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common_presentation/common_presentation.dart';
import 'package:core/core.dart';
import 'package:debug_di_interface/debug_di_interface.dart';
import 'package:flutter/material.dart' hide ThemeMode;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_dialogs/flutter_easy_dialogs.dart';
import 'package:haptics_presentation/haptics_presentation.dart';
import 'package:provider/provider.dart';
import 'package:theme_presentation/theme_presentation.dart';
import 'package:uikit/uikit.dart';

/// {@template app}
/// Root widget shared across all app targets.
///
/// Pass [featureRoutes] to inject target-specific routes (e.g. debug routes).
/// Pass [debugNavigatorWrapper] to wrap the component tree in a debug
/// navigator scope — supply `null` in production targets.
/// {@endtemplate}
class App extends StatefulWidget {
  /// {@macro app}
  const App({
    required this.environment,
    this.featureRoutes = const [],
    this.debugNavigatorWrapper,
    this.debugModuleFactory,
    super.key,
  });

  /// The resolved environment.
  final Environment environment;

  /// Additional routes injected by the app target (e.g. debugRoutes).
  final List<AutoRoute> featureRoutes;

  /// Optional wrapper that injects a debug navigator scope into the tree.
  ///
  /// `null` in production targets (basic, huawei); the debug target supplies
  /// a wrapper that adds `DebugNavigatorScope`.
  final Widget Function(Widget child, AppRouter router)? debugNavigatorWrapper;

  /// Optional factory for the app-scope debug infrastructure module.
  ///
  /// `null` in production targets — [NoOpDebugModule] is used by default.
  /// Pass `AppScopeDebugModule.new` (from `debug_di`) in the debug target.
  final IDebugModule Function(AppScopeContainer)? debugModuleFactory;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  static const _navRestorationScopeId = 'nav_restoration_scope';
  static const _appRestorationScopeId = 'app_restoration_scope';
  static const _rootRestorationId = 'root_restoration_scope';

  late final _router = AppRouter(featureRoutes: widget.featureRoutes);
  late final _appScopeRegistrar = AppScopeRegistrar(
    environment: widget.environment,
    debugModuleFactory: widget.debugModuleFactory,
  );

  final _scope = ValueNotifier<IAppScope?>(null);

  @override
  void initState() {
    super.initState();
    unawaited(_initialize());
  }

  @override
  void dispose() {
    unawaited(_appScopeRegistrar.dispose());
    _scope.dispose();
    _router.dispose();
    super.dispose();
  }

  Future<void> _initialize() async {
    final result = await _appScopeRegistrar.initialize();
    _scope.value = result;
    WidgetsBinding.instance.allowFirstFrame();
  }

  @override
  Widget build(BuildContext context) {
    return RootRestorationScope(
      restorationId: _rootRestorationId,
      child: WidgetsApp.router(
        routeInformationParser: _router.defaultRouteParser(),
        routerDelegate: _router.delegate(
          navRestorationScopeId: _navRestorationScopeId,
        ),
        builder: (ctx, child) {
          return ValueListenableBuilder(
            valueListenable: _scope,
            builder: (cx, scope, chld) {
              if (scope == null) return const AppStartupLayout();

              return _AppWrapperWidget(
                scope: scope,
                router: _router,
                debugNavigatorWrapper: widget.debugNavigatorWrapper,
                child: chld ?? const SizedBox.shrink(),
              );
            },
            child: child,
          );
        },
        color: const Color(0xFFFFFFFF),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        restorationScopeId: _appRestorationScopeId,
      ),
    );
  }
}

class _AppWrapperWidget extends StatelessWidget {
  const _AppWrapperWidget({
    required this.scope,
    required this.router,
    required this.child,
    this.debugNavigatorWrapper,
  });

  final IAppScope scope;
  final AppRouter router;
  final Widget child;
  final Widget Function(Widget child, AppRouter router)? debugNavigatorWrapper;

  @override
  Widget build(BuildContext context) {
    final easyDialogsBuilder = FlutterEasyDialogs.builder();

    Widget tree = ShaderProviderComponent(
      shaderPaths: const [AppShaders.shimmerFrag],
      child: MemoryComponent(
        child: ThemeComponent(
          lightTheme: AppThemeData.lightTheme,
          darkTheme: AppThemeData.darkTheme,
          child: HapticsComponent(
            child: Overlay(
              initialEntries: [
                OverlayEntry(
                  builder: (overlayContext) => easyDialogsBuilder(
                    overlayContext,
                    SnackQueueComponent(child: child),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    if (debugNavigatorWrapper != null) {
      tree = debugNavigatorWrapper!(tree, router);
    }

    return MultiProvider(
      providers: [
        Provider<app_di.IAppScope>.value(value: scope),
        BlocProvider.value(value: scope.themeBloc),
        BlocProvider.value(value: scope.snackQueueBloc),
        BlocProvider.value(value: scope.memoryBloc),
        BlocProvider.value(value: scope.deviceSettingsBloc),
        BlocProvider.value(value: scope.hapticsBloc),
      ],
      child: tree,
    );
  }
}
