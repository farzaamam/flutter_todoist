import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoist/di/global_providers.dart';
import 'package:todoist/domain/model/completed_task_history.dart';
import 'package:todoist/domain/repository/completed_task_repository.dart';

class CompletedTasksController extends StateNotifier<AsyncValue<List<CompletedTaskHistory>>> {
  final CompletedTaskRepository repository;

  CompletedTasksController(this.repository) : super(const AsyncValue.loading()) {
    _watchCompletedTasks();
  }

  void _watchCompletedTasks() {
    repository.watchCompletedTasksFromDb().listen(
          (tasks) => state = AsyncValue.data(tasks),
      onError: (err, stack) => state = AsyncValue.error(err, stack),
    );
  }
}

final completedTasksControllerProvider =
StateNotifierProvider<CompletedTasksController, AsyncValue<List<CompletedTaskHistory>>>(
      (ref) {
    final repo = ref.read(taskHistoryRepositoryProvider); // Your actual repo provider
    return CompletedTasksController(repo);
  },
);