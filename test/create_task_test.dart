import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:todoist/domain/repository/task_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:todoist/domain/usecase/create_task_use_case.dart';

import 'create_task_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  late CreateTaskUseCase createTask;
  final mockTaskRepository = MockTaskRepository();
  final taskContent = "content";
  setUp(() {
    createTask = CreateTaskUseCase(mockTaskRepository);
  });
  group('createTask', () {
    test('should create a task using the repository', () async {
      when(
        mockTaskRepository.createTask(taskContent),
      ).thenAnswer((_) async => Future.value());

      await createTask.execute(taskContent);

      verify(mockTaskRepository.createTask(taskContent)).called(1);
    });
    test('should throw if repository throws', () async {

      when(mockTaskRepository.createTask(taskContent)).thenThrow(Exception('fail'));

      expect(() => createTask.execute(taskContent), throwsA(isA<Exception>()));
    });
  });
}
