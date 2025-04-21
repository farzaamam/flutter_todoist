// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_task_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateTaskRequestDto _$CreateTaskRequestDtoFromJson(
  Map<String, dynamic> json,
) => CreateTaskRequestDto(
  content: json['content'] as String,
  description: json['description'] as String,
);

Map<String, dynamic> _$CreateTaskRequestDtoToJson(
  CreateTaskRequestDto instance,
) => <String, dynamic>{
  'content': instance.content,
  'description': instance.description,
};
