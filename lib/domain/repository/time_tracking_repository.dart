import 'package:todoist/domain/model/time_tracking.dart';

abstract class TimeTrackingRepository {
  Future<void> setTaskTimeTrackingStartedTime(String taskId, int startedTime);

  Future<TaskTimeTracking?> getTimeTrackingById(String id);

  Future<void> setTaskTimeTrackingDuration(String taskId, int updatedDuration);

  Future<void> createTimeTracking(String taskId);
}
