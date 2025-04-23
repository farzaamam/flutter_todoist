import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:todoist/domain/model/time_tracking.dart';
import 'package:todoist/domain/repository/time_tracking_repository.dart';
import 'package:todoist/domain/usecase/time_tracking_use_case.dart';

import 'time_tracking_use_case_test.mocks.dart';


@GenerateMocks([TimeTrackingRepository])
void main() {
  late MockTimeTrackingRepository mockRepository;
  late TimeTrackingUseCase useCase;
  const taskId = 'task-123';

  setUp(() {
    mockRepository = MockTimeTrackingRepository();
    useCase = TimeTrackingUseCase(repository: mockRepository);
  });

  test('start() creates and starts a new time tracking entry if not exists', () async {
    when(mockRepository.getTimeTrackingById(taskId)).thenAnswer((_) async => null);
    when(mockRepository.createTimeTracking(any)).thenAnswer((_) async {});
    when(mockRepository.updateTimeTracking(any)).thenAnswer((_) async {});

    await useCase.start(taskId);

    verify(mockRepository.createTimeTracking(any)).called(1);
    verify(mockRepository.updateTimeTracking(any)).called(1);
  });


  test('stop() updates the time tracking entry if it exists', () async {
    final existing = TaskTimeTracking(taskId: taskId);
    existing.start();

    when(mockRepository.getTimeTrackingById(taskId)).thenAnswer((_) async => existing);
    when(mockRepository.updateTimeTracking(any)).thenAnswer((_) async {});

    await useCase.stop(taskId);

    expect(existing.isRunning(), false);
    verify(mockRepository.updateTimeTracking(existing)).called(1);
  });

  test('stop() does nothing if no tracking exists', () async {
    when(mockRepository.getTimeTrackingById(taskId)).thenAnswer((_) async => null);

    await useCase.stop(taskId);

    verifyNever(mockRepository.updateTimeTracking(any));
  });

  test('getTimeTrackingByTaskId() returns tracking entry', () async {
    final tracking = TaskTimeTracking(taskId: taskId);
    when(mockRepository.getTimeTrackingById(taskId)).thenAnswer((_) async => tracking);

    final result = await useCase.getTimeTrackingByTaskId(taskId);

    expect(result, tracking);
  });
}