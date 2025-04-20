import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoist/di/global_providers.dart';
import 'package:todoist/domain/model/task.dart';
import 'package:todoist/domain/usecase/get_tasks_use_case.dart';

final tasksControllerProvider =
    StateNotifierProvider<TasksController, AsyncValue<List<Task>>>((ref) {
      final getTasksUseCase = ref.watch(getTaskUseCaseProvider);
      return TasksController(getTasksUseCase);
    });

class TasksController extends StateNotifier<AsyncValue<List<Task>>> {
  final GetTasksUseCase getTasksUseCase;

  TasksController(this.getTasksUseCase) : super(const AsyncValue.loading()){
    _fetchTasks();
  }

  _fetchTasks() async {
    try {
      final tasks = await getTasksUseCase.execute();
      state = AsyncValue.data(tasks);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() => _fetchTasks();

   updateTaskStatus(Task task, TaskStatus newStatus) async{
     //TODO update in reposiory and send request
     final previous = state.valueOrNull ?? [];
     try {
       final updatedTask = task.copyWith(newStatus: newStatus);
       state = AsyncValue.data([
         for (final t in previous)
           if (t.id == task.id) updatedTask else t,
       ]);

       //await updateTaskStatusUseCase.execute(task, newStatus);
     } catch (e, st) {

       // Rollback in case of error
       state = AsyncValue.data(previous);
       state = AsyncValue.error(e, st);
     }
   }
}
