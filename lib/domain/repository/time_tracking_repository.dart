import 'package:todoist/domain/model/time_tracking.dart';

abstract class TimeTrackingRepository {
  Future<void> updateTimeTracking(TaskTimeTracking timeTracking);

  Future<TaskTimeTracking?> getTimeTrackingById(String id);

  Future<void> createTimeTracking(TaskTimeTracking timeTracking);

  Future<void> stop(String taskId);
}
