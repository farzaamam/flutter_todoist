import 'package:todoist/domain/repository/task_repository.dart';

class CreateTaskUseCase {
  final TaskRepository taskRepository;

  CreateTaskUseCase(this.taskRepository);

  Future<void> execute(String title, String description) async {
    await taskRepository.createTask(title, description);
  }
}
