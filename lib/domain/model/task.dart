class Task {
  final String content, description, id, url;
  TaskStatus status;

  Task(this.content, this.description, this.id, this.url, this.status);

  Task copyWith({required TaskStatus newStatus}) {
    return Task(content, description, id, url, newStatus);
  }
}

enum TaskStatus { toDo, inProgress, done }
