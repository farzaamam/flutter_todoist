import 'package:todoist/data/mapper.dart';
import 'package:todoist/data/datasource/remote_task_datasource.dart';
import 'package:todoist/domain/model/task.dart';
import 'package:todoist/domain/repository/task_repository.dart';

class TaskRepositoryImp extends TaskRepository {
  final RemoteTaskDataSource remoteTaskDataSource;

  TaskRepositoryImp({required this.remoteTaskDataSource});

  @override
  Future<Task> createTask(String title, String description) async {
    return (await remoteTaskDataSource.createTask(
      title: title,
      description: description,
    )).toTask();
  }

  @override
  Future<List<Task>> getTasks() async {
    return (await remoteTaskDataSource.getTasks())
        .map((dto) => dto.toTask())
        .toList();
  }
}
