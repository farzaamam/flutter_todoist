class TaskTimeTracking {
  int startedAt = 0;
  int duration = 0;
  String taskId;


  TaskTimeTracking({
    required this.taskId,
    required this.startedAt,
    required this.duration,
  });


  bool isRunning(){
    return startedAt != 0;
  }
}
