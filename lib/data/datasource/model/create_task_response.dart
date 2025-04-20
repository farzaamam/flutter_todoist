import 'package:json_annotation/json_annotation.dart';
part 'create_task_response.g.dart';

@JsonSerializable()
class CreateTaskResponse {
  final String id, content, description,url;

  CreateTaskResponse({required this.id, required this.content, required this.description,required this.url,});
  factory CreateTaskResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateTaskResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateTaskResponseToJson(this);
}