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
  Future<void> createTimeTracking(TaskTimeTracking timeTracking) async {
    await appDatabase.setTimeTracking(timeTracking.toTimeTrackingTable());
  }

  @override
  Future<void> updateTimeTracking(TaskTimeTracking timeTracking) async {
    await appDatabase.setTimeTracking(timeTracking.toTimeTrackingTable());
  }

}
