import 'dart:async';

import 'package:app_template/core/config/environment/environment.dart';
import 'package:app_template/features/app/di/app_scope_registrar.dart';
import 'package:app_template/features/app/di/i_app_scope.dart';
import 'package:app_template/features/app/presentation/app_startup_layout.dart';
import 'package:app_template/features/app/router/app_router.dart';
import 'package:app_template/features/common/presentation/widgets/snacks/snack_queue_component.dart';
import 'package:app_template/features/haptics/presentation/widgets/haptics_component.dart';
import 'package:app_template/features/theme/presentation/widgets/theme_component.dart';
import 'package:app_template/generated/app_localizations.dart';
import 'package:app_template/util/helpers/system_chrome_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_dialogs/flutter_easy_dialogs.dart';
import 'package:provider/provider.dart';
import 'package:uikit/uikit.dart';

/// {@template app}
/// The app.
/// {@endtemplate}
class App extends StatefulWidget {
  /// {@macro app}
  const App({required this.environment, super.key});

  /// The environment.
  final Environment environment;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  static const _white = Color(0xFFFFFFFF);

  static const _navRestorationScopeId = 'nav_restoration_scope';

  static const _appRestorationScopeId = 'app_restoration_scope';

  static const _rootRestorationId = 'root_restoration_scope';

  late final _router = AppRouter();

  late final _appScopeRegistrar = AppScopeRegistrar(environment: widget.environment);

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
    unawaited(SystemChromeUtil.enableSeamlessUI());
    unawaited(SystemChromeUtil.lockDeviceRotation());
    SystemChromeUtil.setDefaultSystemUIOverlayStyle();

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
              if (scope == null) {
                return const AppStartupLayout();
              }

              return _AppWrapperWidget(
                scope: scope,
                child: chld ?? const SizedBox.shrink(),
              );
            },
            child: child,
          );
        },
        color: _white,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        restorationScopeId: _appRestorationScopeId,
      ),
    );
  }
}

class _AppWrapperWidget extends StatelessWidget {
  const _AppWrapperWidget({required this.scope, required this.child});

  final IAppScope scope;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final easyDialogsBuilder = FlutterEasyDialogs.builder();

    return Provider<IAppScope>.value(
      value: scope,
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
    );
  }
}
