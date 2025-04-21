import 'package:todoist/domain/model/task.dart';

abstract class TaskRepository {
  Future<Task> createTask(String title, String description);

  Future<void> saveTask(Task task);

  Stream<List<Task>> watchTasksFromDb();

  Future<List<Task>> fetchTasksFromRemote();

  Future<void> saveTasks(List<Task> tasks);

  Future<void> updateTaskStatus(Task task);

  Future<void> openTask(String taskId);

  Future<void> closeTask(String taskId);
}
