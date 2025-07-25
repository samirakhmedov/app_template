import 'dart:async';

import 'package:database/src/app_database.dart';
import 'package:drift/drift.dart';

/// {@template revivable_database_manager}
/// Singleton managing single AppDatabase instance with revival capabilities.
/// {@endtemplate}
class RevivableDatabaseManager implements IRevivableDatabase {
  static final RevivableDatabaseManager _instance = RevivableDatabaseManager._internal();

  AppDatabase? _database;
  bool _isCompletelyDisposed = false;
  QueryExecutorFactory? _executorFactory;

  /// Gets the singleton instance of RevivableDatabaseManager.
  static RevivableDatabaseManager get instance => _instance;

  /// Gets the database instance, creating it lazily if needed.
  @override
  AppDatabase get database {
    if (_isCompletelyDisposed) throw StateError('Database permanently disposed');

    return _database ??= AppDatabase(_executorFactory?.call());
  }

  /// Checks if the database is permanently disposed.
  bool get isDisposed => _isCompletelyDisposed;

  RevivableDatabaseManager._internal();

  /// Initializes the database manager with executor factory.
  void initialize(QueryExecutorFactory executorFactory) {
    _executorFactory = executorFactory;
  }

  /// Handles memory pressure by temporarily closing database connection.
  @override
  void handleMemoryPressure() {
    unawaited(_database?.close());
    _database = null;
  }

  /// Permanently disposes the database, preventing recreation.
  @override
  void disposeCompletely() {
    unawaited(_database?.close());
    _database = null;
    _isCompletelyDisposed = true;
  }
}

/// Revivable database interface.
abstract interface class IRevivableDatabase {
  /// Gets the database instance, creating it lazily if needed.
  AppDatabase get database;

  /// Handles memory pressure by temporarily closing database connection.
  void handleMemoryPressure();

  /// Permanently disposes the database, preventing recreation.
  void disposeCompletely();
}

/// Factory for query executor.
typedef QueryExecutorFactory = QueryExecutor Function();
