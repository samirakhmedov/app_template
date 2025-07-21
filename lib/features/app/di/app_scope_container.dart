import 'package:app_template/core/architecture/di/dependencies_registrar.dart';
import 'package:app_template/core/config/constants.dart';
import 'package:app_template/core/config/environment/build_type.dart';
import 'package:app_template/core/config/environment/environment.dart';
import 'package:app_template/core/config/urls.dart';
import 'package:app_template/core/data/crash/crashlytics.dart';
import 'package:app_template/core/data/logger/logger.dart';
import 'package:app_template/core/domain/crash/crash_strategy.dart';
import 'package:app_template/core/domain/logger/logger_strategy.dart';
import 'package:app_template/features/app/di/i_app_scope.dart';
import 'package:app_template/features/common/data/repositories/shader_repository.dart';
import 'package:app_template/features/common/data/services/i_shader_service.dart';
import 'package:app_template/features/common/data/services/shader_service.dart';
import 'package:app_template/features/common/domain/repositories/i_shader_repository.dart';
import 'package:app_template/features/common/presentation/state/shader/shader_bloc.dart';
import 'package:app_template/features/common/presentation/state/snack/snack_queue_bloc.dart';
import 'package:app_template/features/debug/data/repositories/debug_repository.dart';
import 'package:app_template/features/debug/data/services/debug_service.dart';
import 'package:app_template/features/debug/data/services/i_debug_service.dart';
import 'package:app_template/features/debug/di/debug_scope_container.dart';
import 'package:app_template/features/debug/domain/repositories/i_debug_repository.dart';
import 'package:app_template/features/splash/di/splash_scope_container.dart';
import 'package:app_template/features/theme/data/converters/theme_mode_converter.dart';
import 'package:app_template/features/theme/data/repositories/theme_repository.dart';
import 'package:app_template/features/theme/data/services/i_theme_service.dart';
import 'package:app_template/features/theme/data/services/theme_service.dart';
import 'package:app_template/features/theme/domain/repositories/i_theme_repository.dart';
import 'package:app_template/features/theme/presentation/state/bloc/theme_bloc.dart';
import 'package:database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:network/network.dart';
import 'package:storage/storage.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template app_scope_container}
/// A container for the app scope.
/// {@endtemplate}
class AppScopeContainer extends DataScopeContainer<Environment> implements IAppScope {
  /// The storage module.
  late final storageModule = AppScopeStorageModule(this);

  /// The debug module.
  late final debugModule = AppScopeDebugModule(this);

  /// The theme module.
  late final themeModule = AppScopeThemeModule(this);

  /// The shader module.
  late final shaderModule = AppScopeShaderModule(this);

  /// The http module.
  late final httpModule = AppScopeHttpModule(this);

  /// The debug scope holder.
  late final debugScopeHolder = DebugScopeHolder(this);

  /// The splash scope holder.
  late final splashScopeHolder = SplashScopeHolder(this);

  /// The logger dependency.
  late final loggerDep = dep<LoggerStrategy>(_createLogger);

  /// The snack queue bloc dependency.
  late final _snackQueueBlocDep = rawAsyncDep(
    _createSnackQueueBloc,
    init: (bloc) => Future.value(),
    dispose: (bloc) => bloc.close(),
  );

  @override
  List<Set<AsyncDepType>> get initializeQueue => [
    {_snackQueueBlocDep},
    storageModule.initializeList,
    debugModule.initializeList,
    ...themeModule.initializeList,
    ...shaderModule.initializeList,
    ...httpModule.initializeList,
  ];

  /// The URL.
  Urls get url => environment.url;

  @override
  Environment get environment => data;

  @override
  AppDatabase get appDatabase => storageModule.appDatabaseDep.get;

  @override
  Dio get authDio => httpModule.rootDioDep.get;

  @override
  Storage get secureStorage => storageModule.secureStorageDep.get;

  @override
  Storage get storage => storageModule.storageDep.get;

  @override
  IDebugRepository get debugRepository => debugModule.debugRepositoryDep.get;

  @override
  ThemeBloc get themeBloc => themeModule.themeBlocDep.get;

  @override
  SnackQueueBloc get snackQueueBloc => _snackQueueBlocDep.get;

  @override
  ShaderBloc get shaderBloc => shaderModule.shaderBlocDep.get;

  @override
  DebugScopeHolder get debugScope => debugScopeHolder;

  @override
  SplashScopeHolder get splashScope => splashScopeHolder;

  @override
  LoggerStrategy get logger => loggerDep.get;

  @override
  IScopedHttpClientFactory get httpClientFactory => httpModule.httpClientFactoryDep.get;

  /// {@macro app_scope_container}
  AppScopeContainer({required super.data});

  LoggerStrategy _createLogger() {
    return Logger(strategies: []);
  }

  SnackQueueBloc _createSnackQueueBloc() {
    return SnackQueueBloc();
  }
}

/// {@template app_scope_holder}
/// A holder for the app scope.
/// {@endtemplate}
class AppScopeHolder extends DataScopeHolder<AppScopeContainer, Environment> {
  @override
  AppScopeContainer createContainer(Environment data) => AppScopeContainer(data: data);
}

/// {@template app_scope_storage_module}
/// A module for the app scope storage.
/// {@endtemplate}
class AppScopeStorageModule extends ScopeModule<AppScopeContainer> {
  /// The app database dependency.
  late final appDatabaseDep = rawAsyncDep(
    _createAppDatabase,
    init: (db) => SynchronousFuture(null),
    dispose: (db) async => db.close(),
  );

  /// The shared preferences dependency.
  late final sharedPreferencesDep = dep(createPreferences);

  /// The flutter secure storage dependency.
  late final flutterSecureStorageDep = dep(createFlutterSecureStorage);

  /// The secure storage dependency.
  late final secureStorageDep = dep<Storage>(_createSecureStorage);

  /// The storage dependency.
  late final storageDep = dep<Storage>(_createStorage);

  /// The encryption service dependency.
  late final encryptionServiceDep = rawAsyncDep(
    createEncryptionService,
    init: (encryptionService) => encryptionService.initialize(),
    dispose: (encryptionService) => SynchronousFuture(null),
  );

  /// The initialize list.
  Set<AsyncDepType> get initializeList => {appDatabaseDep, encryptionServiceDep};

  /// {@macro app_scope_storage_module}
  AppScopeStorageModule(super.container);

  Storage _createSecureStorage() {
    return createSecureStorage(
      encryptionService: encryptionServiceDep.get,
      flutterSecureStorage: flutterSecureStorageDep.get,
    );
  }

  Storage _createStorage() {
    return createStorage(
      sharedPreferences: sharedPreferencesDep.get,
    );
  }

  AppDatabase _createAppDatabase() {
    return AppDatabase();
  }
}

/// {@template app_scope_theme_module}
/// A module for the app scope theme.
/// {@endtemplate}
class AppScopeThemeModule extends ScopeModule<AppScopeContainer> {
  /// The theme bloc dependency.
  late final themeBlocDep = rawAsyncDep(
    _createThemeBloc,
    init: (bloc) async => bloc.add(ThemeInitialize()),
    dispose: (bloc) => bloc.close(),
  );

  /// The theme service dependency.
  late final themeServiceDep = rawAsyncDep(
    _createThemeService,
    init: (service) => service.initialize(),
    dispose: (service) => service.dispose(),
  );

  late final _themeRepositoryDep = dep<IThemeRepository>(_createThemeRepository);

  late final _themeStorageDep = dep<IThemeStorage>(_createThemeStorage);

  /// The initialize list.
  List<Set<AsyncDepType>> get initializeList => [
    {themeServiceDep},
    {themeBlocDep},
  ];

  /// {@macro app_scope_theme_module}
  AppScopeThemeModule(super.container);

  ThemeBloc _createThemeBloc() {
    return ThemeBloc(
      themeRepository: _themeRepositoryDep.get,
    );
  }

  IThemeRepository _createThemeRepository() {
    return ThemeRepository(
      themeService: themeServiceDep.get,
      logger: container.logger,
    );
  }

  IThemeService _createThemeService() {
    return ThemeService(
      themeStorage: _themeStorageDep.get,
      themeModeConverter: const ThemeModeConverter(),
    );
  }

  IThemeStorage _createThemeStorage() {
    return ThemeStorage(storage: container.storage);
  }
}

/// {@template app_scope_debug_module}
/// A module for the app scope debug.
/// {@endtemplate}
class AppScopeDebugModule extends ScopeModule<AppScopeContainer> {
  /// The debug repository dependency.
  late final debugRepositoryDep = dep<IDebugRepository>(_createDebugRepository);

  /// The debug service dependency.
  late final debugServiceDep = rawAsyncDep(
    _createDebugService,
    init: (debugService) => debugService.initialize(),
    dispose: (debugService) => debugService.dispose(),
  );

  /// The crash strategy dependency.
  late final crashStrategyDep = rawAsyncDep<CrashStrategy>(
    _createCrashStrategy,
    init: _initCrashStrategy,
    dispose: (crashStrategy) => crashStrategy.dispose(),
  );

  late final _debugStorageDep = dep<IDebugStorage>(_createDebugStorage);

  /// The initialize list.
  Set<AsyncDepType> get initializeList => {debugServiceDep, crashStrategyDep};

  /// The raw base URI.
  String? get rawBaseUri => debugServiceDep.get.baseUri.value?.toString();

  /// {@macro app_scope_debug_module}
  AppScopeDebugModule(super.container);

  IDebugRepository _createDebugRepository() {
    return DebugRepository(
      debugService: debugServiceDep.get,
      logger: container.logger,
    );
  }

  CrashStrategy _createCrashStrategy() => Crashlytics(strategies: []);

  Future<void> _initCrashStrategy(CrashStrategy crashStrategy) async {
    await crashStrategy.initialize();

    FlutterError.onError = crashStrategy.recordFatalError;

    PlatformDispatcher.instance.onError = (error, stack) {
      crashStrategy.recordFatalError(error, stack);

      return true;
    };

    return Future.value();
  }

  IDebugService _createDebugService() {
    return DebugService(debugStorage: _debugStorageDep.get);
  }

  IDebugStorage _createDebugStorage() {
    return DebugStorage(storage: container.storageModule.storageDep.get);
  }
}

/// {@template app_scope_http_module}
/// A module for the app scope http.
/// {@endtemplate}
class AppScopeHttpModule extends ScopeModule<AppScopeContainer> {
  /// The auth dio dependency.
  late final rootDioDep = rawAsyncDep(
    () => httpClientFactoryDep.get.getClientForScope('root_http_client'),
    init: (_) => SynchronousFuture(null),
    dispose: (_) async => httpClientFactoryDep.get.disposeScopeClient('root_http_client'),
  );

  /// The HTTP client factory dependency.
  late final httpClientFactoryDep = rawAsyncDep(
    _createHttpClientFactory,
    init: (factory) => SynchronousFuture(null),
    dispose: (factory) => factory.dispose(),
  );

  /// The initialize list.
  List<Set<AsyncDepType>> get initializeList => [
    {httpClientFactoryDep},
    {rootDioDep},
  ];

  /// {@macro app_scope_http_module}
  AppScopeHttpModule(super.container);

  LogInterceptor _createLogInterceptor() {
    return LogInterceptor(
      requestBody: true,
      responseBody: true,
    );
  }

  IScopedHttpClientFactory _createHttpClientFactory() {
    return ScopedHttpClientFactory(
      baseOptionsFactory: () => BaseOptions(
        connectTimeout: kDefaultConnectTimeout,
        receiveTimeout: kDefaultReceiveTimeout,
        sendTimeout: kDefaultSendTimeout,
        baseUrl: container.debugModule.rawBaseUri ?? container.url.value,
      ),
      interceptors: [_createLogInterceptor()],
    );
  }
}

/// {@template app_scope_shader_module}
/// A module for the app scope shader.
/// {@endtemplate}
class AppScopeShaderModule extends ScopeModule<AppScopeContainer> {
  /// The shader bloc dependency.
  late final shaderBlocDep = rawAsyncDep(
    _createShaderBloc,
    init: (bloc) async => bloc.add(const ShaderInitialize()),
    dispose: (bloc) => bloc.close(),
  );

  /// The shader service dependency.
  late final shaderServiceDep = rawAsyncDep(
    _createShaderService,
    init: (service) => service.initialize(),
    dispose: (service) => service.dispose(),
  );

  late final _shaderRepositoryDep = dep<IShaderRepository>(_createShaderRepository);

  /// The initialize list.
  List<Set<AsyncDepType>> get initializeList => [
    {shaderServiceDep},
    {shaderBlocDep},
  ];

  /// {@macro app_scope_shader_module}
  AppScopeShaderModule(super.container);

  ShaderBloc _createShaderBloc() {
    return ShaderBloc(
      shaderRepository: _shaderRepositoryDep.get,
    );
  }

  IShaderRepository _createShaderRepository() {
    return ShaderRepository(
      shaderService: shaderServiceDep.get,
      logger: container.logger,
    );
  }

  IShaderService _createShaderService() {
    return ShaderService();
  }
}

/// {@template environment_extension}
/// An extension for the environment.
/// {@endtemplate}
extension EnvironmentExtension on Environment {
  /// The URL.
  Urls get url => switch (buildType) {
    BuildType.production => Urls.release,
    BuildType.development || BuildType.qa => Urls.development,
  };
}
