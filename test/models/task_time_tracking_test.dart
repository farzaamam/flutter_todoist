import 'package:flutter_test/flutter_test.dart';
import 'package:todoist/domain/model/time_tracking.dart';

void main() {
  group('TaskTimeTracking', () {
    const testTaskId = 'task-123';
    late TaskTimeTracking tracking;

    setUp(() {
      tracking = TaskTimeTracking(taskId: testTaskId);
    });

    test('initial state is not running and duration is zero', () {
      expect(tracking.isRunning(), false);
      expect(tracking.getStartedAt(), 0);
      expect(tracking.getDuration(), 0);
      expect(tracking.getTotalTrackedTime(), 0);
    });

    test('start() sets startedAt and isRunning returns true', () {
      tracking.start();

      expect(tracking.getStartedAt(), isNonZero);
      expect(tracking.isRunning(), true);
    });

    test('getTotalTrackedTime() increases after start', () async {
      tracking.start();
      final startTrackedTime = tracking.getTotalTrackedTime();

      await Future.delayed(const Duration(seconds: 2));

      final laterTrackedTime = tracking.getTotalTrackedTime();
      expect(laterTrackedTime, greaterThan(startTrackedTime));
    });

    test('stop() updates duration and resets startedAt', () async {
      tracking.start();

      await Future.delayed(const Duration(seconds: 2));

      tracking.stop();

      expect(tracking.isRunning(), false);
      expect(tracking.getStartedAt(), 0);
      expect(tracking.getDuration(), greaterThan(0));
      expect(
        tracking.getDuration(),
        closeTo(tracking.getTotalTrackedTime(), 1),
      );
    });

    test('stop() has no effect if not running', () {
      tracking.setDuration(42);
      tracking.stop();

      expect(tracking.getDuration(), 42);
      expect(tracking.getStartedAt(), 0);
    });

    test('setStartedAt() and setDuration() work correctly', () {
      tracking.setStartedAt(123456);
      tracking.setDuration(789);

      expect(tracking.getStartedAt(), 123456);
      expect(tracking.getDuration(), 789);
    });
  });
}
