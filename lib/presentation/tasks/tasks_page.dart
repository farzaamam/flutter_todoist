import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoist/domain/model/task.dart';
import 'package:todoist/presentation/create_task/create_task_page.dart';
import 'package:todoist/presentation/tasks/tasks_controller.dart';
import 'package:todoist/presentation/tasks/widgets/task_column.dart';

class TasksPage extends ConsumerStatefulWidget {
  const TasksPage({super.key});

  @override
  ConsumerState<TasksPage> createState() => _TasksPage();
}

class _TasksPage extends ConsumerState<TasksPage> {
  final _toDoController = ScrollController();
  final _inProgressController = ScrollController();
  final _doneController = ScrollController();

  @override
  void dispose() {
    _toDoController.dispose();
    _inProgressController.dispose();
    _doneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tasksControllerProvider);
    final controller = ref.read(tasksControllerProvider.notifier);
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kanban Board'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_task),
            tooltip: 'Create Task',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CreateTaskPage()),
              );
            },
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
        data: (tasks) {
          final columns = _buildTaskColumns(tasks, isPortrait, (task, status) {
            controller.updateTaskStatus(task, status);
          }, (Task task) {});
          return isPortrait
              ? Column(children: columns)
              : Row(children: columns);
        },
      ),
    );
  }

  List<Widget> _buildTaskColumns(
    List<Task> tasks,
    bool isPortrait,
    Function(Task task, TaskStatus newStatus) onDropTask,
    Function(Task task) onTapTask,
  ) {
    List<Task> filtered(TaskStatus status) =>
        tasks.where((task) => task.status == status).toList();
    return [
      TaskColumn(
        title: 'To Do',
        status: TaskStatus.toDo,
        color: Colors.blue,
        tasks: filtered(TaskStatus.toDo),
        onDropTask: onDropTask,
        onTapTask: onTapTask,
        isPortrait: isPortrait,
        scrollController: _toDoController,
      ),
      TaskColumn(
        title: 'In Progress',
        status: TaskStatus.inProgress,
        color: Colors.orange,
        tasks: filtered(TaskStatus.inProgress),
        onDropTask: onDropTask,
        onTapTask: onTapTask,
        isPortrait: isPortrait,
        scrollController: _inProgressController,
      ),
      TaskColumn(
        title: 'Done',
        status: TaskStatus.done,
        color: Colors.green,
        tasks: filtered(TaskStatus.done),
        onDropTask: onDropTask,
        onTapTask: onTapTask,
        isPortrait: isPortrait,
        scrollController: _doneController,
      ),
    ];
  }
}
