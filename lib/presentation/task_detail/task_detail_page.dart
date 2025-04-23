import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoist/presentation/task_detail/comment/comment_widget.dart';
import 'package:todoist/presentation/task_detail/time_tracking/timer_widget.dart';
import '../../../domain/model/task.dart';

class TaskDetailPage extends ConsumerWidget {
  final Task task;

  const TaskDetailPage({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Detail"),
        actions: [
          /*  IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // TODO: Trigger delete confirmation & action
            },
          ),*/
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              task.content,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              task.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            const Divider(height: 32),
            TimerWidget(
              taskId: task.id,
              isCompleted: task.status == TaskStatus.done,
            ),
            const Divider(height: 32),
            CommentWidget(taskId: task.id),
          ],
        ),
      ),
    );
  }
}
