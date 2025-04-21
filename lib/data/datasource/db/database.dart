import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

class TodoItems extends Table {
  TextColumn get id => text()();

  TextColumn get title => text()();

  TextColumn get description => text()();

  TextColumn get status => text()();

  TextColumn get url => text()();

  DateTimeColumn get createdAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [TodoItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<TodoItem>> getAllTasks() => select(todoItems).get();

  Stream<List<TodoItem>> watchAllTasks() => select(todoItems).watch();

  Future<void> insertTask(TodoItem task) async {
    into(todoItems).insertOnConflictUpdate(task);
  }

  Future<void> saveTasks(List<TodoItem> tasks) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(todoItems, tasks);
    });
  }

  Future<TodoItem?> getTaskById(String id) {
    return (select(todoItems)
      ..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'my_database');
  }
}
