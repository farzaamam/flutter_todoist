import 'package:todoist/domain/model/task.dart';
import 'package:todoist/domain/repository/task_repository.dart';

class GetTasksUseCase {
  final TaskRepository taskRepository;

  GetTasksUseCase(this.taskRepository);

  Future<List<Task>> execute() async {
    return await taskRepository.getTasks();
  }
}
