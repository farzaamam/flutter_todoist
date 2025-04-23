import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todoist/domain/model/completed_task_history.dart';
import 'package:todoist/presentation/history/completed_task_controller.dart';

class CompletedTasksHistoryPage extends ConsumerWidget {
  const CompletedTasksHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completedTasks = ref.watch(completedTasksControllerProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text('Completed Tasks'),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.black,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: completedTasks.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (tasks) {
          if (tasks.isEmpty) {
            return const Center(
              child: Text(
                'No completed tasks yet.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: tasks.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, index) => _CompletedTaskTile(task: tasks[index]),
          );
        },
      ),
    );
  }
}

class _CompletedTaskTile extends StatelessWidget {
  final CompletedTaskHistory task;

  const _CompletedTaskTile({required this.task});

  @override
  Widget build(BuildContext context) {
    final duration = Duration(seconds: task.duration);
    final formattedDate = DateFormat.yMMMd().add_jm().format(
      DateTime.fromMillisecondsSinceEpoch(task.completedAt * 1000),
    );

    return ListTile(
      tileColor: Colors.grey.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      leading: const Icon(Icons.check_circle, color: Colors.green),
      title: Text(
        task.content,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Text(
          'Time spent: ${_formatDuration(duration)}\nCompleted: $formattedDate',
          style: const TextStyle(fontSize: 13, height: 1.4),
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) return '${hours}h ${minutes}m ${seconds}s';
    if (minutes > 0) return '${minutes}m ${seconds}s';
    return '${seconds}s';
  }
}
