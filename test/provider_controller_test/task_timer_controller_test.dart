import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todoist/domain/model/time_tracking.dart';
import 'package:todoist/domain/usecase/time_tracking_use_case.dart';
import 'package:todoist/presentation/task_detail/time_tracking/task_timer_controller.dart';
import 'task_timer_controller_test.mocks.dart';

@GenerateMocks([TimeTrackingUseCase])
void main() {
  MockTimeTrackingUseCase mockUseCase = MockTimeTrackingUseCase();
  const taskId = 'task_1';

  var mockTimeTracking = TaskTimeTracking(taskId: taskId);
  setUp(() {
    mockTimeTracking.setStartedAt(
      (DateTime.now().millisecondsSinceEpoch ~/ 1000),
    );
  });
  test(
    'initial state sets is not running and sets duration from the UseCase',
    () async {
      when(
        mockUseCase.getTimeTrackingByTaskId(taskId),
      ).thenAnswer((_) async => mockTimeTracking);
      final controller = TimerController(taskId: taskId, useCase: mockUseCase);

      expect(controller.state.isRunning, false);
      expect(controller.state.duration, mockTimeTracking.getTotalTrackedTime());
    },
  );

  test('toggle() starts timer when not running', () async {
    when(
      mockUseCase.getTimeTrackingByTaskId(taskId),
    ).thenAnswer((_) async => null);
    when(mockUseCase.start(taskId)).thenAnswer((_) async => mockTimeTracking);

    final controller = TimerController(taskId: taskId, useCase: mockUseCase);

    await controller.toggle();

    expect(controller.state.isRunning, true);
    verify(mockUseCase.start(taskId)).called(1);
  });
}
