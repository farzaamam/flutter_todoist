import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoist/presentation/task_detail/widget/comment_widget.dart';
import 'package:todoist/presentation/task_detail/widget/timer_widget.dart';
import '../../../domain/model/task.dart';

class TaskDetailPage extends ConsumerWidget {
  final Task task;

  const TaskDetailPage({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final task = ref.watch(taskProvider(taskId)); // ← plug in your provider
    // final comments = ref.watch(commentsProvider(taskId)); // ← comments stream
    // final timer = ref.watch(taskTimerProvider(taskId)); // ← timer provider

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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title & Description
            Text(
              task.content,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              task.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            const SizedBox(height: 16),
            const Divider(height: 32),

            // Timer
            TimerWidget(taskId: task.id),

            const Divider(height: 32),

            // Comments List
            CommentWidget(taskId: task.id)
          ],
        ),
      ),
    );
  }
}
