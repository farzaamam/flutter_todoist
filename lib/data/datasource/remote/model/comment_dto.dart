import 'package:json_annotation/json_annotation.dart';
part 'comment_dto.g.dart';

@JsonSerializable()
class CommentDto {
  String id, content;

  CommentDto({required this.id, required this.content});

  factory CommentDto.fromJson(Map<String, dynamic> json) =>
      _$CommentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CommentDtoToJson(this);
}
