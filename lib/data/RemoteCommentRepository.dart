import 'package:todoist/data/datasource/remote/remote_comment_datasource.dart';
import 'package:todoist/data/mapper.dart';
import 'package:todoist/domain/model/comment.dart';
import 'package:todoist/domain/repository/CommentRepository.dart';

class RemoteCommentRepository extends CommentRepository {
  final RemoteCommentDataSource remoteCommentDataSource;

  RemoteCommentRepository(this.remoteCommentDataSource);

  @override
  Future<Comment> createComment(String taskId, String content) async {
    return (await remoteCommentDataSource.createComment(
      taskId,
      content,
    )).toComment();
  }

  @override
  Future<List<Comment>> getComments(String taskId) async {
    return (await remoteCommentDataSource.getComments(
      taskId,
    )).map((dto) => dto.toComment()).toList();
  }
}
