import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoist/data/datasource/remote_task_datasource.dart';
import 'package:todoist/data/task_repository_imp.dart';
import 'package:todoist/domain/repository/task_repository.dart';
import 'package:todoist/domain/usecase/create_task_use_case.dart';
import 'package:todoist/domain/usecase/get_tasks_use_case.dart';

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final remote = ref.watch(taskRemoteDataSourceProvider);

  return TaskRepositoryImp(remoteTaskDataSource: remote);
});

final createTaskUseCaseProvider = Provider<CreateTaskUseCase>((ref) {
  final repo = ref.read(taskRepositoryProvider);
  return CreateTaskUseCase(repo);
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
