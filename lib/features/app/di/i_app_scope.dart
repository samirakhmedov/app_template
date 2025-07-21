import 'package:app_template/core/config/environment/environment.dart';
import 'package:app_template/core/domain/logger/logger_strategy.dart';
import 'package:app_template/features/common/presentation/state/shader/shader_bloc.dart';
import 'package:app_template/features/common/presentation/state/snack/snack_queue_bloc.dart';
import 'package:app_template/features/debug/di/debug_scope_container.dart';
import 'package:app_template/features/debug/domain/repositories/i_debug_repository.dart';
import 'package:app_template/features/splash/di/splash_scope_container.dart';
import 'package:app_template/features/theme/presentation/state/bloc/theme_bloc.dart';
import 'package:database/database.dart';
import 'package:network/network.dart';
import 'package:storage/storage.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template i_app_scope}
/// An interface for the app scope.
/// {@endtemplate}
abstract interface class IAppScope implements Scope {
  /// The environment.
  Environment get environment;

  /// The app database.
  IRevivableDatabase get appDatabase;

  /// The auth dio.
  Dio get authDio;

  /// The secure storage.
  Storage get secureStorage;

  /// The storage.
  Storage get storage;

  /// The debug repository.
  IDebugRepository get debugRepository;

  /// The theme bloc.
  ThemeBloc get themeBloc;

  /// The snack queue bloc.
  SnackQueueBloc get snackQueueBloc;

  /// The shader bloc.
  ShaderBloc get shaderBloc;

  /// The logger.
  LoggerStrategy get logger;

  /// The debug scope.
  DebugScopeHolder get debugScope;

  /// The splash scope.
  SplashScopeHolder get splashScope;

  /// The HTTP client factory.
  IScopedHttpClientFactory get httpClientFactory;
}
