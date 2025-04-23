// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_comment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCommentDto _$CreateCommentDtoFromJson(Map<String, dynamic> json) =>
    CreateCommentDto(
      task_id: json['task_id'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$CreateCommentDtoToJson(CreateCommentDto instance) =>
    <String, dynamic>{'task_id': instance.task_id, 'content': instance.content};
