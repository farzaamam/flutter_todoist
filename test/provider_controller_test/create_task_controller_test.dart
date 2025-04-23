import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todoist/domain/usecase/create_task_use_case.dart';
import 'package:todoist/presentation/create_task/create_task_controller.dart';
import 'create_task_controller_test.mocks.dart';

@GenerateMocks([CreateTaskUseCase])
void main() {
  late CreateTaskController controller;
  final createTaskUseCase = MockCreateTaskUseCase();
  final dummyTitle = 'tt';
  final dummyDescription = "desc";
  setUp(() {
    controller = CreateTaskController(createTaskUseCase: createTaskUseCase);
  });

  test('initial state is correct', () {
    expect(controller.state.title, '');
    expect(controller.state.description, '');
    expect(controller.state.isSubmitting, false);
  });

  test('setTitle updates state', () {
    controller.setTitle(dummyTitle);
    expect(controller.state.title, dummyTitle);
  });

  test('setDescription updates state', () {
    controller.setDescription(dummyDescription);
    expect(controller.state.description, dummyDescription);
  });

  test(
    'when createTaskUseCase returns success submit updates state properly and returns true',
    () async {
      when(
        createTaskUseCase.execute(any, any),
      ).thenAnswer((_) async => Future.value());

      controller.setTitle(dummyTitle);
      controller.setDescription(dummyDescription);

      final future = controller.submit();
      expect(controller.state.isSubmitting, true);

      bool result = await future;
      expect(true, result);
      expect(controller.state.isSubmitting, false);
      verify(createTaskUseCase.execute(dummyTitle, dummyDescription)).called(1);
    },
  );

  test('when createTaskUseCase returns error submit returns false', () async {
    when(createTaskUseCase.execute(any, any)).thenThrow(Exception('fail'));

    controller.setTitle(dummyTitle);

    bool result = await controller.submit();

    expect(false, result);
    expect(controller.state.isSubmitting, false);
    verify(createTaskUseCase.execute(dummyTitle, '')).called(1);
  });
}
