// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_task_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateTaskResponse _$CreateTaskResponseFromJson(Map<String, dynamic> json) =>
    CreateTaskResponse(
      id: json['id'] as String,
      content: json['content'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$CreateTaskResponseToJson(CreateTaskResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'description': instance.description,
      'url': instance.url,
    };
