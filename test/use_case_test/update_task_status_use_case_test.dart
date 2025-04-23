import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todoist/domain/model/task.dart';
import 'package:todoist/domain/model/time_tracking.dart';
import 'package:todoist/domain/repository/completed_task_repository.dart';
import 'package:todoist/domain/repository/task_repository.dart';
import 'package:todoist/domain/repository/time_tracking_repository.dart';
import 'package:todoist/domain/usecase/update_task_status_use_case.dart';

import '../provider_controller_test/completed_task_controller_test.mocks.dart';
import 'create_task_use_case_test.mocks.dart';
import 'time_tracking_use_case_test.mocks.dart';


@GenerateMocks([TaskRepository, TimeTrackingRepository, CompletedTaskRepository])
void main() {
  late MockTaskRepository mockTaskRepository;
  late MockTimeTrackingRepository mockTimeTrackingRepository;
  late MockCompletedTaskRepository mockCompletedTaskRepository;
  late UpdateTaskStatusUseCase useCase;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    mockTimeTrackingRepository = MockTimeTrackingRepository();
    mockCompletedTaskRepository = MockCompletedTaskRepository();
    useCase = UpdateTaskStatusUseCase(
      mockTaskRepository,
      mockTimeTrackingRepository,
      mockCompletedTaskRepository,
    );
  });

  const taskId = 'task-123';

  Task buildTask(TaskStatus status) => Task(
    'Test task',
    'Test description',
      taskId,
      "",
     status
  );

  test('should only update status when not changing to "done"', () async {
    final task = buildTask(TaskStatus.toDo);

    when(mockTaskRepository.updateTaskStatus(any)).thenAnswer((_) async {});

    await useCase.execute(task, TaskStatus.inProgress);

    verify(mockTaskRepository.updateTaskStatus(any)).called(1);
    verifyNever(mockTaskRepository.closeTask(task.id));
    verifyZeroInteractions(mockTimeTrackingRepository);
    verifyZeroInteractions(mockCompletedTaskRepository);
  });

  test('should update status, stop time tracking, and add completed history on completion', () async {
    final task = buildTask(TaskStatus.inProgress);
    final tracking = TaskTimeTracking(taskId: taskId);
    tracking.start(); // Start before stopping

    when(mockTaskRepository.updateTaskStatus(any)).thenAnswer((_) async {});
    when(mockTaskRepository.closeTask(taskId)).thenAnswer((_) async {});
    when(mockTimeTrackingRepository.getTimeTrackingById(taskId))
        .thenAnswer((_) async => tracking);
    when(mockTimeTrackingRepository.updateTimeTracking(tracking))
        .thenAnswer((_) async {});
    when(mockCompletedTaskRepository.addCompletedTask(any))
        .thenAnswer((_) async {});

    await useCase.execute(task, TaskStatus.done);

    expect(tracking.isRunning(), false);

    verify(mockTaskRepository.updateTaskStatus(any)).called(1);
    verify(mockTaskRepository.closeTask(taskId)).called(1);
    verify(mockTimeTrackingRepository.updateTimeTracking(tracking)).called(1);
    verify(mockCompletedTaskRepository.addCompletedTask(any)).called(1);
  });

  test('should handle null time tracking by updating and add to the history', () async {
    final task = buildTask(TaskStatus.inProgress);

    when(mockTaskRepository.updateTaskStatus(any)).thenAnswer((_) async {});
    when(mockTaskRepository.closeTask(taskId)).thenAnswer((_) async {});
    when(mockTimeTrackingRepository.getTimeTrackingById(taskId))
        .thenAnswer((_) async => null);
    when(mockCompletedTaskRepository.addCompletedTask(any))
        .thenAnswer((_) async {});

    await useCase.execute(task, TaskStatus.done);

    verifyNever(mockTimeTrackingRepository.updateTimeTracking(any));
    verify(mockCompletedTaskRepository.addCompletedTask(any)).called(1);
  });
}