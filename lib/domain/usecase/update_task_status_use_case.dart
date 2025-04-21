import 'package:todoist/domain/model/task.dart';
import 'package:todoist/domain/repository/task_repository.dart';

class UpdateTaskStatusUseCase {
  final TaskRepository taskRepository;

  UpdateTaskStatusUseCase(this.taskRepository);

  Future<void> execute(Task task, TaskStatus newStatus) async {
    await taskRepository.updateTaskStatus(task.copyWith(newStatus: newStatus));

    if ((task.status == TaskStatus.inProgress ||
            task.status == TaskStatus.toDo) &&
        newStatus == TaskStatus.done) {
      taskRepository.closeTask(task.id);
    } else if ((task.status == TaskStatus.done)) {
      taskRepository.openTask(task.id);
    }
  }
}
