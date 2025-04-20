import 'package:todoist/data/datasource/model/task_dto.dart';
import 'package:todoist/domain/model/task.dart';

extension TaskDtoMapper on TaskDto {
  Task toTask() => Task(content, description, id, url,TaskStatus.toDo);
}
