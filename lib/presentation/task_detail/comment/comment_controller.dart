import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoist/di/global_providers.dart';
import 'package:todoist/domain/model/comment.dart';
import 'package:todoist/domain/repository/CommentRepository.dart';

final commentControllerProvider = StateNotifierProvider.autoDispose
    .family<CommentController, CommentState, String>((ref, taskId) {
      final repo = ref.watch(commentRepositoryProvider);

      return CommentController(taskId: taskId, repository: repo);
    });

class CommentController extends StateNotifier<CommentState> {
  final CommentRepository repository;
  final String taskId;

  CommentController({required this.taskId, required this.repository})
    : super(CommentState()) {
    _init();
  }

  _init() async {
    try {
      state = state.copyWith(comment: AsyncValue.loading());
      final comments = await repository.getComments(taskId);
      state = state.copyWith(comment: AsyncValue.data(comments));
    } catch (e, st) {
      state = state.copyWith(comment: AsyncValue.error(e, st));
    }
  }

  createComment(String content) async {
    try {
      state = state.copyWith(isCreatingComments: true);
      final comment = await repository.createComment(taskId, content);
      state.comments.value?.add(comment);
      state = state.copyWith(
        isCreatingComments: false,
      );
    } catch (e, _) {
      state = state.copyWith(isCreatingComments: false);
    }
  }
}

class CommentState {
  AsyncValue<List<Comment>> comments;

  bool isCreatingComment;

  CommentState({
    this.comments = const AsyncLoading(),
    this.isCreatingComment = false,
  });

  CommentState copyWith({
    AsyncValue<List<Comment>>? comment,
    bool? isCreatingComments,
  }) {
    return CommentState(
      comments: comment ?? comments,
      isCreatingComment: isCreatingComments ?? isCreatingComment,
    );
  }
}
