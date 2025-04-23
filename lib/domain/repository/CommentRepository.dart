import 'package:todoist/domain/model/comment.dart';

abstract class CommentRepository {
  Future<Comment> createComment(String taskId, String content);

  Future<List<Comment>> getComments(String taskId);
}
