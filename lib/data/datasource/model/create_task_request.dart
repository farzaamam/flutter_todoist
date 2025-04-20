import 'package:json_annotation/json_annotation.dart';

part 'create_task_request.g.dart';

@JsonSerializable()
class CreateTaskRequest {
  final String content, description;

  CreateTaskRequest({required this.content, required this.description});

  factory CreateTaskRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateTaskRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateTaskRequestToJson(this);
}
