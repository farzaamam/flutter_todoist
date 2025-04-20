import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoist/presentation/tasks/tasks_controller.dart';

class TaskHistoryPage extends ConsumerWidget {
  const TaskHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTasks = ref.watch(tasksControllerProvider);

    return asyncTasks.when(
      data: (tasks) => ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (_, i) => ListTile(
          title: Text(tasks[i].content),
          subtitle: Text(tasks[i].description),
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('Error: $err')),
    );
  }
}