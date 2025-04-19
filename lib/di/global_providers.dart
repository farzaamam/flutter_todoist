import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoist/data/task_repository_imp.dart';
import 'package:todoist/domain/repository/task_repository.dart';
import 'package:todoist/domain/usecase/create_task_use_case.dart';

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepositoryImp();
});

final createTaskUseCaseProvider = Provider<CreateTaskUseCase>((ref) {
  final repo = ref.read(taskRepositoryProvider);
  return CreateTaskUseCase(repo);
});
