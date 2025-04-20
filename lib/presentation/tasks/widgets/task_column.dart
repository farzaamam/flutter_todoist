import 'package:flutter/material.dart';
import 'package:todoist/domain/model/task.dart';
import 'task_card.dart';

class TaskColumn extends StatelessWidget {
  final String title;
  final Color color;
  final TaskStatus status;
  final List<Task> tasks;
  final bool isPortrait;
  final void Function(Task task, TaskStatus newStatus) onDropTask;
  final void Function(Task task) onTapTask;
  final ScrollController scrollController;

  const TaskColumn({
    super.key,
    required this.title,
    required this.color,
    required this.status,
    required this.tasks,
    required this.onDropTask,
    required this.onTapTask,
    required this.isPortrait,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DragTarget<Task>(
        onWillAcceptWithDetails: (_) => true,
        onAccept: (task) => onDropTask(task, status),
        builder:
            (context, candidateData, rejectedData) => Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: color.withOpacity(0.1)),
              child: Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView(
                      key: PageStorageKey(status.name),
                      controller: scrollController,
                      scrollDirection:
                          isPortrait ? Axis.horizontal : Axis.vertical,
                      children:
                          tasks
                              .map(
                                (task) => TaskCard(
                                  task: task,
                                  onTap: () => onTapTask(task),
                                  isPortrait: isPortrait,
                                ),
                              )
                              .toList(),
                    ),
                  ),
                  if (candidateData.isNotEmpty)
                    const Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: Text(
                        "Drop Here",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                ],
              ),
            ),
      ),
    );
  }
}
