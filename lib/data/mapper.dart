import 'package:todoist/data/datasource/db/database.dart';
import 'package:todoist/data/datasource/remote/model/task_dto.dart';
import 'package:todoist/domain/model/task.dart';
import 'package:todoist/domain/model/time_tracking.dart';

extension TaskDtoMapper on TaskDto {
  Task toTask() {
    final label = labels.firstOrNull;

    final status = _mapLabelToStatus(label);

    return Task(
      content,
      description,
      id,
      url,
      is_completed ? TaskStatus.done : status,
    );
  }

  TaskStatus _mapLabelToStatus(String? label) {
    switch (label) {
      case 'toDo':
        return TaskStatus.toDo;
      case 'inProgress':
        return TaskStatus.inProgress;
      case 'done':
        return TaskStatus.done;
      default:
        return TaskStatus.toDo;
    }
  }
}

extension TaskStatusLabelExtension on TaskStatus {
  String get label {
    switch (this) {
      case TaskStatus.toDo:
        return 'toDo';
      case TaskStatus.inProgress:
        return 'inProgress';
      case TaskStatus.done:
        return 'done';
    }
  }
}

extension TaskMapper on Task {
  TodoItem toEntity() {
    return TodoItem(
      id: id,
      title: content,
      description: description,
      status: status.name,
      url: url,
      createdAt: DateTime.now(),
    );
  }
}

extension TimeTrackingTableMapper on TimeTrackingTable {
  TaskTimeTracking? toTaskTimeTracking() {
    return TaskTimeTracking(
      taskId: id,
      startedAt: startedAt,
      duration: duration,
    );
  }
}

extension TaskTimeTrackingMapper on TaskTimeTracking {
  TimeTrackingTable toTaskTimeTracking() {
    return TimeTrackingTable(
      id: taskId,
      startedAt: startedAt,
      duration: duration,
    );
  }
}

extension TodoItemMapper on TodoItem {
  Task toTask() {
    return Task(
      title,
      description,
      id,
      url,
      TaskStatus.values.firstWhere(
        (e) => e.name == status,
        orElse: () => TaskStatus.toDo,
      ),
    );
  }
}
