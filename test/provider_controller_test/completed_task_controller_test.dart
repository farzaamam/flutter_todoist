import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:todoist/domain/model/completed_task_history.dart';
import 'package:todoist/domain/repository/completed_task_repository.dart';
import 'package:todoist/presentation/history/completed_task_controller.dart';

import 'completed_task_controller_test.mocks.dart';

@GenerateMocks([CompletedTaskRepository])
void main() {
  late MockCompletedTaskRepository mockRepository;
  late StreamController<List<CompletedTaskHistory>> streamController;
  late CompletedTasksController controller;

  setUp(() {
    mockRepository = MockCompletedTaskRepository();
    streamController = StreamController<List<CompletedTaskHistory>>();

    when(
      mockRepository.watchCompletedTasksFromDb(),
    ).thenAnswer((_) => streamController.stream);

    controller = CompletedTasksController(mockRepository);
  });

  tearDown(() async {
    await streamController.close();
  });

  test('initial state is loading', () {
    expect(controller.state, const AsyncLoading<List<CompletedTaskHistory>>());
  });

  test('emits data when stream emits tasks', () async {
    final mockTask = CompletedTaskHistory(
      '1',
      'Test Task',
      '233232',
      90,
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
    );

    streamController.add([mockTask]);

    // Wait a tick for stream to emit
    await Future.delayed(Duration.zero);

    expect(controller.state.value!.first.id, AsyncData<List<CompletedTaskHistory>>([mockTask]).value.first.id);
  });

  test('emits error when stream emits error', () async {
    final error = Exception('Stream error');
    streamController.addError(error);

    await Future.delayed(Duration.zero);

    expect(controller.state.hasError, true);
    expect(controller.state.asError!.error, error);
  });
}
