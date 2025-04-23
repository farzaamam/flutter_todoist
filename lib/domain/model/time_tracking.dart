class TaskTimeTracking {
  int _startedAt = 0;
  int _duration = 0;
  String taskId;

  TaskTimeTracking({required this.taskId});

  bool isRunning() {
    return _startedAt != 0;
  }

  void start() {
    final nowInSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    _startedAt = nowInSeconds;
  }

  int getTotalTrackedTime() {
    final nowInSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    if (isRunning()) {
      return _duration + (nowInSeconds - _startedAt);
    } else {
      return _duration;
    }
  }

  int getStartedAt() => _startedAt;

  void setStartedAt(int time) {
    _startedAt = time;
  }

  int getDuration() => _duration;

  void setDuration(int time) {
    _duration = time;
  }

  void stop() {
    final nowInSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final updatedDuration = _duration + (nowInSeconds - _startedAt);

    _duration = updatedDuration;
    _startedAt = 0;
  }
}
