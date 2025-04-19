import 'package:todoist/domain/repository/task_repository.dart';

class TaskRepositoryImp extends TaskRepository {
  @override
  Future<void> createTask(String title, String description) async {
    // TODO: implement createTask
    await Future.delayed(Duration(seconds: 5));
    return Future.value();
  }
}
