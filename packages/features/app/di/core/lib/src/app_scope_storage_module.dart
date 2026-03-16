import 'package:database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:storage/storage.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template app_scope_storage_module}
/// A module providing storage infrastructure: database, secure storage,
/// shared preferences, and encryption.
///
/// Self-contained — accesses no container properties beyond its own deps.
/// {@endtemplate}
class AppScopeStorageModule<T extends BaseScopeContainer> extends ScopeModule<T> {
  /// The revivable database manager dependency.
  late final revivableDatabaseManagerDep = rawAsyncDep(
    _createRevivableDatabaseManager,
    init: (manager) {
      manager.initialize(DatabaseFactory.createDefaultExecutor);

      return SynchronousFuture(null);
    },
    dispose: (manager) async => manager.disposeCompletely(),
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

  RevivableDatabaseManager _createRevivableDatabaseManager() {
    return RevivableDatabaseManager.instance;
  }
}
