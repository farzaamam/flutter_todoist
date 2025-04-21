// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskDto _$TaskDtoFromJson(Map<String, dynamic> json) => TaskDto(
  json['content'] as String,
  json['description'] as String,
  json['id'] as String,
  json['url'] as String,
  json['is_completed'] as bool,
  (json['labels'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$TaskDtoToJson(TaskDto instance) => <String, dynamic>{
  'content': instance.content,
  'description': instance.description,
  'id': instance.id,
  'url': instance.url,
  'labels': instance.labels,
  'is_completed': instance.is_completed,
};
