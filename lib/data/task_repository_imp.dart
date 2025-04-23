import 'package:todoist/data/datasource/db/database.dart';
import 'package:todoist/data/mapper.dart';
import 'package:todoist/data/datasource/remote/remote_task_datasource.dart';
import 'package:todoist/domain/model/task.dart';
import 'package:todoist/domain/repository/task_repository.dart';

class TaskRepositoryImp extends TaskRepository {
  final RemoteTaskDataSource remoteTaskDataSource;
  final AppDatabase appDatabase;

  TaskRepositoryImp({
    required this.remoteTaskDataSource,
    required this.appDatabase,
  });

  @override
  Future<Task> createTask(String title, String description) async {
    return (await remoteTaskDataSource.createTask(
      title: title,
      description: description,
    )).toTask();
  }

  @override
  Future<void> saveTask(Task task) async {
    await appDatabase.insertTask(task.toEntity());
  }

  @override
  Future<List<Task>> fetchTasksFromRemote() async {
    return (await remoteTaskDataSource.getTasks())
        .map((dto) => dto.toTask())
        .toList();
  }

  @override
  Future<void> saveTasks(List<Task> tasks) async {
    await appDatabase.saveTasks(
      (tasks.map((task) => task.toEntity()).toList()),
    );
  }

  @override
  Stream<List<Task>> watchTasksFromDb() {
    return appDatabase.watchAllTasks().map(
      (items) => items.map((taskEntity) => taskEntity.toTask()).toList(),
    );
  }

  @override
  Future<void> updateTaskStatus(Task task) async {
    await appDatabase.insertTask(task.toEntity());
    await remoteTaskDataSource.updateTaskStatus(task.id, task.status);
  }

  @override
  Future<void> closeTask(String taskId) async {
    remoteTaskDataSource.closeTask(taskId);
  }

  @override
  Future<void> openTask(String taskId) async {
    remoteTaskDataSource.openTask(taskId);
  }
}
