import 'package:dio/dio.dart';
import 'package:todoist/data/datasource/remote/model/comment_dto.dart';
import 'package:todoist/data/datasource/remote/model/create_comment_dto.dart';

class RemoteCommentDataSource {
  final Dio dio;

  RemoteCommentDataSource({required this.dio});

  Future<List<CommentDto>> getComments(String taskId) async {
    try {
      final response = await dio.get('comments?task_id=$taskId');
      final comments =
          (response.data as List).map((e) => CommentDto.fromJson(e)).toList();
      return comments;
    } catch (e) {
      rethrow;
    }
  }

  Future<CommentDto> createComment(String taskId, String content) async {
    try {
      final response = await dio.post(
        'comments',
        data: CreateCommentDto(content: content, task_id: taskId).toJson(),
      );
      return CommentDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
