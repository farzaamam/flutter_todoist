import 'package:dio/dio.dart';
import 'package:todoist/data/datasource/model/create_task_request.dart';

class RemoteTaskDataSource {
  final Dio dio;

  RemoteTaskDataSource(this.dio);

  Future<void> createTask({
    required String title,
    required String description,
  }) async {
    try {
      final response = await dio.post(
        'tasks',
        data:
            CreateTaskRequest(
              content: title,
              description: description,
            ).toJson(),
      );


    } catch (e) {
      rethrow;
    }
  }
}
