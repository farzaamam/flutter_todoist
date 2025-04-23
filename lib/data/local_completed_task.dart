import 'package:todoist/data/datasource/db/database.dart';
import 'package:todoist/data/mapper.dart';
import 'package:todoist/domain/model/completed_task_history.dart';
import 'package:todoist/domain/repository/completed_task_repository.dart';

class LocalCompletedTaskHistory extends CompletedTaskRepository {
  final AppDatabase appDatabase;

  LocalCompletedTaskHistory(this.appDatabase);

  @override
  Future<void> addCompletedTask(CompletedTaskHistory task) async {
    await appDatabase.insertCompletedTask(task.toTable());
  }

  @override
  Future<List<CompletedTaskHistory>> getCompletedTasks() async {
    return (await appDatabase.getAllCompletedTasks())
        .map((table) => table.toDomain())
        .toList();
  }

  @override
  Stream<List<CompletedTaskHistory>> watchCompletedTasksFromDb() {
    return appDatabase.watchCompletedTasks().map(
      (items) => items.map((history) => history.toDomain()).toList(),
    );
  }
}
