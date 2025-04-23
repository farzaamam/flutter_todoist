import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:todoist/domain/model/comment.dart';
import 'package:todoist/domain/repository/comment_repository.dart';
import 'package:todoist/presentation/task_detail/comment/comment_controller.dart';

import 'coment_controller_test.mocks.dart';

@GenerateMocks([CommentRepository])
void main() {
  MockCommentRepository mockRepository = MockCommentRepository();
  const taskId = 'task-1';

  test('initial state is loading and then data is loaded', () async {
    final mockComments = [Comment(id: '1', content: 'Test comment')];
    when(
      mockRepository.getComments(taskId),
    ).thenAnswer((_) async => mockComments);
    final controller = CommentController(
      taskId: taskId,
      repository: mockRepository,
    );

    expect(controller.state.comments, isA<AsyncLoading>());

    // Wait for _init to complete
    await Future.delayed(Duration.zero);

    expect(controller.state.comments, AsyncValue.data(mockComments));
    expect(controller.state.isCreatingComment, false);
  });

  test('state goes to error if getComments throws', () async {
    when(mockRepository.getComments(taskId)).thenThrow(Exception('error'));

    final controller = CommentController(
      taskId: taskId,
      repository: mockRepository,
    );

    await Future.delayed(Duration.zero);

    expect(controller.state.comments.hasError, true);
  });

  test('createComment updates state and adds comment to list', () async {
    final initialComment = Comment(id: '1', content: 'Initial');
    final newComment = Comment(id: '2', content: 'New one');

    when(
      mockRepository.getComments(taskId),
    ).thenAnswer((_) async => [initialComment]);
    when(
      mockRepository.createComment(taskId, 'New one'),
    ).thenAnswer((_) async => newComment);

    final controller = CommentController(
      taskId: taskId,
      repository: mockRepository,
    );
    await Future.delayed(Duration.zero); // wait for _init()

    await controller.createComment('New one');

    final commentList = controller.state.comments.value!;
    expect(controller.state.isCreatingComment, false);
    expect(commentList.length, 2);
    expect(commentList.last.content, 'New one');
  });

  test('createComment handles error and resets isCreatingComment', () async {
    when(mockRepository.getComments(taskId)).thenAnswer((_) async => []);
    when(
      mockRepository.createComment(taskId, 'fail'),
    ).thenThrow(Exception('fail'));

    final controller = CommentController(
      taskId: taskId,
      repository: mockRepository,
    );
    await Future.delayed(Duration.zero);

    await controller.createComment('fail');

    expect(controller.state.isCreatingComment, false);
  });
}
