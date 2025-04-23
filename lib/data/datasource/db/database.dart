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

class TimeTrackingTables extends Table {
  TextColumn get id => text()();

  IntColumn get duration => integer().withDefault(const Constant(0))();

  IntColumn get startedAt => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [TodoItems, TimeTrackingTables])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<TodoItem>> getAllTasks() => select(todoItems).get();

  Stream<List<TodoItem>> watchAllTasks() => select(todoItems).watch();

  Future<void> insertTask(TodoItem task) async {
    await into(todoItems).insertOnConflictUpdate(task);
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

  Future<TimeTrackingTable?> getTimeTrackingById(String id) {
    return (select(timeTrackingTables)
      ..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }


  Future<void> updateTaskDuration(String taskId, int newDuration) async {
    await (update(timeTrackingTables)..where(
      (tbl) => tbl.id.equals(taskId),
    )).write(TimeTrackingTablesCompanion(duration: Value(newDuration)));
  }

  Future<void> updateTaskStartedAt(String taskId, int startedAt) async {
    await (update(timeTrackingTables)..where(
      (tbl) => tbl.id.equals(taskId),
    )).write(TimeTrackingTablesCompanion(startedAt: Value(startedAt)));
  }

  Future<void> insertTimeTracking(TimeTrackingTable timeTracking) async {
    await into(timeTrackingTables).insertOnConflictUpdate(timeTracking);
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'my_database');
  }
}
