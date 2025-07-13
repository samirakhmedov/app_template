import 'package:app_template/core/architecture/di/disposable.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template dependencies_registrar}
/// A registrar for the dependencies.
/// {@endtemplate}
abstract interface class DependenciesRegistrar<D> implements Disposable {
  /// {@macro dependencies_registrar}
  Future<D> initialize();
}

/// {@template async_dep_type}
/// A type for an asynchronous dependency.
/// {@endtemplate}
typedef AsyncDepType = AsyncDep<Object?>;
