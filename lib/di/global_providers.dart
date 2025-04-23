import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoist/data/RemoteCommentRepository.dart';
import 'package:todoist/data/datasource/db/database.dart';
import 'package:todoist/data/datasource/remote/remote_comment_datasource.dart';
import 'package:todoist/data/datasource/remote/remote_task_datasource.dart';
import 'package:todoist/data/local_task_time_tracking_repository.dart';
import 'package:todoist/data/task_repository_imp.dart';
import 'package:todoist/domain/repository/CommentRepository.dart';
import 'package:todoist/domain/repository/task_repository.dart';
import 'package:todoist/domain/repository/time_tracking_repository.dart';
import 'package:todoist/domain/usecase/create_task_use_case.dart';
import 'package:todoist/domain/usecase/get_tasks_use_case.dart';
import 'package:todoist/domain/usecase/time_tracking_use_case.dart';
import 'package:todoist/domain/usecase/update_task_status_use_case.dart';

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final remote = ref.watch(taskRemoteDataSourceProvider);
  final db = ref.watch(appDatabaseProvider);

  return TaskRepositoryImp(remoteTaskDataSource: remote, appDatabase: db);
});

final timeTrackingRepositoryProvider = Provider<TimeTrackingRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return LocalTaskTimeTrackingRepository(appDatabase: db);
});
final timeTrackingUseCaseProvider = Provider<TimeTrackingUseCase>((ref) {
  final repo = ref.read(timeTrackingRepositoryProvider);
  return TimeTrackingUseCase(repository: repo);
});

final createTaskUseCaseProvider = Provider<CreateTaskUseCase>((ref) {
  final repo = ref.read(taskRepositoryProvider);
  return CreateTaskUseCase(repo);
});

final updateTaskUseCaseProvider = Provider<UpdateTaskStatusUseCase>((ref) {
  final repo = ref.read(taskRepositoryProvider);
  return UpdateTaskStatusUseCase(repo);
});

final getTaskUseCaseProvider = Provider<GetTasksUseCase>((ref) {
  final repo = ref.read(taskRepositoryProvider);
  return GetTasksUseCase(repo);
});

final dioProvider = Provider<Dio>((ref) {
  final token = dotenv.env['AUTH_TOKEN'];
  return Dio(
    BaseOptions(
      baseUrl: 'https://api.todoist.com/rest/v2/',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ),
  );
});

final taskRemoteDataSourceProvider = Provider<RemoteTaskDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return RemoteTaskDataSource(dio);
});
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final commentRemoteDataSourceProvider = Provider<RemoteCommentDataSource>((
  ref,
) {
  final dio = ref.watch(dioProvider);
  return RemoteCommentDataSource(dio: dio);
});

final commentRepositoryProvider = Provider<CommentRepository>((ref) {
  final remoteDataSource = ref.watch(commentRemoteDataSourceProvider);
  return RemoteCommentRepository(remoteDataSource);
});
