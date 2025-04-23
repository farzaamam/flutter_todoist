import 'package:todoist/domain/model/time_tracking.dart';
import 'package:todoist/domain/repository/time_tracking_repository.dart';

class TimeTrackingUseCase {
  final TimeTrackingRepository repository;

  TimeTrackingUseCase({required this.repository});

  Future<void> start(String taskId) async {
    TaskTimeTracking? timeTracking = await repository.getTimeTrackingById(
      taskId,
    );

    if (timeTracking == null) {
      timeTracking = TaskTimeTracking(taskId: taskId);
      await repository.createTimeTracking(timeTracking);
    }
    timeTracking.start();

    await repository.updateTimeTracking(timeTracking);
  }

  Future<void> stop(String taskId) async {
    repository.stop(taskId);
  }

  Future<TaskTimeTracking?> getTimeTrackingByTaskId(String taskId) async {
    return await repository.getTimeTrackingById(taskId);
  }
}
