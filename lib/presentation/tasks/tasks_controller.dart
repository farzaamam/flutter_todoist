import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoist/di/global_providers.dart';
import 'package:todoist/domain/model/task.dart';
import 'package:todoist/domain/usecase/get_tasks_use_case.dart';
import 'package:todoist/domain/usecase/update_task_status_use_case.dart';

final tasksControllerProvider =
    StateNotifierProvider<TasksController, AsyncValue<List<Task>>>((ref) {
      final getTasksUseCase = ref.watch(getTaskUseCaseProvider);
      final updateTaskUseCase = ref.watch(updateTaskUseCaseProvider);

      return TasksController(getTasksUseCase, updateTaskUseCase);
    });

class TasksController extends StateNotifier<AsyncValue<List<Task>>> {
  final GetTasksUseCase getTasksUseCase;
  final UpdateTaskStatusUseCase updateTaskUseCase;
  late final StreamSubscription _subscription;

  TasksController(this.getTasksUseCase, this.updateTaskUseCase)
    : super(const AsyncLoading()) {
    _init();
  }

  //listens to the latest tasks
  void _init() {
    _subscription = getTasksUseCase.watchTasks().listen(
      (tasks) => state = AsyncValue.data(tasks),
      onError: (e, st) => state = AsyncValue.error(e, st),
    );
    refresh();
  }

  Future<void> refresh() async {
    await getTasksUseCase.refresh();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  updateTaskStatus(Task task, TaskStatus newStatus) async {
    if (task.status == newStatus) return;

    final previous = state.valueOrNull ?? [];
    try {
      final updatedTask = task.copyWith(newStatus: newStatus);
      await updateTaskUseCase.execute(task, newStatus);
      state = AsyncValue.data([
        for (final t in previous)
          if (t.id == task.id) updatedTask else t,
      ]);
    } catch (e, st) {
      // Rollback in case of error
      state = AsyncValue.data(previous);
      state = AsyncValue.error(e, st);
    }
  }
}
