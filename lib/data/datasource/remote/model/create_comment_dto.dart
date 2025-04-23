import 'package:json_annotation/json_annotation.dart';

part 'create_comment_dto.g.dart';

@JsonSerializable()
class CreateCommentDto {
  String task_id;
  String content;

  CreateCommentDto({required this.task_id, required this.content});
  factory CreateCommentDto.fromJson(Map<String, dynamic> json) =>
      _$CreateCommentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCommentDtoToJson(this);
}