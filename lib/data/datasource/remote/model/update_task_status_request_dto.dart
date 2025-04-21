
import 'package:json_annotation/json_annotation.dart';
part 'update_task_status_request_dto.g.dart';

@JsonSerializable()
class UpdateTaskStatusRequestDto{
   final List<String> labels;
   UpdateTaskStatusRequestDto({required this.labels});

   factory UpdateTaskStatusRequestDto.fromJson(Map<String, dynamic> json) =>
       _$UpdateTaskStatusRequestDtoFromJson(json);

   Map<String, dynamic> toJson() => _$UpdateTaskStatusRequestDtoToJson(this);
}