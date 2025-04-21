// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_task_status_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateTaskStatusRequestDto _$UpdateTaskStatusRequestDtoFromJson(
  Map<String, dynamic> json,
) => UpdateTaskStatusRequestDto(
  labels: (json['labels'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$UpdateTaskStatusRequestDtoToJson(
  UpdateTaskStatusRequestDto instance,
) => <String, dynamic>{'labels': instance.labels};
