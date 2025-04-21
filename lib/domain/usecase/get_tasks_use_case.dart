import 'package:todoist/domain/model/task.dart';
import 'package:todoist/domain/repository/task_repository.dart';

class GetTasksUseCase {
  final TaskRepository taskRepository;

  GetTasksUseCase(this.taskRepository);

  Stream<List<Task>> watchTasks() {
    return taskRepository.watchTasksFromDb();
  }

  Future<void> refresh() async {
    try {
      final remoteTasks = await taskRepository.fetchTasksFromRemote();

      await taskRepository.saveTasks(remoteTasks);
    } catch (e) {
      rethrow;
    }
  }
}
