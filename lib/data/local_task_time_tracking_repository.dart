import 'package:todoist/data/datasource/db/database.dart';
import 'package:todoist/data/mapper.dart';
import 'package:todoist/domain/model/time_tracking.dart';
import 'package:todoist/domain/repository/time_tracking_repository.dart';

class LocalTaskTimeTrackingRepository extends TimeTrackingRepository {
  final AppDatabase appDatabase;

  LocalTaskTimeTrackingRepository({required this.appDatabase});

  @override
  Future<TaskTimeTracking?> getTimeTrackingById(String id) async {
    final timeTracking = await appDatabase.getTimeTrackingById(id);
    return timeTracking?.toTaskTimeTracking();
  }

  @override
  Future<void> setTaskTimeTrackingStartedTime(
    String taskId,
    int startedAt,
  ) async {
    await appDatabase.updateTaskStartedAt(taskId, startedAt);
  }

  @override
  Future<void> setTaskTimeTrackingDuration(
    String taskId,
    int updatedDuration,
  ) async {
    await appDatabase.updateTaskDuration(taskId, updatedDuration);
  }

  @override
  Future<void> createTimeTracking(String taskId) async {
    await appDatabase.insertTimeTracking(
      TimeTrackingTable(id: taskId, duration: 0, startedAt: 0),
    );
  }
}
