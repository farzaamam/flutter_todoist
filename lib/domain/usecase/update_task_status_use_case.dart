import 'package:todoist/domain/model/completed_task_history.dart';
import 'package:todoist/domain/model/task.dart';
import 'package:todoist/domain/model/time_tracking.dart';
import 'package:todoist/domain/repository/completed_task_repository.dart';
import 'package:todoist/domain/repository/task_repository.dart';
import 'package:todoist/domain/repository/time_tracking_repository.dart';

class UpdateTaskStatusUseCase {
  final TaskRepository taskRepository;

  final TimeTrackingRepository timeTrackingRepository;

  final CompletedTaskRepository completedTaskRepository;

  UpdateTaskStatusUseCase(
    this.taskRepository,
    this.timeTrackingRepository,
    this.completedTaskRepository,
  );

  Future<void> execute(Task task, TaskStatus newStatus) async {
    await taskRepository.updateTaskStatus(task.copyWith(newStatus: newStatus));

    if ((task.status == TaskStatus.inProgress ||
            task.status == TaskStatus.toDo) &&
        newStatus == TaskStatus.done) {
      await taskRepository.closeTask(task.id);

      TaskTimeTracking? timeTracking = await timeTrackingRepository
          .getTimeTrackingById(task.id);
      if (timeTracking != null) {
        timeTracking.stop();
        await timeTrackingRepository.updateTimeTracking(timeTracking);
      }

      await completedTaskRepository.addCompletedTask(
        CompletedTaskHistory(
          task.content,
          task.description,
          task.id,
          timeTracking == null ? 0 : timeTracking.getTotalTrackedTime(),
          DateTime.now().millisecondsSinceEpoch ~/ 1000,
        ),
      );
    }
  }
}
