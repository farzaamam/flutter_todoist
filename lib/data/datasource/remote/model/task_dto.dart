import 'package:json_annotation/json_annotation.dart';

part 'task_dto.g.dart';

@JsonSerializable()
class TaskDto {
  final String content, description, id, url;
  List<String> labels;
  bool is_completed;

  TaskDto(
    this.content,
    this.description,
    this.id,
    this.url,
    this.is_completed,
    this.labels,
  );

  factory TaskDto.fromJson(Map<String, dynamic> json) =>
      _$TaskDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TaskDtoToJson(this);
}
