import 'package:database/src/app_database.dart';
import 'package:drift/drift.dart';

/// {@template revivable_database_manager}
/// Singleton managing single AppDatabase instance with revival capabilities.
/// {@endtemplate}
class RevivableDatabaseManager implements IRevivableDatabase {
  static final RevivableDatabaseManager _instance = RevivableDatabaseManager._internal();

  /// Gets the singleton instance of RevivableDatabaseManager.
  static RevivableDatabaseManager get instance => _instance;

  AppDatabase? _database;
  bool _isCompletelyDisposed = false;
  QueryExecutor Function()? _executorFactory;

  RevivableDatabaseManager._internal();

  /// Gets the database instance, creating it lazily if needed.
  @override
  AppDatabase get database {
    if (_isCompletelyDisposed) throw StateError('Database permanently disposed');

    return _database ??= AppDatabase(_executorFactory?.call());
  }

  /// Initializes the database manager with executor factory.
  void initialize(QueryExecutor Function() executorFactory) {
    _executorFactory = executorFactory;
  }

  /// Handles memory pressure by temporarily closing database connection.
  @override
  void handleMemoryPressure() {
    _database?.close();
    _database = null;
  }

  /// Permanently disposes the database, preventing recreation.
  @override
  void disposeCompletely() {
    _database?.close();
    _database = null;
    _isCompletelyDisposed = true;
  }

  /// Checks if the database is permanently disposed.
  bool get isDisposed => _isCompletelyDisposed;
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
