import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoist/di/global_providers.dart';
import 'package:todoist/domain/usecase/create_task_use_case.dart';

final createTaskControllerProvider = StateNotifierProvider.autoDispose((ref) {
  final useCase = ref.read(createTaskUseCaseProvider);
  return CreateTaskController(createTaskUseCase: useCase);
});

class CreateTaskController extends StateNotifier<CreateTaskState> {
  CreateTaskController({required this.createTaskUseCase})
    : super(CreateTaskState());

  final CreateTaskUseCase createTaskUseCase;

  void setTitle(String value) {
    state = state.copyWith(title: value);
  }

  void setDescription(String value) {
    state = state.copyWith(description: value);
  }

  Future<bool> submit() async {
    state = state.copyWith(isSubmitting: true);
    try {
      await createTaskUseCase.execute(state.title, state.description);
      state = state.copyWith(isSubmitting: false);
      return true;
    } catch (e) {
      state = state.copyWith(isSubmitting: false);
      return false;
    }
  }
}

class CreateTaskState {
  String title;
  String description;
  final bool isSubmitting;

  CreateTaskState({
    this.title = '',
    this.description = '',
    this.isSubmitting = false,
  });

  CreateTaskState copyWith({
    String? title,
    String? description,
    bool? isSubmitting,
  }) {
    return CreateTaskState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}
