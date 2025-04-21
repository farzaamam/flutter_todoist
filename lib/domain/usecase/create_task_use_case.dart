import 'package:todoist/domain/repository/task_repository.dart';

class CreateTaskUseCase {
  final TaskRepository taskRepository;

  CreateTaskUseCase(this.taskRepository);

  Future<void> execute(String title, String description) async {
    final task = await taskRepository.createTask(title, description);
    await taskRepository.saveTask(task);
  }
}
