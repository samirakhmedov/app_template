import 'package:database/src/constants.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

/// {@template app_database}
/// A database for the app.
/// {@endtemplate}
@DriftDatabase(tables: [])
class AppDatabase extends _$AppDatabase {
  @override
  int get schemaVersion => 1;

  /// {@macro app_database}
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: kDefaultDatabaseName,
      native: const DriftNativeOptions(databaseDirectory: getApplicationSupportDirectory),
    );
  }
}
