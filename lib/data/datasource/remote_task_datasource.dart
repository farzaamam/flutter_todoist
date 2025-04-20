import 'package:dio/dio.dart';
import 'package:todoist/data/datasource/model/create_task_request_dto.dart';
import 'package:todoist/data/datasource/model/task_dto.dart';

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
      return (response.data as List).map((e) => TaskDto.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
