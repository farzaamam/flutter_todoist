import 'package:todoist/domain/model/completed_task_history.dart';

abstract class CompletedTaskRepository {
  Future<void> addCompletedTask(CompletedTaskHistory task);

  Stream<List<CompletedTaskHistory>> watchCompletedTasksFromDb();

  Future<List<CompletedTaskHistory>> getCompletedTasks();
}
