import 'package:flutter/material.dart';
import 'package:todoist/domain/model/task.dart';
import 'package:todoist/presentation/ui_utils.dart';
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
              decoration: BoxDecoration(
                color: color.withOpacity(
                  candidateData.isNotEmpty ? 0.15 : 0.05,
                ),
                border:
                    candidateData.isNotEmpty
                        ? Border.all(color: color, width: 2)
                        : null,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildColumnTitle(),
                  const SizedBox(height: 8),
                  _buildColumnList(),
                ],
              ),
            ),
      ),
    );
  }

  Widget _buildColumnList() {
    return Expanded(
      child: ListView(
        key: PageStorageKey(status.name),
        controller: scrollController,
        scrollDirection: isPortrait ? Axis.horizontal : Axis.vertical,
        children:
            tasks
                .map(
                  (task) => TaskCard(
                    task: task,
                    onTap: () => onTapTask(task),
                    isPortrait: isPortrait,
                    draggable: status != TaskStatus.done,
                  ),
                )
                .toList(),
      ),
    );
  }

  Widget _buildColumnTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          status == TaskStatus.toDo
              ? Icons.pending_actions
              : status == TaskStatus.inProgress
              ? Icons.play_circle_fill
              : Icons.check_circle,
          color: color,
        ),
        const SizedBox(width: 6),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color.darken(),
          ),
        ),
      ],
    );
  }
}
