import 'dart:io';

import 'package:database/src/constants.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

/// {@template database_factory}
/// Factory methods for creating QueryExecutor instances.
/// {@endtemplate}
class DatabaseFactory {
  /// Creates a default QueryExecutor with app directory.
  static QueryExecutor createDefaultExecutor() {
    return driftDatabase(
      name: kDefaultDatabaseName,
      native: const DriftNativeOptions(databaseDirectory: getApplicationSupportDirectory),
    );
  }

  /// Creates a configurable QueryExecutor.
  static QueryExecutor createExecutor({String? name, Future<Directory> Function()? directory}) {
    return driftDatabase(
      name: name ?? kDefaultDatabaseName,
      native: DriftNativeOptions(databaseDirectory: directory ?? getApplicationSupportDirectory),
    );
  }
}
