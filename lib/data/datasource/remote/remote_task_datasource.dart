import 'package:dio/dio.dart';
import 'package:todoist/data/datasource/remote/model/create_task_request_dto.dart';
import 'package:todoist/data/datasource/remote/model/task_dto.dart';
import 'package:todoist/data/datasource/remote/model/update_task_status_request_dto.dart';
import 'package:todoist/data/mapper.dart';
import 'package:todoist/domain/model/task.dart';

class RemoteTaskDataSource {
  final Dio dio;

  RemoteTaskDataSource(this.dio);

  Future<TaskDto> createTask({
    required String title,
    required String description,
  }) async {
    try {
      final response = await dio.post(
        'tasks',
        data:
            CreateTaskRequestDto(
              content: title,
              description: description,
            ).toJson(),
      );
      return TaskDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TaskDto>> getTasks() async {
    try {
      final response = await dio.get('tasks');
      final tasks =
          (response.data as List).map((e) => TaskDto.fromJson(e)).toList();
      return tasks;
    } catch (e) {
      rethrow;
    }
  }

  updateTaskStatus(String taskId, TaskStatus newStatus) async {
    try {
      final response = await dio.post(
        'tasks/$taskId',
        data: UpdateTaskStatusRequestDto(labels: [newStatus.label]).toJson(),
      );
      return TaskDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> closeTask(String taskId) async {
    await dio.post('tasks/$taskId/close');
  }

  Future<void> openTask(String taskId) async {
    await dio.post('tasks/$taskId/reopen');
  }
}
