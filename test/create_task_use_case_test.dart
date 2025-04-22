import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:todoist/domain/repository/task_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:todoist/domain/usecase/create_task_use_case.dart';
import 'create_task_use_case_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  late CreateTaskUseCase createTask;
  final mockTaskRepository = MockTaskRepository();
  final taskTitle = "title";
  final taskDescription = "description";
  setUp(() {
    createTask = CreateTaskUseCase(mockTaskRepository);
  });
  group('createTask', () {
    test('should create a task using the repository', () async {
      when(
        mockTaskRepository.createTask(taskTitle, taskDescription),
      ).thenAnswer((_) async => Future.value());

      await createTask.execute(taskTitle, taskDescription);

      verify(
        mockTaskRepository.createTask(taskTitle, taskDescription),
      ).called(1);
    });
    test('should throw if repository throws', () async {
      when(
        mockTaskRepository.createTask(taskTitle, taskDescription),
      ).thenThrow(Exception('fail'));

      expect(
        () => createTask.execute(taskTitle, taskDescription),
        throwsA(isA<Exception>()),
      );
    });
  });
}
