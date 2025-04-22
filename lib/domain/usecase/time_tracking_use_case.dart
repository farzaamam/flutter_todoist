import 'package:todoist/domain/repository/time_tracking_repository.dart';

class TimeTrackingUseCase {
  final TimeTrackingRepository repository;

  TimeTrackingUseCase({required this.repository});

  Future<void> start(String taskId) async {
    final nowInSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final timeTracking = await repository.getTimeTrackingById(taskId);
    if (timeTracking == null) {
      await repository.createTimeTracking(taskId);
    }
    await repository.setTaskTimeTrackingStartedTime(taskId, nowInSeconds);
  }

  Future<void> stop(String taskId) async {
    final timeTracking = await repository.getTimeTrackingById(taskId);
    if (timeTracking == null) {
      repository.createTimeTracking(taskId);
      await _stop(taskId);
    } else {
      await _stop(taskId);
    }
  }

  Future<int> getTotalTrackedTime(String taskId) async {
    final timeTracking = await repository.getTimeTrackingById(taskId);
    if (timeTracking == null) return 0;

    final nowInSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    final isRunning = timeTracking.startedAt != 0;
    if (isRunning) {
      return timeTracking.duration + (nowInSeconds - timeTracking.startedAt);
    } else {
      return timeTracking.duration;
    }
  }

  Future<bool> isRunning(String taskId) async {
    final timeTracking = await repository.getTimeTrackingById(taskId);
    if (timeTracking == null) return false;
    return timeTracking.startedAt != 0;
  }

  _stop(String taskId) async {
    final timeTracking = await repository.getTimeTrackingById(taskId);

    final nowInSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final updatedDuration =
        timeTracking!.duration + (nowInSeconds - timeTracking.startedAt);
    await repository.setTaskTimeTrackingDuration(taskId, updatedDuration);

    await repository.setTaskTimeTrackingStartedTime(taskId, 0);
  }
}
