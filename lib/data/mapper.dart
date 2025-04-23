import 'package:todoist/data/datasource/db/database.dart';
import 'package:todoist/data/datasource/remote/model/comment_dto.dart';
import 'package:todoist/data/datasource/remote/model/task_dto.dart';
import 'package:todoist/domain/model/comment.dart';
import 'package:todoist/domain/model/completed_task_history.dart';
import 'package:todoist/domain/model/task.dart';
import 'package:todoist/domain/model/time_tracking.dart';

extension TaskDtoMapper on TaskDto {
  Task toTask() {
    final label = labels.firstOrNull;

    final status = mapLabelToStatus(label);

    return Task(
      content,
      description,
      id,
      url,
      is_completed ? TaskStatus.done : status,
    );
  }
}

TaskStatus mapLabelToStatus(String? label) {
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
    );
  }
}

extension TimeTrackingTableMapper on TimeTrackingTable {
  TaskTimeTracking toTaskTimeTracking() {
    final timeTracking = TaskTimeTracking(taskId: id);
    timeTracking.setDuration(duration);
    timeTracking.setStartedAt(startedAt);
    return timeTracking;
  }
}

extension TaskTimeTrackingMapper on TaskTimeTracking {
  TimeTrackingTable toTimeTrackingTable() {
    return TimeTrackingTable(
      id: taskId,
      startedAt: getStartedAt(),
      duration: getDuration(),
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

extension CommentDtoMapper on CommentDto {
  Comment toComment() {
    return Comment(id: id, content: content);
  }
}

extension CompletedTaskHistoryMapper on CompletedTaskHistory {
  CompletedTaskHistoryTable toTable() {
    return CompletedTaskHistoryTable(
      id: id,
      title: content,
      description: description,
      completedAt: completedAt,
      duration: duration,
    );
  }
}

extension CompletedTaskHistoryTableMapper on CompletedTaskHistoryTable {
  CompletedTaskHistory toDomain() {
    return CompletedTaskHistory(title, description, id, duration, completedAt);
  }
}
