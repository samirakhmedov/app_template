import 'package:app_domain/app_domain.dart';
import 'package:yx_scope/yx_scope.dart';

abstract interface class DependenciesRegistrar<D> implements Disposable {
  Future<D> initialize();
}

typedef AsyncDepType = AsyncDep<Object?>;
