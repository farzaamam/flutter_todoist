import 'package:json_annotation/json_annotation.dart';

part 'create_task_request_dto.g.dart';

@JsonSerializable()
class CreateTaskRequestDto {
  final String content, description;

  CreateTaskRequestDto({required this.content, required this.description});

  factory CreateTaskRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateTaskRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateTaskRequestDtoToJson(this);
}
