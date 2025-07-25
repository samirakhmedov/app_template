import 'package:drift/drift.dart';

/// Items table.
class TodoTable extends Table {
  /// Id of an item.
  IntColumn get id => integer().autoIncrement()();

  /// Title of an item.
  TextColumn get title => text().withLength(min: 6, max: 32)();

  /// Content of an item.
  TextColumn get content => text().named('body')();

  /// Date of an item was created.
  DateTimeColumn get createdAt => dateTime().nullable()();

  /// Constructor.
  const TodoTable();
}
