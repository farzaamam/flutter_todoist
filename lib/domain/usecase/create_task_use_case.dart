import 'package:todoist/domain/repository/task_repository.dart';

class CreateTaskUseCase {
  final TaskRepository taskRepository;

  CreateTaskUseCase(this.taskRepository);

  Future<void> execute(String content) async {
    await taskRepository.createTask(content);
  }
}
