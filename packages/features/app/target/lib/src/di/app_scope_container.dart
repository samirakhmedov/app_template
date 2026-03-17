import 'package:app_data/app_data.dart';
import 'package:app_domain/app_domain.dart';
import 'package:app_presentation/app_presentation.dart';
import 'package:app_target/src/di/i_app_scope.dart';
import 'package:common_data/common_data.dart';
import 'package:common_domain/common_domain.dart';
import 'package:core/core.dart';
import 'package:database/database.dart';
import 'package:debug_di_interface/debug_di_interface.dart';
import 'package:debug_domain/debug_domain.dart';
import 'package:device_settings_data/device_settings_data.dart';
import 'package:device_settings_domain/device_settings_domain.dart';
import 'package:di_core/di_core.dart';
import 'package:flutter/foundation.dart';
import 'package:haptics_di/haptics_di.dart';
import 'package:haptics_domain/haptics_domain.dart';
import 'package:network/network.dart';
import 'package:splash_di/splash_di.dart';
import 'package:storage/storage.dart';
import 'package:theme_data/theme_data.dart';
import 'package:theme_domain/theme_domain.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template app_scope_container}
/// Root DI scope shared across all app targets.
///
/// Composes all feature modules and child scope holders.
/// {@endtemplate}
class AppScopeContainer extends DataScopeContainer<Environment>
    implements IAppScope, IHttpModuleContext, IDebugModuleContext {
  // ── Shared infrastructure modules (from di_core) ──────────────────────────

  /// Storage module: database, secure storage, shared prefs, encryption.
  late final storageModule = AppScopeStorageModule(this);

  /// HTTP module: scoped client factory and root Dio instance.
  late final httpModule = AppScopeHttpModule(this);

  // ── Feature modules (inline) ──────────────────────────────────────────────

  late final crashModule = AppScopeCrashModule(this);
  late final themeModule = AppScopeThemeModule(this);
  late final memoryModule = AppScopeMemoryModule(this);
  late final deviceSettingsModule = AppScopeDeviceSettingsModule(this);

  // ── Child scope holders ───────────────────────────────────────────────────

  late final hapticsScopeHolder = HapticsScopeHolder(this);
  late final splashScopeHolder = SplashScopeHolder(this);

  // ── Debug module (lazy — only materialised when factory is provided) ────────

  final IDebugModule Function(AppScopeContainer)? _debugModuleFactory;

  late final IDebugModule _debugModule =
      _debugModuleFactory?.call(this) ?? const NoOpDebugModule();

  // ── Direct deps ───────────────────────────────────────────────────────────

  /// Logger (sync — available immediately, no async init needed).
  late final loggerDep = dep<LoggerStrategy>(() => Logger(strategies: []));

  late final _snackQueueBlocDep = rawAsyncDep<SnackQueueBloc>(
    SnackQueueBloc.new,
    init: (_) => Future.value(),
    dispose: (bloc) => bloc.close(),
  );

  /// Wraps haptics child-scope creation so it participates in the init queue.
  late final _hapticsScopeReadyDep = rawAsyncDep<HapticsScopeHolder>(
    () => hapticsScopeHolder,
    init: (holder) => holder.create(),
    dispose: (holder) => holder.drop(),
  );

  // ── Initialization queue ──────────────────────────────────────────────────

  @override
  List<Set<AsyncDepType>> get initializeQueue => [
    // Level 1 — parallel infrastructure
    {
      storageModule.revivableDatabaseManagerDep,
      storageModule.encryptionServiceDep,
      crashModule.crashStrategyDep,
      ..._debugModule.initDeps,
      httpModule.httpClientFactoryDep,
      _hapticsScopeReadyDep,
    },
    // Level 2 — depends on level 1 (HTTP client, theme service)
    {
      httpModule.rootDioDep,
      themeModule.themeServiceDep,
    },
    // Level 3 — blocs (depend on level 2 services)
    {
      themeModule.themeBlocDep,
      memoryModule.memoryBlocDep,
      _snackQueueBlocDep,
      deviceSettingsModule.deviceSettingsBlocDep,
    },
  ];

  /// {@macro app_scope_container}
  AppScopeContainer({
    required super.data,
    IDebugModule Function(AppScopeContainer)? debugModuleFactory,
  }) : _debugModuleFactory = debugModuleFactory;

  // ── app_di.IAppScope ──────────────────────────────────────────────────────

  @override
  IScopedHttpClientFactory get httpClientFactory => httpModule.httpClientFactoryDep.get;

  @override
  LoggerStrategy get logger => loggerDep.get;

  @override
  IRevivableDatabase get appDatabase => storageModule.revivableDatabaseManagerDep.get;

  @override
  IDebugRepository get debugRepository => _debugModule.repository;

  @override
  Urls get environmentUrl => data.url;

  // ── Local IAppScope extras ────────────────────────────────────────────────

  @override
  ThemeBloc get themeBloc => themeModule.themeBlocDep.get;

  @override
  SnackQueueBloc get snackQueueBloc => _snackQueueBlocDep.get;

  @override
  MemoryBloc get memoryBloc => memoryModule.memoryBlocDep.get;

  @override
  DeviceSettingsBloc get deviceSettingsBloc => deviceSettingsModule.deviceSettingsBlocDep.get;

  @override
  // ignore: avoid-non-null-assertion
  HapticsBloc get hapticsBloc => hapticsScopeHolder.scope!.hapticsBloc;

  // ── IHttpModuleContext ────────────────────────────────────────────────────

  @override
  String? get debugBaseUri => _debugModule.rawBaseUri;

  @override
  String get baseUrl => data.url.value;

  // ── IDebugModuleContext ───────────────────────────────────────────────────

  @override
  Storage get debugStorage => storageModule.storageDep.get;

  // IHapticsParentScope is satisfied by [logger] above.
  // IDebugModuleContext.logger is satisfied by [logger] above.
}

// ── AppScopeHolder ────────────────────────────────────────────────────────────

/// {@template app_scope_holder}
/// Holds the [AppScopeContainer] lifecycle.
/// {@endtemplate}
class AppScopeHolder extends DataScopeHolder<AppScopeContainer, Environment> {
  AppScopeHolder({this.debugModuleFactory});

  /// Optional factory that produces the debug module bound to the container.
  ///
  /// Pass `null` (default) for production targets (basic, huawei) — a
  /// [NoOpDebugModule] is used instead. Pass `AppScopeDebugModule.new` (from
  /// `debug_di`) for the debug target.
  final IDebugModule Function(AppScopeContainer)? debugModuleFactory;

  @override
  AppScopeContainer createContainer(Environment data) => AppScopeContainer(
        data: data,
        debugModuleFactory: debugModuleFactory,
      );
}

// ── Inline modules ────────────────────────────────────────────────────────────

/// {@template app_scope_crash_module}
/// Provides crash handling for all app targets.
///
/// Always wired — unconditional across basic, huawei, and debug targets.
/// {@endtemplate}
class AppScopeCrashModule extends ScopeModule<AppScopeContainer> {
  late final crashStrategyDep = rawAsyncDep<CrashStrategy>(
    () => Crashlytics(strategies: []),
    init: _initCrashStrategy,
    dispose: (s) => s.dispose(),
  );

  /// {@macro app_scope_crash_module}
  AppScopeCrashModule(super.container);

  Future<void> _initCrashStrategy(CrashStrategy crashStrategy) async {
    await crashStrategy.initialize();

    FlutterError.onError = crashStrategy.recordFatalError;

    PlatformDispatcher.instance.onError = (error, stack) {
      crashStrategy.recordFatalError(error, stack);

      return true;
    };
  }
}

/// {@template app_scope_theme_module}
/// Provides theme persistence: `ThemeBloc`, `ThemeService`, `ThemeRepository`.
/// {@endtemplate}
class AppScopeThemeModule extends ScopeModule<AppScopeContainer> {
  late final themeBlocDep = rawAsyncDep<ThemeBloc>(
    () => ThemeBloc(themeRepository: _themeRepositoryDep.get),
    init: (bloc) async => bloc.add(const ThemeEvent.initialize()),
    dispose: (bloc) => bloc.close(),
  );

  late final themeServiceDep = rawAsyncDep<IThemeService>(
    () => ThemeService(
      themeStorage: _themeStorageDep.get,
      themeModeConverter: const ThemeModeConverter(),
    ),
    init: (service) => service.initialize(),
    dispose: (service) => service.dispose(),
  );

  late final _themeRepositoryDep = dep<IThemeRepository>(
    () => ThemeRepository(themeService: themeServiceDep.get, logger: container.logger),
  );

  late final _themeStorageDep = dep<IThemeStorage>(
    () => ThemeStorage(storage: container.storageModule.storageDep.get),
  );

  /// {@macro app_scope_theme_module}
  AppScopeThemeModule(super.container);
}

/// {@template app_scope_memory_module}
/// Provides `MemoryBloc` for memory pressure handling.
/// {@endtemplate}
class AppScopeMemoryModule extends ScopeModule<AppScopeContainer> {
  late final memoryBlocDep = rawAsyncDep<MemoryBloc>(
    () => MemoryBloc(memoryRepository: _memoryRepositoryDep.get),
    init: (bloc) async => bloc.add(const MemoryEvent.initialize()),
    dispose: (bloc) => bloc.close(),
  );

  late final _memoryRepositoryDep = dep<IMemoryRepository>(
    () => MemoryRepository(
      clientFactory: container.httpClientFactory,
      database: container.appDatabase,
      logger: container.logger,
    ),
  );

  /// {@macro app_scope_memory_module}
  AppScopeMemoryModule(super.container);
}

/// {@template app_scope_device_settings_module}
/// Provides `DeviceSettingsBloc` for platform device configuration.
/// {@endtemplate}
class AppScopeDeviceSettingsModule extends ScopeModule<AppScopeContainer> {
  late final deviceSettingsBlocDep = rawAsyncDep<DeviceSettingsBloc>(
    () => DeviceSettingsBloc(repository: _repositoryDep.get),
    init: (_) => Future.value(),
    dispose: (bloc) => bloc.close(),
  );

  late final _repositoryDep = dep<IDeviceSettingsRepository>(
    () => DeviceSettingsRepository(logger: container.logger),
  );

  /// {@macro app_scope_device_settings_module}
  AppScopeDeviceSettingsModule(super.container);
}

// ── EnvironmentExtension ──────────────────────────────────────────────────────

extension EnvironmentExtension on Environment {
  /// Maps [BuildType] to the corresponding [Urls] variant.
  Urls get url => switch (buildType) {
    BuildType.production => Urls.release,
    BuildType.development || BuildType.qa => Urls.development,
  };
}
