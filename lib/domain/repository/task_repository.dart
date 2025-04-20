import 'package:todoist/domain/model/task.dart';

abstract class TaskRepository {
  Future<Task> createTask(String title, String description);

  Future<List<Task>> getTasks();
}
