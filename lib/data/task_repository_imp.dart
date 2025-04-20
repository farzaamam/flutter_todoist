import 'package:todoist/data/datasource/remote_task_datasource.dart';
import 'package:todoist/domain/repository/task_repository.dart';

class TaskRepositoryImp extends TaskRepository {
  final RemoteTaskDataSource remoteTaskDataSource;

  TaskRepositoryImp({required this.remoteTaskDataSource});

  @override
  Future<void> createTask(String title, String description) async {
    //TODO add created task to the db for offline mode
    return await remoteTaskDataSource.createTask(
      title: title,
      description: description,
    );
  }
}
