import 'package:json_annotation/json_annotation.dart';

part 'completed_task_request_dto.g.dart';

@JsonSerializable()
class CompletedTaskRequestDto {
  bool is_completed;

  CompletedTaskRequestDto({required this.is_completed});

  factory CompletedTaskRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CompletedTaskRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CompletedTaskRequestDtoToJson(this);
}
